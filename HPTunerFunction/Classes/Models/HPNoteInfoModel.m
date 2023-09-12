//
//  HPNoteInfoModel.m
//  HPTunerFunction
//
//  Created by East on 2023/9/11.
//

#import "HPNoteInfoModel.h"

@implementation HPNoteInfoModel

-(double)getHz {
    return 0;
}

-(NSArray<NSString *> *)getNoteName{
    switch (_noteType) {
        case HP_Note_Type_C:
            return [NSArray arrayWithObjects:@"C", nil];
        case HP_Note_Type_CD:
            return [NSArray arrayWithObjects:@"C♯", @"D♭", nil];
        case HP_Note_Type_D:
            return [NSArray arrayWithObjects:@"D", nil];
        case HP_Note_Type_DE:
            return [NSArray arrayWithObjects:@"D♯", @"E♭", nil];
        case HP_Note_Type_E:
            return [NSArray arrayWithObjects:@"E", nil];
        case HP_Note_Type_F:
            return [NSArray arrayWithObjects:@"F", nil];
        case HP_Note_Type_FG:
            return [NSArray arrayWithObjects:@"F♯", @"G♭", nil];
        case HP_Note_Type_G:
            return [NSArray arrayWithObjects:@"G", nil];
        case HP_Note_Type_GA:
            return [NSArray arrayWithObjects:@"G♯", @"A♭", nil];
        case HP_Note_Type_A:
            return [NSArray arrayWithObjects:@"A", nil];
        case HP_Note_Type_AB:
            return [NSArray arrayWithObjects:@"A♯", @"B♭", nil];
        case HP_Note_Type_B:
            return [NSArray arrayWithObjects:@"B", nil];
    }
    
    return nil;
}
@end
