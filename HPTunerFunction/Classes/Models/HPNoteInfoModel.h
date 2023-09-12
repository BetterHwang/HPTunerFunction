//
//  HPNoteInfoModel.h
//  HPTunerFunction
//
//  Created by East on 2023/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    HP_Note_Type_C = 0,
    HP_Note_Type_CD,
    HP_Note_Type_D,
    HP_Note_Type_DE,
    HP_Note_Type_E,
    HP_Note_Type_F,
    HP_Note_Type_FG,
    HP_Note_Type_G,
    HP_Note_Type_GA,
    HP_Note_Type_A,
    HP_Note_Type_AB,
    HP_Note_Type_B
} HP_Note_Type;

@interface HPNoteInfoModel : NSObject
/**
 八度序号
 */
@property (nonatomic, assign) uint indexOfOctave;
/**
 音符
 */
@property (nonatomic, assign) HP_Note_Type noteType;
/**
 距离标准频率的 差值 用于计算频率值
 */
@property (nonatomic, assign) double offset;

-(double)getHz;
-(NSArray<NSString *> *)getNoteName;

@end

NS_ASSUME_NONNULL_END
