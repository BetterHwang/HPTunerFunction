//
//  HPAudioTuner.h
//  HPTunerFunction
//
//  Created by East on 2023/9/15.
//

#import <Foundation/Foundation.h>
#import "HPNoteInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HPAudioTunerDelegate;

@interface HPAudioTuner : NSObject

@property (nonatomic, weak) id<HPAudioTunerDelegate> delegate;

- (void)startMIC;
- (void)stop;
@end

@protocol HPAudioTunerDelegate <NSObject>
-(void)audioTuner:(HPAudioTuner *)tuner didGetNoteInfo:(HPNoteInfo *)noteInfo;
@end

NS_ASSUME_NONNULL_END
