//
//  SRActionSheetView.m
//  SRActionSheetDemo
//
//  Created by 郭伟林 on 16/7/5.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "SRActionSheet.h"

#define SCREEN_BOUNDS           [UIScreen mainScreen].bounds
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)    SCREEN_WIDTH * (Value) / 375.0

#define kRowButtonHeight        SCREEN_ADJUST(50)
#define kRowLineHeight          0.5
#define kDividerViewHeight      7.5

#define kTitleFontSize          SCREEN_ADJUST(15)
#define kButtonTitleFontSize    SCREEN_ADJUST(17)

#define kActionSheetViewColor           [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]
#define kTitleFontColor                 [UIColor colorWithRed:111.0f/255.0f green:111.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
#define kButtonHighlightedColor         [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define kDestructiveButtonNormalColor   [UIColor colorWithRed:255.0f/255.0f green:10.00f/255.0f blue:10.00f/255.0f alpha:1.0f]
#define kDividerViewColor               [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f]

@interface SRActionSheet ()

@property (nonatomic, weak) id<SRActionSheetDelegate> delegate;

@property (nonatomic, copy) ActionSheetDidSelectSheetBlock selectSheetBlock;

@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *cancelButtonTitle;
@property (nonatomic, copy) NSString  *destructiveButtonTitle;
@property (nonatomic, copy) NSArray   *otherButtonTitles;

@property (nonatomic, strong) UIView  *coverView;
@property (nonatomic, strong) UIView  *actionSheetView;

@property (nonatomic, assign, getter = isShow) BOOL show;
@property (nonatomic, assign) CGFloat actionSheetHeight;

@end

@implementation SRActionSheet

#pragma mark - BLOCK

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray  *)otherButtonTitles
                       selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock
{
    [[[self alloc] initWithTitle:title
               cancelButtonTitle:cancelButtonTitle
          destructiveButtonTitle:destructiveButtonTitle
               otherButtonTitles:otherButtonTitles
                selectSheetBlock:selectSheetBlock] show];
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray  *)otherButtonTitles
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title                  = title;
        _cancelButtonTitle      = cancelButtonTitle ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        _otherButtonTitles      = otherButtonTitles;
        _selectSheetBlock       = selectSheetBlock;
        [self setupCoverView];
        [self setupActionSheetView];
    }
    return self;
}

#pragma mark - DELEGATE

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray  *)otherButtonTitles
                               delegate:(id<SRActionSheetDelegate>)delegate
{
    [[[self alloc] initWithTitle:title
               cancelButtonTitle:cancelButtonTitle
          destructiveButtonTitle:destructiveButtonTitle
               otherButtonTitles:otherButtonTitles
                        delegate:delegate] show];
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray  *)otherButtonTitles
                     delegate:(id<SRActionSheetDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title                  = title;
        _cancelButtonTitle      = cancelButtonTitle ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        _otherButtonTitles      = otherButtonTitles;
        _delegate               = delegate;
        [self setupCoverView];
        [self setupActionSheetView];
    }
    return self;
}

#pragma mark - Setup

- (void)setupCoverView {
    
    [self addSubview:({
        self.coverView = [[UIView alloc] initWithFrame:self.bounds];
        self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self.coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        self.coverView.alpha = 0;
        self.coverView;
    })];
}

- (void)setupActionSheetView {
    
    [self addSubview:({
        self.actionSheetView = [[UIView alloc] init];
        self.actionSheetView.backgroundColor = kActionSheetViewColor;
        self.actionSheetView;
    })];
    
    CGFloat offsetY           = 0;
    CGFloat width             = self.frame.size.width;
    UIImage *normalImage      = [self imageWithColor:[UIColor whiteColor]];
    UIImage *highlightedImage = [self imageWithColor:kButtonHighlightedColor];
    
    if (self.title && self.title.length > 0) {
        [self.actionSheetView addSubview:({
            UILabel *titleLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kRowButtonHeight)];
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.textColor       = kTitleFontColor;
            titleLabel.textAlignment   = NSTextAlignmentCenter;
            titleLabel.font            = [UIFont systemFontOfSize:kTitleFontSize];
            titleLabel.numberOfLines   = 0;
            titleLabel.text            = self.title;
            titleLabel;
        })];
        offsetY += kRowButtonHeight + kRowLineHeight;
    }
    
    if (self.otherButtonTitles && self.otherButtonTitles.count > 0) {
        for (int i = 0; i < self.otherButtonTitles.count; i++) {
            [self.actionSheetView addSubview:({
                UIButton *otherBtn = [[UIButton alloc] init];
                otherBtn.frame = CGRectMake(0, offsetY, width, kRowButtonHeight);
                otherBtn.tag = i;
                otherBtn.backgroundColor = [UIColor whiteColor];
                otherBtn.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
                [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [otherBtn setTitle:self.otherButtonTitles[i] forState:UIControlStateNormal];
                [otherBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
                [otherBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                [otherBtn addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
                if (i == self.otherButtonTitles.count - 1) {
                    offsetY += kRowButtonHeight;
                } else {
                    offsetY += kRowButtonHeight + kRowLineHeight;
                }
                otherBtn;
            })];
        }
    }
    
    if (self.destructiveButtonTitle && self.destructiveButtonTitle.length > 0) {
        offsetY += kRowLineHeight;
        [self.actionSheetView addSubview:({
            UIButton *destructiveButton = [[UIButton alloc] init];
            destructiveButton.frame = CGRectMake(0, offsetY, width, kRowButtonHeight);
            destructiveButton.tag = self.otherButtonTitles.count ? self.otherButtonTitles.count : 0;
            destructiveButton.backgroundColor = [UIColor whiteColor];
            destructiveButton.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
            [destructiveButton setTitleColor:kDestructiveButtonNormalColor forState:UIControlStateNormal];
            [destructiveButton setTitle:self.destructiveButtonTitle forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [destructiveButton addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
             destructiveButton;
        })];
        offsetY += kRowButtonHeight;
    }
    
    [self.actionSheetView addSubview:({
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, width, kDividerViewHeight)];
        dividerView.backgroundColor = kDividerViewColor;
        dividerView;
    })];
    
    offsetY += kDividerViewHeight;
    [self.actionSheetView addSubview:({
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.frame = CGRectMake(0, offsetY, width, kRowButtonHeight);
        cancelBtn.tag = -1;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
         cancelBtn;
    })];
    
    offsetY += kRowButtonHeight;
    self.actionSheetHeight = offsetY;
    self.actionSheetView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), _actionSheetHeight);
}

#pragma mark - Actions

- (void)didSelectSheet:(UIButton *)button {
    
    if (_selectSheetBlock) {
        _selectSheetBlock(self, button.tag);
    }
    if ([_delegate respondsToSelector:@selector(actionSheet:didSelectSheet:)]) {
        [_delegate actionSheet:self didSelectSheet:button.tag];
    }
    [self dismiss];
}

#pragma mark - Animation

- (void)show {
    
    if(self.isShow) {
        return;
    }
    self.show = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.coverView.alpha = 1.0;
                         self.actionSheetView.transform = CGAffineTransformMakeTranslation(0, -self.actionSheetHeight);
    } completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.coverView.alpha = 0;
                         self.actionSheetView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Other

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

@end
