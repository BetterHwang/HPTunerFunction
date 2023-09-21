//
//  HPPitchTracker.m
//  HPTunerFunction
//
//  Created by East on 2023/9/15.
//

#import "HPPitchTracker.h"
#import "CMicrophonePitchDetector/CMicrophonePitchDetector.h"

@interface HPPitchTracker () {
    zt_data     *m_pData;
    zt_ptrack   *m_pPtrack;
}

@end

@implementation HPPitchTracker

+(int)defaultBufferSize {
    return 4096;
}

- (instancetype)initWithSampleRate:(int)sampleRate hopSize:(int)hopSize peakCount:(int)peakCount {
    self = [super init];
    if (self) {
        zt_create(&m_pData);
        m_pData->sr = sampleRate;
        zt_ptrack_create(&m_pPtrack);
        zt_ptrack_init(m_pData, m_pPtrack, hopSize, peakCount);
        return self;
    }
    
    return nil;
}

- (double)getPitchWithBuffer:(AVAudioPCMBuffer *)buffer amplitudeThreshold:(double)amplitudeThreshold {
    float fPitch = 0;
    float fAmplitude = 0;
    
    float * __nonnull const * __nullable bufferData = buffer.floatChannelData;
    if (nil == bufferData) {
        return 0;
    }
    
    for (int i = 0; i < buffer.frameLength; i++) {
        float *pFrame = bufferData[0] + i;
        zt_ptrack_compute(m_pData, m_pPtrack, pFrame, &fPitch, &fAmplitude);
    }
    
    double pitch = (double)fPitch;
    double amplitude = (double)fAmplitude;
    
    if (amplitude > amplitudeThreshold && pitch > 0) {
        return pitch;
    } else {
        return 0;
    }
}

-(void)dealloc {
    zt_ptrack_destroy(&m_pPtrack);
    zt_destroy(&m_pData);
}

@end
