//
//  ViewController.m
//  SRAlertViewDemo
//
//  Created by 郭伟林 on 16/8/7.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "ViewController.h"
#import "SRAlertView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, SRAlertViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"defaultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"AnimationNone";
            break;
        case 1:
            cell.textLabel.text = @"AnimationZoom";
            break;
        case 2:
            cell.textLabel.text = @"AnimationTopToCenter";
            break;
        case 3:
            cell.textLabel.text = @"AnimationDownToCenter";
            break;
        case 4:
            cell.textLabel.text = @"AnimationLeftToCenter";
            break;
        case 5:
            cell.textLabel.text = @"AnimationRightToCenter";
            break;
        case 6:
            cell.textLabel.text = @"OnlyOneAction";
            break;
        case 7:
            cell.textLabel.text = @"IconTitle";
            break;
        case 8:
            cell.textLabel.text = @"LongMessage";
            break;
        case 9:
            cell.textLabel.text = @"NoBlurEffect";
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"AnimationNone"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationNone
                                                      selectActionBlock:^(SRAlertViewActionType actionType) {
                                                          NSLog(@"%zd", actionType);
                                                      }];
            [alertView show];
        }
            break;
        case 1:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"AnimationZoomSpring"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationZoomSpring
                                                      selectActionBlock:^(SRAlertViewActionType actionType) {
                                                          NSLog(@"%zd", actionType);
                                                      }];
            [alertView show];
        }
            break;
        case 2:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"AnimationTopToCenterSpring"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationTopToCenterSpring
                                                      selectActionBlock:^(SRAlertViewActionType actionType) {
                                                          NSLog(@"%zd", actionType);
                                                      }];
            [alertView show];
        }
            break;
        case 3:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"AnimationDownToCenterSpring"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationDownToCenterSpring
                                                               delegate:self];
            [alertView show];
        }
            break;
        case 4:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"AnimationLeftToCenterSpring"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationLeftToCenterSpring
                                                               delegate:self];
            [alertView show];
        }
            break;
        case 5:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"AnimationRightToCenterSpring"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationRightToCenterSpring
                                                               delegate:self];
            [alertView show];
        }
            break;
        case 6:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"OnlyOneAction"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:nil
                                                         animationStyle:SRAlertViewAnimationZoomSpring
                                                      selectActionBlock:^(SRAlertViewActionType actionType) {
                                                          NSLog(@"%zd", actionType);
                                                      }];
            [alertView show];
        }
            break;

        case 7:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:nil
                                                                   icon:[UIImage imageNamed:@"info"]
                                                                message:@"IconTitle"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationZoomSpring
                                                      selectActionBlock:^(SRAlertViewActionType actionType) {
                                                          NSLog(@"%zd", actionType);
                                                      }];
            [alertView show];
        }
            break;
        case 8:
        {
            NSString *message = @"LongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessageLongMessage";
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:message
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationZoomSpring
                                                               delegate:self];
            [alertView show];
        }
            break;
        case 9:
        {
            SRAlertView *alertView = [SRAlertView sr_alertViewWithTitle:@"SRAlertView"
                                                                   icon:nil
                                                                message:@"NoBlurEffect"
                                                        leftActionTitle:@"Sure"
                                                       rightActionTitle:@"Cancel"
                                                         animationStyle:SRAlertViewAnimationZoomSpring
                                                               delegate:self];
            alertView.blurEffect = NO;
            [alertView show];
        }
            break;
    }
}

- (void)alertViewDidSelectAction:(SRAlertViewActionType)actionType {
    
    NSLog(@"%zd", actionType);
}

@end
