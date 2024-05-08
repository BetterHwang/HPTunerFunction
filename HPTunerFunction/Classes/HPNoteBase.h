//
//  HPNoteBase.h
//  hyk
//
//  Created by East on 2024/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HPNoteBase : NSObject

+(instancetype)shared;

// MARK: - 标准
/**
 A4标准音频率
 */
@property (nonatomic, assign) double note_standard;
/**
 每个音与上一个音的比率 国际标准2^(1/12) ≈ 1.0594631 //cbrt(sqrt(sqrt(2)))
 */
@property (nonatomic, assign, readonly) double note_q;
/**
 音频标准列表
 */
@property (nonatomic, copy) NSArray<NSNumber *> *note_standard_list;

@end

NS_ASSUME_NONNULL_END
