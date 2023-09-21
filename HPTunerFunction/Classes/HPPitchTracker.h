//
//  HPPitchTracker.h
//  HPTunerFunction
//
//  Created by East on 2023/9/15.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPPitchTracker : NSObject

+(int)defaultBufferSize;
- (instancetype)initWithSampleRate:(int)sampleRate hopSize:(int)hopSize peakCount:(int)peakCount;
- (double)getPitchWithBuffer:(AVAudioPCMBuffer *)buffer amplitudeThreshold:(double)amplitudeThreshold;

@end

NS_ASSUME_NONNULL_END
