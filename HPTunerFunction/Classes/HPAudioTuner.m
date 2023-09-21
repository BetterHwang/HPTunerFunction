//
//  HPAudioTuner.m
//  HPTunerFunction
//
//  Created by East on 2023/9/15.
//

#import <AVFoundation/AVFoundation.h>
#import "HPAudioTuner.h"
#import "HPPitchTracker.h"

@interface HPAudioTuner () {
    AVAudioEngine* engine;
    
}

@end

@implementation HPAudioTuner

- (instancetype)init {
    self = [super init];
    if (self) {
        engine = [[AVAudioEngine alloc] init];
        return self;
    }
    
    return nil;
}

- (void)startMIC {
    [engine stop];
    [engine reset];
    
    AVAudioInputNode* inputNode = [engine inputNode];
    [inputNode removeTapOnBus:0];
    
    int bufferSize = [HPPitchTracker defaultBufferSize];
    
    __weak typeof(self) weakSelf = self;
    [inputNode installTapOnBus:0 bufferSize:(AVAudioFrameCount)bufferSize format:nil block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(self) strongSelf = weakSelf;
        
        HPPitchTracker *pitchTracker = [[HPPitchTracker alloc] initWithSampleRate:(int)buffer.format.sampleRate hopSize:bufferSize peakCount:20];
        double pitch = [pitchTracker getPitchWithBuffer:buffer amplitudeThreshold:0.1];
        
        if (pitch <= 0) {
            return;
        }
        
        HPNoteInfo *noteInfo = [[HPNoteInfo alloc] initWithFreq:pitch];
        
        if (nil != [strongSelf delegate]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(self) strongSelf = weakSelf;
                if (!strongSelf) {
                    return;
                }
                
                [[strongSelf delegate] audioTuner:self didGetNoteInfo:noteInfo];
            });
        }
    }];
    
    NSError *error;
    [engine startAndReturnError:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void)stop {
    [engine stop];
    [engine reset];
    [[engine inputNode] removeTapOnBus:0];
}

@end
