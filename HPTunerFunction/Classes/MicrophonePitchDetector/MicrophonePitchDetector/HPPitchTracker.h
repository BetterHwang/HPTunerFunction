//
//  HPPitchTracker.h
//  HPTunerFunction
//
//  Created by East on 2023/9/11.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
//#import "../CMicrophonePitchDetector/include/CMicrophonePitchDetector.h"

NS_ASSUME_NONNULL_BEGIN

@interface HPPitchTracker : NSObject

-(id)initWithSampleRate:(int)sampleRate hopSize:(int)hopSize peakCount:(int)peakCount;
-(double)getPitchFromBuffer:(AVAudioPCMBuffer *)buffer amplitudeThreshold: (double)amplitudeThreshold;

+(int)defaultBufferSize;

@end

NS_ASSUME_NONNULL_END
