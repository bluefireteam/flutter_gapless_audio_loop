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
                let url: String = myArgs["url"] as? String {
                
                // Get url
                let asset = AVAsset(url: URL(fileURLWithPath: url ))
                let playerItem = AVPlayerItem(asset: asset)
                
                let player = AVQueuePlayer(items: [playerItem])
                let playerLooper = AVPlayerLooper(player: player, templateItem: playerItem)
                
                player.play()
                
                SwiftGaplessAudioLoopPlugin.players[SwiftGaplessAudioLoopPlugin.id] = Player(player: player, playerLooper: playerLooper)

                SwiftGaplessAudioLoopPlugin.id = SwiftGaplessAudioLoopPlugin.id + 1
            }
        } else if (call.method == "stop") {
            guard let args = call.arguments else {
                return;
            }
            
            if let myArgs = args as? [String: Any],
                let playerId: Int = myArgs["playerId"] as? Int {
                
                let player = SwiftGaplessAudioLoopPlugin.players[playerId]
                player?.player?
            }
        }
    }
}
