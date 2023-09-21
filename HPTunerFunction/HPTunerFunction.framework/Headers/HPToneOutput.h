//
//  HPToneOutput.h
//  HPTunerFunction
//
//  Created by East on 2023/9/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPToneOutput : NSObject
/**设置频率单位Hz**/
- (void)setFrequency:(double)freq;
/**设置音量0-1之间的值**/
- (void)setToneVolume:(double)volume;
/**设置输出时长**/
- (void)setToneTime:(double)time;
/**初始化输出音**/
- (void)enableSpeaker;
/**开始播放**/
- (void)start;
/**结束播放**/
- (void)stop;
@end
NS_ASSUME_NONNULL_END
