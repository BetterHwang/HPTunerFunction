//
//  HPAudioInfoModel.h
//  HPTunerFunction
//
//  Created by East on 2023/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPAudioInfoModel : NSObject
@property (nonatomic, assign) double note_standard;
@property (nonatomic, assign, readonly) double note_q;
@end

NS_ASSUME_NONNULL_END
