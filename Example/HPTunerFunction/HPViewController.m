//
//  HPViewController.m
//  HPTunerFunction
//
//  Created by hyd0316@vip.qq.com on 09/14/2023.
//  Copyright (c) 2023 hyd0316@vip.qq.com. All rights reserved.
//

#import "HPViewController.h"
#import <HPTunerFunction/HPTunerFunction.h>

@interface HPViewController () <HPAudioTunerDelegate>

@property (nonatomic, strong) HPToneOutput* modelTone;
@property (nonatomic, strong) HPAudioTuner* modelTuner;
@property (nonatomic, strong) UILabel* labelInfo;
@end

@implementation HPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _modelTone = [[HPToneOutput alloc] init];
    _modelTuner = [[HPAudioTuner alloc] init];
    _modelTuner.delegate = self;
    
    _labelInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 100)];
    _labelInfo.textColor = [UIColor blackColor];
    _labelInfo.font = [UIFont systemFontOfSize:16];
    _labelInfo.numberOfLines = 0;
    [self.view addSubview:_labelInfo];
    
    UIButton *btnTestTuner = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    [btnTestTuner setTitle:@"测试校音" forState:UIControlStateNormal];
    [btnTestTuner setTitle:@"暂停校音" forState:UIControlStateSelected];
    [btnTestTuner setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnTestTuner addTarget:self action:@selector(onBtnClick_TestTuner:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTestTuner];
    
    UIButton *btnTestTone = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btnTestTone setTitle:@"测试定音" forState:UIControlStateNormal];
    [btnTestTone setTitle:@"暂停定音" forState:UIControlStateSelected];
    [btnTestTone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnTestTone addTarget:self action:@selector(onBtnClick_TestTone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTestTone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBtnClick_TestTuner:(UIButton *)sender {
    [sender setSelected: ![sender isSelected]];
    
    if (![sender isSelected]) {
        [_modelTuner stop];
        return;
    }

    [_modelTuner startMIC];
}

- (void)onBtnClick_TestTone:(UIButton *)sender {
    [sender setSelected: ![sender isSelected]];
    
    if (![sender isSelected]) {
        [_modelTone stop];
        return;
    }

    [_modelTone setFrequency:440.0];
    [_modelTone setToneVolume:0.5];
    [_modelTone setToneTime:2000];
    [_modelTone enableSpeaker];
    [_modelTone start];
}


#pragma mark - HPAudioTunerDelegate
- (void)audioTuner:(nonnull HPAudioTuner *)tuner didGetNoteInfo:(nonnull HPNoteInfo *)noteInfo {
    
    NSString* info = [[NSString alloc] initWithFormat:@"A4标准音：%.2fHz\n %@%d %+.2fHz", [[HPNoteBase shared] note_standard], [[noteInfo getNames] objectAtIndex:0], [noteInfo indexOfOctave], [noteInfo offset]];
    [_labelInfo setText:info];
    NSLog(@"%@", info);
}

@end
