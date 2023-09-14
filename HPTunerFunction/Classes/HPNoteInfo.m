//
//  HPNoteInfo.m
//  HPTunerFunction
//
//  Created by East on 2023/9/14.
//

#import "HPNoteInfo.h"

@interface HPNoteInfo() {
    
}

@property (nonatomic, copy) NSArray<NSNumber *> *note_standard_list;

@end

@implementation HPNoteInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setNote_standard:440.0];
        _indexOfOctave = 4;
        _type = HPNote_Type_A;
        _offset = 0;
        
        return self;
    }
    
    return nil;
}

-(double)getHz {
    if ([self indexOfOctave] < 0 || [self indexOfOctave] >= 12) {
        return 0;
    }
    
    uint index = [self indexOfOctave] * 12 + (uint)[self type];
    return [[self note_standard_list] objectAtIndex:index].doubleValue + [self offset];
}

-(double)note_q {
    return 1.0594631;
}

-(void)setNote_standard:(double)note_standard {
    _note_standard = note_standard;
    
    NSMutableArray* listNote = [NSMutableArray array];
    
    for (int i = 0; i < 120; i++) {
        NSNumber *num;
        if (i < 57) {
            num = [NSNumber numberWithDouble: [self divide:[self note_standard] by: [self note_q] count:57 - i]];
        }else if (i > 57) {
            num = [NSNumber numberWithDouble: [self multiply:[self note_standard] by: [self note_q] count:i - 57]];
        }else {
            num = [NSNumber numberWithDouble: [self note_standard]];
        }
        [listNote addObject:num];
    }
    
    self.note_standard_list = listNote;
}

//MARK: - 连乘 连除
-(double)divide:(double)dividend by:(double)divisor count:(uint)count {
    double ret = dividend;
    for (int i = 0; i < count; i++) {
        ret /= divisor;
    }
    
    return ret;
}

-(double)multiply:(double)multiplicand by:(double)multiplier count:(uint)count {
    double ret = multiplicand;
    for (int i = 0; i < count; i++) {
        ret *= multiplier;
    }
    
    return ret;
}

@end
