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

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.testBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.testBtn1 setTitle:@"OnlyTitle"     forState:UIControlStateNormal];
    [self.testBtn2 setTitle:@"TitleAndImage" forState:UIControlStateNormal];
}

- (IBAction)testBtn1Action:(UIButton *)sender {
    
    [SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
                                       cancelTitle:@"取消"
                                  destructiveTitle:nil
                                       otherTitles:@[@"微信微信", @"微信朋友圈"]
                                       otherImages:nil
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                      NSLog(@"%zd", index);
                                  }];

//    [SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
//                                       cancelTitle:@"取消"
//                                  destructiveTitle:nil
//                                       otherTitles:@[@"微信好友", @"微信朋友圈"]
//                                          delegate:self];
}

- (IBAction)testBtn2Action:(UIButton *)sender {
    
    [SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
                                       cancelTitle:@"取消"
                                  destructiveTitle:nil
                                       otherTitles:@[@"微信好友", @"微信朋友圈"]
                                       otherImages:@[[UIImage imageNamed:@"share_wx_friend"], [UIImage imageNamed:@"share_wx_pengyouquan"]]
                                  selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                      NSLog(@"%zd", index);
                                  }];

//    [SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
//                                       cancelTitle:@"取消"
//                                  destructiveTitle:nil
//                                       otherTitles:@[@"微信好友", @"微信朋友圈"]
//                                       otherImages:@[[UIImage imageNamed:@"share_wx_friend"], [UIImage imageNamed:@"share_wx_pengyouquan"]]
//                                          delegate:self];
}

#pragma mark - SRActionSheetDelegate

- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index {
    
    NSLog(@"%zd", index);
}

@end
