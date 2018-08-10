//
//  SRAlertView.m
//  SRAlertView
//
//  Created by https://github.com/guowilling on 16/7/8.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "SRAlertView.h"
#import "FXBlurView.h"

#pragma mark - Frames

#define SCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)  SCREEN_WIDTH * (Value) / 375.0f

#define kAlertViewW            275.0f
#define kAlertViewTitleH       20.0f
#define kAlertViewIconWH       50.0f
#define kAlertViewBtnH         50.0f
#define kAlertViewMessageMinH  70.0f
#define kVerticalMargin        20.0f

#define kTitleFont     [UIFont boldSystemFontOfSize:SCREEN_ADJUST(18)];
#define kMessageFont   [UIFont systemFontOfSize:SCREEN_ADJUST(15)];
#define kBtnTitleFont  [UIFont systemFontOfSize:SCREEN_ADJUST(16)];

#pragma mark - Colors

#define COLOR_RGB(R, G, B)  [UIColor colorWithRed:(R/255.0f) green:(G/255.0f) blue:(B/255.0f) alpha:1.0f]

#define COLOR_RANDOM  COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define UICOLOR_FROM_HEX_ALPHA(RGBValue, Alpha) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:Alpha]

#define UICOLOR_FROM_HEX(RGBValue) [UIColor \
colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0xFF00) >> 8))/255.0 \
blue:((float)(RGBValue & 0xFF))/255.0 alpha:1.0]

#define kTitleLabelColor                UICOLOR_FROM_HEX_ALPHA(0x000000, 1.0)
#define kMessageLabelColor              UICOLOR_FROM_HEX_ALPHA(0x313131, 1.0)

#define kBtnNormalTitleColor            UICOLOR_FROM_HEX_ALPHA(0x4A4A4A, 1.0)
#define kBtnHighlightedTitleColor       UICOLOR_FROM_HEX_ALPHA(0x4A4A4A, 1.0)
#define kBtnHighlightedBackgroundColor  UICOLOR_FROM_HEX_ALPHA(0xF76B1E, 0.15)

#define kLineBackgroundColor  [UIColor colorWithRed:1.00 green:0.92 blue:0.91 alpha:1.00]

#define kBlurRadius  10.0

@interface SRAlertView ()

@property (nonatomic, weak) id<SRAlertViewDelegate> delegate;

@property (nonatomic, copy) SRAlertViewDidSelectActionBlock selectActionBlock;

@property (nonatomic, strong) UIView     *alertView;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) UIView     *coverView;

@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UIImage     *icon;
@property (nonatomic, copy  ) UIImageView *iconImageView;

@property (nonatomic, copy  ) NSString *message;
@property (nonatomic, strong) UILabel  *messageLabel;

@property (nonatomic, copy  ) NSString *leftActionTitle;
@property (nonatomic, strong) UIButton *leftAction;

@property (nonatomic, copy  ) NSString *rightActionTitle;
@property (nonatomic, strong) UIButton *rightAction;

@end

@implementation SRAlertView

#pragma mark - BLOCK

+ (instancetype)sr_alertViewWithTitle:(NSString *)title
                                 icon:(UIImage *)icon
                              message:(NSString *)message
                      leftActionTitle:(NSString *)leftActionTitle
                     rightActionTitle:(NSString *)rightActionTitle
                       animationStyle:(SRAlertViewAnimationStyle)animationStyle
                    selectActionBlock:(SRAlertViewDidSelectActionBlock)block
{
    return [[self alloc] initWithTitle:title
                                  icon:icon
                               message:message
                       leftActionTitle:leftActionTitle
                      rightActionTitle:rightActionTitle
                        animationStyle:animationStyle
                     selectActionBlock:block];
}

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)icon
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(SRAlertViewAnimationStyle)animationStyle
            selectActionBlock:(SRAlertViewDidSelectActionBlock)block
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _blurEffect        = YES;
        _title             = title;
        _icon              = icon;
        _message           = message;
        _leftActionTitle   = leftActionTitle;
        _rightActionTitle  = rightActionTitle;
        _animationStyle    = animationStyle;
        _selectActionBlock = block;
        [self setupAlertView];
    }
    return self;
}

#pragma mark - DELEGATE

+ (instancetype)sr_alertViewWithTitle:(NSString *)title
                                 icon:(UIImage *)icon
                              message:(NSString *)message
                      leftActionTitle:(NSString *)leftActionTitle
                     rightActionTitle:(NSString *)rightActionTitle
                       animationStyle:(SRAlertViewAnimationStyle)animationStyle
                             delegate:(id<SRAlertViewDelegate>)delegate
{
    return [[self alloc] initWithTitle:title
                                  icon:icon
                               message:message
                       leftActionTitle:leftActionTitle
                      rightActionTitle:rightActionTitle
                        animationStyle:animationStyle
                              delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)icon
                      message:(NSString *)message
              leftActionTitle:(NSString *)leftActionTitle
             rightActionTitle:(NSString *)rightActionTitle
               animationStyle:(SRAlertViewAnimationStyle)animationStyle
                     delegate:(id<SRAlertViewDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _blurEffect       = YES;
        _title            = title;
        _icon             = icon;
        _message          = message;
        _leftActionTitle  = leftActionTitle;
        _rightActionTitle = rightActionTitle;
        _animationStyle   = animationStyle;
        _delegate         = delegate;
        [self setupAlertView];
    }
    return self;
}

#pragma mark - Setup UI

- (FXBlurView *)blurView {
    if (!_blurView) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
        _blurView = [[FXBlurView alloc] initWithFrame:SCREEN_BOUNDS];
        _blurView.tintColor = [UIColor clearColor];
        _blurView.dynamic = NO;
        _blurView.blurRadius = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:_blurView];
    }
    return _blurView;
}

- (UIView *)coverView {
    if (!_coverView) {
        [self insertSubview:({
            _coverView = [[UIView alloc] initWithFrame:self.bounds];
            _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
            _coverView.alpha = 0;
            _coverView;
        }) atIndex:0];
    }
    return _coverView;
}

- (void)setupAlertView {
    [self addSubview:({
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 10.0;
        _alertView.layer.masksToBounds = YES;
        _alertView;
    })];
    
    [self setupTitleView];
    
    [self setupIconImageView];
    
    [self setupMessageLabel];
    
    _alertView.frame = CGRectMake(0, 0, kAlertViewW, CGRectGetMaxY(_messageLabel.frame) + kAlertViewBtnH + kVerticalMargin);
    _alertView.center = self.center;
    
    [self setupActions];
}

- (void)setupTitleView {
    if (!_title || _title.length == 0) {
        return;
    }
    [_alertView addSubview:({
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kVerticalMargin, kAlertViewW, kAlertViewTitleH)];
        _titleLabel.text = _title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kTitleLabelColor;
        _titleLabel.font = kTitleFont;
        _titleLabel;
    })];
}

- (void)setupIconImageView {
    if (_title && _title.length > 0) { // the icon title will be ignored if there is text title already
        return;
    }
    if (!_icon) {
        return;
    }
    [_alertView addSubview:({
        _iconImageView = [[UIImageView alloc] initWithImage:_icon];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.frame = CGRectMake((kAlertViewW - kAlertViewIconWH) * 0.5, kVerticalMargin, kAlertViewIconWH, kAlertViewIconWH);
        _iconImageView;
    })];
}

- (void)setupMessageLabel {
    CGFloat messageLabelSpacing = 20;
    [_alertView addSubview:({
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.backgroundColor = [UIColor whiteColor];
        _messageLabel.textColor = kMessageLabelColor;
        _messageLabel.font = kMessageFont;
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maxSize = CGSizeMake(kAlertViewW - messageLabelSpacing * 2, MAXFLOAT);
        _messageLabel.text = @"one";
        CGSize tempSize = [_messageLabel sizeThatFits:maxSize];
        _messageLabel.text = _message;
        CGSize expectSize = [_messageLabel sizeThatFits:maxSize];
        if (expectSize.height == tempSize.height) { // if message label just has only one line
            _messageLabel.textAlignment = NSTextAlignmentCenter;
        }
        [_messageLabel sizeToFit];
        CGFloat messageLabH = expectSize.height < kAlertViewMessageMinH ? kAlertViewMessageMinH : expectSize.height;
        CGFloat messageLabY = _titleLabel ? (CGRectGetMaxY(_titleLabel.frame) + kVerticalMargin) : (CGRectGetMaxY(_iconImageView.frame) + kVerticalMargin * 0.5);
        _messageLabel.frame = CGRectMake(messageLabelSpacing, messageLabY, kAlertViewW - messageLabelSpacing * 2, messageLabH);
        _messageLabel;
    })];
}

- (void)setupActions {
    CGFloat btnY = _alertView.frame.size.height - kAlertViewBtnH;
    if (_leftActionTitle) {
        [_alertView addSubview:({
            _leftAction = [UIButton buttonWithType:UIButtonTypeCustom];
            _leftAction.tag = SRAlertViewActionTypeLeft;
            _leftAction.titleLabel.font = kBtnTitleFont;
            [_leftAction setTitle:_leftActionTitle forState:UIControlStateNormal];
            [_leftAction setTitleColor:kBtnNormalTitleColor forState:UIControlStateNormal];
            [_leftAction setTitleColor:kBtnHighlightedTitleColor forState:UIControlStateHighlighted];
            [_leftAction setBackgroundImage:[self imageWithColor:kBtnHighlightedBackgroundColor] forState:UIControlStateHighlighted];
            [_leftAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_leftAction];
            if (_rightActionTitle) {
                _leftAction.frame = CGRectMake(0, btnY, kAlertViewW * 0.5, kAlertViewBtnH);
            } else {
                _leftAction.frame = CGRectMake(0, btnY, kAlertViewW, kAlertViewBtnH);
            }
            _leftAction;
        })];
    }
    
    if (_rightActionTitle) {
        [_alertView addSubview:({
            _rightAction = [UIButton buttonWithType:UIButtonTypeCustom];
            _rightAction.tag = SRAlertViewActionTypeRight;
            _rightAction.titleLabel.font = kBtnTitleFont;
            [_rightAction setTitle:_rightActionTitle forState:UIControlStateNormal];
            [_rightAction setTitleColor:kBtnNormalTitleColor forState:UIControlStateNormal];
            [_rightAction setTitleColor:kBtnHighlightedTitleColor forState:UIControlStateHighlighted];
            [_rightAction setBackgroundImage:[self imageWithColor:kBtnHighlightedBackgroundColor] forState:UIControlStateHighlighted];
            [_rightAction addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_alertView addSubview:_rightAction];
            if (_leftActionTitle) {
                _rightAction.frame = CGRectMake(kAlertViewW * 0.5, btnY, kAlertViewW * 0.5, kAlertViewBtnH);
            } else {
                _rightAction.frame = CGRectMake(0, btnY, kAlertViewW, kAlertViewBtnH);
            }
            _rightAction;
        })];
    }
    
    if (_leftActionTitle && _rightActionTitle) {
        UIView *line1 = [[UIView alloc] init];
        line1.frame = CGRectMake(0, btnY, kAlertViewW, 1);
        line1.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line1];
        
        UIView *line2 = [[UIView alloc] init];
        line2.frame = CGRectMake(kAlertViewW * 0.5, btnY, 1, kAlertViewBtnH);
        line2.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line2];
    } else {
        UIView *line = [[UIView alloc] init];
        line.frame = CGRectMake(0, btnY, kAlertViewW, 1);
        line.backgroundColor = kLineBackgroundColor;
        [_alertView addSubview:line];
    }
}

#pragma mark - Actions

- (void)btnAction:(UIButton *)btn {
    if (self.selectActionBlock) {
        self.selectActionBlock(btn.tag);
    }
    if ([self.delegate respondsToSelector:@selector(alertViewDidSelectAction:)]) {
        [self.delegate alertViewDidSelectAction:btn.tag];
    }
    
    [self dismiss];
}

#pragma mark - Animations

- (void)show {
    if (!_blurEffect) {
        [self coverView];
    } else {
        [self blurView];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    if (!_blurEffect) {
        [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.coverView.alpha = 1.0;
                         } completion:nil];
    } else {
        self.blurView.blurRadius = kBlurRadius;
    }
    
    switch (self.animationStyle) {
        case SRAlertViewAnimationNone:
        {
            // No animation
            break;
        }
        case SRAlertViewAnimationZoomSpring:
        {
            [self.alertView.layer setValue:@(0) forKeyPath:@"transform.scale"];
            [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.alertView.layer setValue:@(1.0) forKeyPath:@"transform.scale"];
                             } completion:nil];
            break;
        }
        case SRAlertViewAnimationTopToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, -self.alertView.frame.size.height);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case SRAlertViewAnimationDownToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(self.center.x, SCREEN_HEIGHT);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case SRAlertViewAnimationLeftToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(-kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
        case SRAlertViewAnimationRightToCenterSpring:
        {
            CGPoint startPoint = CGPointMake(SCREEN_WIDTH + kAlertViewW, self.center.y);
            self.alertView.layer.position = startPoint;
            [UIView animateWithDuration:0.9 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.alertView.layer.position = self.center;
                             } completion:nil];
            break;
        }
    }
}

- (void)dismiss {
    [self.alertView removeFromSuperview];
    
    if (!_blurEffect) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _coverView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
    } else {
        [_blurView removeFromSuperview];
        [self removeFromSuperview];
    }
}

#pragma mark - Assist Methods

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Public Methods

- (void)setAnimationStyle:(SRAlertViewAnimationStyle)animationStyle {
    if (_animationStyle == animationStyle) {
        return;
    }
    _animationStyle = animationStyle;
}

- (void)setBlurEffect:(BOOL)blurEffect {
    if (_blurEffect == blurEffect) {
        return;
    }
    _blurEffect = blurEffect;
}

- (void)setActionTitleColorWhenHighlighted:(UIColor *)actionTitleColorWhenHighlighted {
    _actionTitleColorWhenHighlighted = actionTitleColorWhenHighlighted;
    
    [self.leftAction  setTitleColor:actionTitleColorWhenHighlighted forState:UIControlStateHighlighted];
    [self.rightAction setTitleColor:actionTitleColorWhenHighlighted forState:UIControlStateHighlighted];
}

- (void)setActionBackgroundColorWhenHighlighted:(UIColor *)actionBackgroundColorWhenHighlighted {
    _actionBackgroundColorWhenHighlighted = actionBackgroundColorWhenHighlighted;
    
    [self.leftAction  setBackgroundImage:[self imageWithColor:actionBackgroundColorWhenHighlighted] forState:UIControlStateHighlighted];
    [self.rightAction setBackgroundImage:[self imageWithColor:actionBackgroundColorWhenHighlighted] forState:UIControlStateHighlighted];
}

@end
