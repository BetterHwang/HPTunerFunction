//
//  HPToneOutput.m
//  HPTunerFunction
//
//  Created by East on 2023/9/15.
//

#import "HPToneOutput.h"
#import <AVFoundation/AVFoundation.h>

@interface HPToneOutput () {
    AUAudioUnit *auAudioUnit;   // placeholder for RemoteIO Audio Unit
    
}

@property (nonatomic, assign) double f0; // default frequency of tone:   'A' above Concert A
@property (nonatomic, assign) double v0; // default volume of tone:      half full scale
@property (nonatomic, assign) BOOL avActive; // AVAudioSession active flag
@property (nonatomic, assign) BOOL audioRunning; // RemoteIO Audio Unit running flag
@property (nonatomic, assign) UInt32 toneCount;// number of samples of tone to play.  0 for silence
@property (nonatomic, assign) double phY; // save phase of sine wave to prevent clicking
@property (nonatomic, assign) BOOL interrupted; // for restart from audio interruption notification

@end

@implementation HPToneOutput

- (instancetype)init {
    self = [super init];
    if (self) {
        _f0 = 880.0;
        _v0 = 16383.0;
        _toneCount = 0;
        _phY = 0;
        _interrupted = NO;
        
        return self;
    }
    
    return nil;
}

- (double)sampleRate {
    return 44100.0;
}

/**
 audio frequencies below 500 Hz may be
 hard to hear from a tiny iPhone speaker.
 */
- (void)setFrequency:(double)freq {
    _f0 = freq;
}

/**
 0.0 to 1.0
 */
- (void)setToneVolume:(double)volume {
    _v0 = volume * 32766.0;
}

- (void)setToneTime:(double)time {
    _toneCount = (UInt32)(time * [self sampleRate]);
}

- (void)enableSpeaker {
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    
    if (_audioRunning) {
        // return if RemoteIO is already running
        return;
    }
    
    if (nil == auAudioUnit) {
        AudioComponentDescription description;
        description.componentType = kAudioUnitType_Output;
        //kAudioUnitSubType_RemoteIO不带回音消除功能,,kAudioUnitSubType_VoiceProcessingIO带回音消除功能
        description.componentSubType = kAudioUnitSubType_RemoteIO;
        description.componentManufacturer = kAudioUnitManufacturer_Apple;
        description.componentFlags = 0;
        description.componentFlagsMask = 0;
        
        auAudioUnit = [[AUAudioUnit alloc] initWithComponentDescription:description error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        AUAudioUnitBus* bus0 = auAudioUnit.inputBusses[0];
        
        AVAudioFormat *audioFormat = [[AVAudioFormat alloc] initWithCommonFormat:AVAudioPCMFormatInt16 sampleRate:[self sampleRate] channels:(AVAudioChannelCount)2 interleaved:YES];
        [bus0 setFormat:audioFormat error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            return;
        }
        
        __weak typeof(self) weakSelf = self;
        auAudioUnit.outputProvider = ^AUAudioUnitStatus(AudioUnitRenderActionFlags * _Nonnull actionFlags, const AudioTimeStamp * _Nonnull timestamp, AUAudioFrameCount frameCount, NSInteger inputBusNumber, AudioBufferList * _Nonnull inputData) {
            __strong typeof(self) strongSelf = weakSelf;
            
            if (strongSelf) {
                [strongSelf fillSpeakerBuffer:inputData frameCount:frameCount];
            }
            
            return 0;
        };
    }
    
    [auAudioUnit setOutputEnabled:YES];
    [auAudioUnit allocateRenderResourcesAndReturnError:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
}

- (void)start {
    NSError *error;
    [auAudioUnit startHardwareAndReturnError:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        return;
    }
    _audioRunning = YES;
}

- (void)fillSpeakerBuffer:(AudioBufferList * _Nonnull)inputData frameCount:(AUAudioFrameCount)frameCount {
    if (nil == inputData) {
        return;
    }
    
    UInt32 nBufferCount = inputData->mNumberBuffers;
    if (nBufferCount > 0) {
        AudioBuffer mBuffers = inputData->mBuffers[0];
        UInt32 count = frameCount;
        
        if (self.v0 > 0 && self.toneCount > 0) {
            double v =  MIN(self.v0, 32767.0);
            UInt32 sz = mBuffers.mDataByteSize;
            
            double a = self.phY;
            double d = 2.0 * M_PI * self.f0 / [self sampleRate];
            
            int16_t *pBufferData = (int16_t *)mBuffers.mData;
            if (nil == pBufferData) {
                return;
            }
            
            int16_t *pTemp = pBufferData;
            for (int i = 0; i < count; i++) {
                double u = sin(a);  // create a sinewave
                a += d;
                if (a > 2.0 * M_PI) {
                    a -= 2.0 * M_PI;
                }
                // scale & round
                int16_t x = (int16_t)(v * u + 0.5);
                
                if (i < (sz / 2)) {
                    // increment by 2 bytes for next Int16 item
                    // pointer to int16_t forward 2 bytes
                    // stereo, so fill both Left & Right channels
                    *pTemp = x;
                    pTemp += 1;
                    *pTemp = x;
                    pTemp += 1;
                }
            }
            
            self.phY        =   a;                   // save sinewave phase
            self.toneCount  -=  frameCount;   // decrement time remaining
        }else {
            memset(mBuffers.mData, 0, (size_t)mBuffers.mDataByteSize);  // silence
        }
    }
}

- (void)stop {
    if (auAudioUnit) {
        [auAudioUnit stopHardware];
        _audioRunning = NO;
        _toneCount = 0;
    }
}

@end
