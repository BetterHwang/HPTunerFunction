//
//  HPNoteBase.m
//  hyk
//
//  Created by East on 2024/5/6.
//

#import "HPNoteBase.h"

@interface HPNoteBase() {
    
}


@end

@implementation HPNoteBase

static HPNoteBase* sharedObj;

+(instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[HPNoteBase alloc] init];
    });
    
    return sharedObj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setNote_standard:440.0];
    }
    return self;
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
