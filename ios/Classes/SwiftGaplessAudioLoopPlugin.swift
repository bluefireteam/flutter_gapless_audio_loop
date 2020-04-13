import Flutter
import UIKit
import AVFoundation

struct Player {
    var player: AVQueuePlayer?
    var playerLooper: AVPlayerLooper?
}

public class SwiftGaplessAudioLoopPlugin: NSObject, FlutterPlugin {
    static var players = [Int: Player]()
    static var id: Int = 0;
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "gapless_audio_loop", binaryMessenger: registrar.messenger())
        let instance = SwiftGaplessAudioLoopPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "play") {
            guard let args = call.arguments else {
                return;
            }
            
            if let myArgs = args as? [String: Any],
                let url: String = myArgs["url"] as? String,
                let volume: Double = myArgs["volume"] as? Double {
                
                // Get url
                let asset = AVAsset(url: URL(fileURLWithPath: url ))
                let playerItem = AVPlayerItem(asset: asset)
                
                let player = AVQueuePlayer(items: [playerItem])
                let playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
                
                player.play()
                
                player.volume = Float(volume)
                
                let id = SwiftGaplessAudioLoopPlugin.id
                SwiftGaplessAudioLoopPlugin.players[id] = Player(player: player, playerLooper: playerLooper)

                SwiftGaplessAudioLoopPlugin.id = SwiftGaplessAudioLoopPlugin.id + 1
                
                result(id)
            }
        } else if (call.method == "stop" || call.method == "pause") {
            guard let args = call.arguments else {
                return;
            }
            
            if let myArgs = args as? [String: Any],
                let playerId: Int = myArgs["playerId"] as? Int {
                
                let player = SwiftGaplessAudioLoopPlugin.players[playerId]
                player?.player?.pause()
                if (call.method == "stop") {
                    SwiftGaplessAudioLoopPlugin.players[playerId] = nil
                }
            }
        } else if (call.method == "setVolume") {
            guard let args = call.arguments else {
                return;
            }
            
            if let myArgs = args as? [String: Any],
                let playerId: Int = myArgs["playerId"] as? Int,
                let volume: Double = myArgs["volume"] as? Double {
                
                let player = SwiftGaplessAudioLoopPlugin.players[playerId]
                player?.player?.volume = Float(volume)
            }
        } else if (call.method == "resume") {
            guard let args = call.arguments else {
                return;
            }
            
            if let myArgs = args as? [String: Any],
                let playerId: Int = myArgs["playerId"] as? Int {
                
                let player = SwiftGaplessAudioLoopPlugin.players[playerId]
                player?.player?.play()
            }
        } else if (call.method == "seek") {
                guard let args = call.arguments else {
                    return;
                }
                
                if let myArgs = args as? [String: Any],
                    let playerId: Int = myArgs["playerId"] as? Int,
                    let positionInMillis: Int = myArgs["position"] as? Int {
                    
                    let player = SwiftGaplessAudioLoopPlugin.players[playerId]
                    player?.player?.seek(to: CMTimeMakeWithSeconds(Float64(positionInMillis / 1000), preferredTimescale: Int32(NSEC_PER_SEC)))
                }
        }
    }
}

