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
    
    SRActionSheet *actionSheet = [[SRActionSheet alloc] initWithTitle:@"分享"
                                                          cancelTitle:@"取消"
                                                     destructiveTitle:nil
                                                          otherTitles:@[@"微信好友", @"微信朋友圈"]
                                                             delegate:self];
    actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentLeft;
    [actionSheet show];
}

- (IBAction)testBtn2Action:(UIButton *)sender {

    [SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
                                       cancelTitle:@"取消"
                                  destructiveTitle:nil
                                       otherTitles:@[@"微信好友", @"微信朋友圈"]
                                       otherImages:nil
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                      NSLog(@"%zd", index);
                                  }];
}

- (IBAction)testBtn3Action:(UIButton *)sender {
    
    [SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
                                       cancelTitle:@"取消"
                                  destructiveTitle:nil
                                       otherTitles:@[@"微信好友", @"微信朋友圈"]
                                       otherImages:@[[UIImage imageNamed:@"share_wx_friend"], [UIImage imageNamed:@"share_wx_pengyouquan"]]
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                      NSLog(@"%zd", index);
                                  }];
}

- (IBAction)testBtn4Action:(UIButton *)sender {
    
    SRActionSheet *actionSheet = [[SRActionSheet alloc] initWithTitle:@"分享"
                                                          cancelTitle:@"取消"
                                                     destructiveTitle:nil
                                                          otherTitles:@[@"微信好友", @"微信朋友圈"]
                                                          otherImages:@[[UIImage imageNamed:@"share_wx_friend"], [UIImage imageNamed:@"share_wx_pengyouquan"]]
                                                             delegate:self];
    actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentCenter;
    [actionSheet show];
}

#pragma mark - SRActionSheetDelegate

- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index {
    
    NSLog(@"%zd", index);
}

@end
