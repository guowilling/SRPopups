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

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"SRActionSheet";
    
    UIButton *blockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    blockBtn.frame = CGRectMake(0, 0, 200, 50);
    blockBtn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) - 50);
    [blockBtn setTitle:@"show(BLOCK)" forState:UIControlStateNormal];
    [blockBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [blockBtn addTarget:self action:@selector(showBlock) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blockBtn];
    
    UIButton *delegateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delegateBtn.frame = CGRectMake(0, 0, 200, 50);
    delegateBtn.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame) + 50);
    [delegateBtn setTitle:@"show(DELEGATE)" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [delegateBtn addTarget:self action:@selector(showDelegate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delegateBtn];
}

- (void)showBlock {
    
    [SRActionSheet sr_showActionSheetViewWithTitle:nil
                                 cancelButtonTitle:@"Cancle"
                            destructiveButtonTitle:@"OK"
                                 otherButtonTitles:@[@"0", @"1", @"2"]
                                 otherButtonImages:@[[UIImage imageNamed:@"share_wx_friend"], [UIImage imageNamed:@"share_wx_pengyouquan"]]
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                      NSLog(@"%zd", actionIndex);
                                  }];
}

- (void)showDelegate {
    
    [SRActionSheet sr_showActionSheetViewWithTitle:@"Here is the TITLE."
                                 cancelButtonTitle:@"Cancle"
                            destructiveButtonTitle:@"OK"
                                 otherButtonTitles:@[@"0", @"1", @"2"]
                                 otherButtonImages:nil
                                          delegate:self];
}

#pragma mark - SRActionSheetDelegate

- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index {
    
    NSLog(@"%zd", index);
}

@end
