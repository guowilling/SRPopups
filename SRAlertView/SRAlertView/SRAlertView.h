//
//  SRAlertView.h
//  SRAlertView
//
//  Created by https://github.com/guowilling on 16/7/8.
//  Copyright © 2016年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRAlertView;

typedef NS_ENUM(NSInteger, SRAlertViewActionType) {
    SRAlertViewActionTypeLeft,
    SRAlertViewActionTypeRight,
};

typedef NS_ENUM(NSInteger, SRAlertViewAnimationStyle) {
    SRAlertViewAnimationNone,
    SRAlertViewAnimationZoomSpring,
    SRAlertViewAnimationTopToCenterSpring,
    SRAlertViewAnimationDownToCenterSpring,
    SRAlertViewAnimationLeftToCenterSpring,
    SRAlertViewAnimationRightToCenterSpring,
};

@protocol SRAlertViewDelegate <NSObject>

- (void)alertViewDidSelectAction:(SRAlertViewActionType)actionType;

@end

typedef void(^SRAlertViewDidSelectActionBlock)(SRAlertViewActionType actionType);

@interface SRAlertView : UIView

/**
 Whether blur the current background view, default is YES.
 */
@property (nonatomic, assign) BOOL blurEffect;

/**
 The animation style of showing the alert view.
 */
@property (nonatomic, assign) SRAlertViewAnimationStyle animationStyle;

@property (nonatomic, strong) UIColor *actionTitleColorWhenHighlighted;

@property (nonatomic, strong) UIColor *actionBackgroundColorWhenHighlighted;

+ (instancetype)sr_alertViewWithTitle:(NSString *)title
                                 icon:(UIImage *)icon
                              message:(NSString *)message
                      leftActionTitle:(NSString *)leftActionTitle
                     rightActionTitle:(NSString *)rightActionTitle
                       animationStyle:(SRAlertViewAnimationStyle)animationStyle
                    selectActionBlock:(SRAlertViewDidSelectActionBlock)block;

+ (instancetype)sr_alertViewWithTitle:(NSString *)title
                                 icon:(UIImage *)icon
                              message:(NSString *)message
                      leftActionTitle:(NSString *)leftActionTitle
                     rightActionTitle:(NSString *)rightActionTitle
                       animationStyle:(SRAlertViewAnimationStyle)animationStyle
                             delegate:(id<SRAlertViewDelegate>)delegate;

- (void)show;

@end
