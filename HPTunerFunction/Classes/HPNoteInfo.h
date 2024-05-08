//
//  HPNoteInfo.h
//  HPTunerFunction
//
//  Created by East on 2023/9/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    HPNote_Type_C = 0,      //
    HPNote_Type_CD,
    HPNote_Type_D,
    HPNote_Type_DE,
    HPNote_Type_E,
    HPNote_Type_F,
    HPNote_Type_FG,
    HPNote_Type_G,
    HPNote_Type_GA,
    HPNote_Type_A,
    HPNote_Type_AB,
    HPNote_Type_B
} HPNote_Type;

@interface HPNoteInfo : NSObject
/**音符**/
@property (nonatomic, assign) HPNote_Type type;
/**八度序号**/
@property (nonatomic, assign) uint indexOfOctave;
/**距离标准频率的 差值**/
@property (nonatomic, assign) double offset;

- (instancetype)initWithFreq:(double)freq;
- (instancetype)initWithTypeIndex: (NSUInteger)typeIndex octaveIndex:(uint)octaveIndex;
/**
 获取音调的频率
 */
- (double)getHz;

/**获取音调名 未带序号**/
- (NSArray<NSString *> *)getNames;

@end

NS_ASSUME_NONNULL_END
