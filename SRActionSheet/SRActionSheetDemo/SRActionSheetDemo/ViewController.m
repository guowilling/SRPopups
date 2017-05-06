//
//  ViewController.m
//  SRActionSheetDemo
//
//  Created by 郭伟林 on 16/8/7.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "ViewController.h"
#import "SRActionSheet.h"

@interface ViewController () <SRActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *testBtn1;
@property (weak, nonatomic) IBOutlet UIButton *testBtn2;
@property (weak, nonatomic) IBOutlet UIButton *testBtn3;
@property (weak, nonatomic) IBOutlet UIButton *testBtn4;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.testBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.testBtn1 setTitle:@"OnlyTitle(LeftAlignment)"       forState:UIControlStateNormal];
    [self.testBtn2 setTitle:@"OnlyTitle(CenterAlignment)"     forState:UIControlStateNormal];
    [self.testBtn3 setTitle:@"TitleAndImage(LeftAlignment)"   forState:UIControlStateNormal];
    [self.testBtn4 setTitle:@"TitleAndImage(CenterAlignment)" forState:UIControlStateNormal];
}

- (IBAction)testBtn1Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:nil
                                                                cancelTitle:@"取消"
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ 好友", @"QQ 空间"]
                                                                otherImages:nil
                                                                   delegate:self];
    actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentLeft;
    [actionSheet show];
}

- (IBAction)testBtn2Action:(UIButton *)sender {

    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:nil
                                                                cancelTitle:@"取消"
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ 好友", @"QQ 空间"]
                                                                otherImages:nil
                                                          selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                              NSLog(@"%zd", index);
                                                          }];
    [actionSheet show];
}

- (IBAction)testBtn3Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:nil
                                                                cancelTitle:@"取消"
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ 好友", @"QQ 空间"]
                                                                otherImages:@[[UIImage imageNamed:@"share_wx_friend"],
                                                                              [UIImage imageNamed:@"share_wx_pengyouquan"],
                                                                              [UIImage imageNamed:@"share_qq_friend"],
                                                                              [UIImage imageNamed:@"share_qq_kongjian"]]
                                                          selectActionBlock:^(SRActionSheet *actionSheet, NSInteger index) {
                                                              NSLog(@"%zd", index);
                                                          }];
    [actionSheet show];
}

- (IBAction)testBtn4Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:nil
                                                                cancelTitle:@"取消"
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ 好友", @"QQ 空间"]
                                                                otherImages:@[[UIImage imageNamed:@"share_wx_friend"],
                                                                              [UIImage imageNamed:@"share_wx_pengyouquan"],
                                                                              [UIImage imageNamed:@"share_qq_friend"],
                                                                              [UIImage imageNamed:@"share_qq_kongjian"]]
                                                                   delegate:self];
    actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentCenter;
    [actionSheet show];
}

#pragma mark - SRActionSheetDelegate

- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index {
    
    NSLog(@"%zd", index);
}

@end
