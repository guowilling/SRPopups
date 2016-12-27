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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.testBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.testBtn1 setTitle:@"OnlyTitle(Left)"        forState:UIControlStateNormal];
    [self.testBtn2 setTitle:@"OnlyTitle(Center)"      forState:UIControlStateNormal];
    [self.testBtn3 setTitle:@"TitleAndImage(Left)"    forState:UIControlStateNormal];
    [self.testBtn4 setTitle:@"TitleAndImage(Center)"  forState:UIControlStateNormal];
}

- (IBAction)testBtn1Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"Sharing"
                                                                cancelTitle:@"cancel"
                                                           destructiveTitle:@"destructive"
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                                                otherImages:nil
                                                                   delegate:self];
    actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentLeft;
    [actionSheet show];
}

- (IBAction)testBtn2Action:(UIButton *)sender {

    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"Sharing"
                                                                cancelTitle:@"cancel"
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                                                otherImages:nil
                                                           selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                                               NSLog(@"%zd", index);
                                                           }];
    [actionSheet show];
}

- (IBAction)testBtn3Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"Sharing"
                                                                cancelTitle:nil
                                                           destructiveTitle:@"destructive"
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                                                otherImages:@[[UIImage imageNamed:@"share_wx_friend"],
                                                                              [UIImage imageNamed:@"share_wx_pengyouquan"],
                                                                              [UIImage imageNamed:@"share_qq_friend"],
                                                                              [UIImage imageNamed:@"share_qq_kongjian"]]
                                                           selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                                               NSLog(@"%zd", index);
                                                           }];
    [actionSheet show];
}

- (IBAction)testBtn4Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [SRActionSheet sr_actionSheetViewWithTitle:@"Sharing"
                                                                cancelTitle:nil
                                                           destructiveTitle:nil
                                                                otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
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
