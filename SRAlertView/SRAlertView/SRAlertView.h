//
//  SRAlertView.h
//  SRAlertView
//
//  Created by 郭伟林 on 16/7/8.
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
 The Animation style to show alert.
 */
@property (nonatomic, assign) SRAlertViewAnimationStyle animationStyle;

/**
 The action button's title color when highlighted.
 */
@property (nonatomic, strong) UIColor *actionWhenHighlightedTitleColor;

/**
 The action button's background color when highlighted.
 */
@property (nonatomic, strong) UIColor *actionWhenHighlightedBackgroundColor;

/**
 Whether blur the current background view, default is YES.
 */
@property (nonatomic, assign) BOOL blurEffect;

/**
 Creates and returns an alert view with title, icon, message, leftActionTitle, rightActionTitle, animationStyle and selectActionBlock.

 @param title             The text title.
 @param icon              The icon title.
 @param message           The detailed message.
 @param leftActionTitle   The title of the left action button.
 @param rightActionTitle  The title of the right action button.
 @param animationStyle    The style of the animation to show alert.
 @param selectActionBlock The callback block when select a action button.
 @return A SRAlertView object.
 */
+ (instancetype)sr_alertViewWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message leftActionTitle:(NSString *)leftActionTitle rightActionTitle:(NSString *)rightActionTitle animationStyle:(SRAlertViewAnimationStyle)animationStyle selectActionBlock:(SRAlertViewDidSelectActionBlock)selectActionBlock;

/**
 Creates and returns an alert view with delegate.
 */
+ (instancetype)sr_alertViewWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message leftActionTitle:(NSString *)leftActionTitle rightActionTitle:(NSString *)rightActionTitle animationStyle:(SRAlertViewAnimationStyle)animationStyle delegate:(id<SRAlertViewDelegate>)delegate;

/**
 Displays the receiver.
 */
- (void)show;

@end
