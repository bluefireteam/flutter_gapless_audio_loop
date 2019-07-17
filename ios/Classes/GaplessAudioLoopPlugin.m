#import "GaplessAudioLoopPlugin.h"
#import <gapless_audio_loop/gapless_audio_loop-Swift.h>

@implementation GaplessAudioLoopPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGaplessAudioLoopPlugin registerWithRegistrar:registrar];
}
@end
