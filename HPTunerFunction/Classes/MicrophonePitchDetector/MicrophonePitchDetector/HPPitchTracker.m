//
//  HPPitchTracker.m
//  HPTunerFunction
//
//  Created by East on 2023/9/11.
//

#import "HPPitchTracker.h"
#import "../CMicrophonePitchDetector/include/CMicrophonePitchDetector.h"

@interface HPPitchTracker() {
    zt_data* m_pData;
    zt_ptrack* m_pPtrack;
}

@end

@implementation HPPitchTracker

/**
 hopSize 默认值 4096
 peakCount 默认值 20
 */
-(id)initWithSampleRate:(int)sampleRate hopSize:(int)hopSize peakCount:(int)peakCount {
    self = [super init];
    if (self) {
        return self;
    }

//    m_pData = new zt_data();
    zt_create(&m_pData);
    m_pData->sr = sampleRate;
    
//    m_pPtrack = new zt_ptrack();
    zt_ptrack_create(&m_pPtrack);
    zt_ptrack_init(m_pData, m_pPtrack, hopSize, peakCount);
    
    return nil;
}

/**
 amplitudeThreshold 默认值0.1
 */
-(double)getPitchFromBuffer:(AVAudioPCMBuffer *)buffer amplitudeThreshold: (double)amplitudeThreshold {
    float * __nonnull const * __nullable floatData = [buffer floatChannelData];
    if (nil == [buffer floatChannelData]) {
        return 0;
    }
    
    float fpitch = 0;
    float famplitude = 0;
    
//    size_t length = sizeof(float *) * buffer.frameLength;
//    float **p = (float **)malloc(length);
//    memset(p, 0, length);
    
//    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < buffer.frameLength; i++) {
        float *x = floatData[0] + i;
//        *(p + i) = x;
        zt_ptrack_compute(m_pData, m_pPtrack, x, &fpitch, &famplitude);
    }
//
//    for (int i = 0; i < buffer.frameLength; i++) {
//        zt_ptrack_compute(m_pData, m_pPtrack, *(p + i), &fpitch, &famplitude);
//    }
//    let frames = (0..<Int(buffer.frameLength)).map { floatData[0].advanced(by: $0) }
//    for frame in frames {
//        zt_ptrack_compute(data, ptrack, frame, &fpitch, &famplitude)
//    }

    double pitch = fpitch;
    double amplitude = famplitude;

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

+(int)defaultBufferSize {
    return 4096;
}
@end
