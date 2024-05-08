//
//  HPNoteInfo.m
//  HPTunerFunction
//
//  Created by East on 2023/9/14.
//

#import "HPNoteInfo.h"
#import "HPNoteBase.h"

@interface HPNoteInfo() {
    
}

//@property (nonatomic, copy) NSArray<NSNumber *> *note_standard_list;
@property (nonatomic, strong) HPNoteBase *noteBase;

@end

@implementation HPNoteInfo

- (instancetype)init {
    self = [super init];
    if (self) {
//        [self setNote_standard:440.0];
        _noteBase = HPNoteBase.shared;
        _indexOfOctave = 4;
        _type = HPNote_Type_A;
        _offset = 0;
        
        return self;
    }
    
    return nil;
}

- (instancetype)initWithTypeIndex: (NSUInteger)typeIndex octaveIndex:(uint)octaveIndex {
    self = [super init];
    if (self) {
//        [self setNote_standard:440.0];
        _noteBase = HPNoteBase.shared;
        _indexOfOctave = octaveIndex;
        _type = typeIndex;
        _offset = 0;
        return self;
    }
    
    return nil;
}

- (instancetype)initWithFreq:(double)freq {
    self = [super init];
    if (self) {
//        [self setNote_standard:440.0];
        _noteBase = HPNoteBase.shared;
        
        NSArray<NSNumber *> *listStandard = _noteBase.note_standard_list;
        
        for (int i = 0; i < listStandard.count; i++) {
            int indexOfOctave = i / 12;
            int indexOfNote = i % 12;
            
            double item = listStandard[i].doubleValue;
            if (item == freq) {
                _indexOfOctave = indexOfOctave;
                _type = indexOfNote;
                _offset = 0;
                return self;
            }
            
            if (item > freq) {
                if (i == 0) {
                    _indexOfOctave = indexOfOctave;
                    _type = indexOfNote;
                    _offset = freq - item;
                    
                    return self;
                }
                
                double dx0 = freq - listStandard[i - 1].doubleValue;
                double dx1 = item - freq;
                
                if (dx0 >= dx1) {
                    _indexOfOctave = indexOfOctave;
                    _type = indexOfNote;
                    _offset = freq - item;
                    
                    return self;
                }else {
                    int indexTemp = i - 1;
                    int indexOfOctave = indexTemp / 12;
                    int indexOfNote = indexTemp % 12;
                    _indexOfOctave = indexOfOctave;
                    _type = indexOfNote;
                    _offset = freq - listStandard[indexTemp].doubleValue;
                    
                    return self;
                }
            }
        }
        
        int indexTemp = (int)listStandard.count - 1;
        if (indexTemp < 0) {
            return self;
        }
        
        int indexOfOctave = indexTemp / 12;
        int indexOfNote = indexTemp % 12;
        _indexOfOctave = indexOfOctave;
        _type = indexOfNote;
        _offset = freq - listStandard[indexTemp].doubleValue;
        return self;
    }
    
    return nil;
}

-(double)getHz {
    if ([self indexOfOctave] < 0 || [self indexOfOctave] >= 12) {
        return 0;
    }
    
    uint index = [self indexOfOctave] * 12 + (uint)[self type];
    
    NSArray<NSNumber *> *listStandard = _noteBase.note_standard_list;
    return [listStandard objectAtIndex:index].doubleValue + [self offset];
}

- (NSArray<NSString *> *)getNames {
    NSMutableArray<NSString *> *ret = [NSMutableArray array];
    
    switch (_type) {
        case HPNote_Type_C:
            [ret addObject:@"C"];
            break;
        case HPNote_Type_CD:
            [ret addObject:@"C♯"];
            [ret addObject:@"D♭"];
            break;
        case HPNote_Type_D:
            [ret addObject:@"D"];
            break;
        case HPNote_Type_DE:
            [ret addObject:@"D♯"];
            [ret addObject:@"E♭"];
            break;
        case HPNote_Type_E:
            [ret addObject:@"E"];
            break;
        case HPNote_Type_F:
            [ret addObject:@"F"];
            break;
        case HPNote_Type_FG:
            [ret addObject:@"F♯"];
            [ret addObject:@"G♭"];
            break;
        case HPNote_Type_G:
            [ret addObject:@"G"];
            break;
        case HPNote_Type_GA:
            [ret addObject:@"G♯"];
            [ret addObject:@"A♭"];
            break;
        case HPNote_Type_A:
            [ret addObject:@"A"];
            break;
        case HPNote_Type_AB:
            [ret addObject:@"A♯"];
            [ret addObject:@"B♭"];
            break;
        case HPNote_Type_B:
            [ret addObject:@"B"];
            break;
    }
    return ret;
}

@end
