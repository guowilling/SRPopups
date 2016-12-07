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

@property (nonatomic, weak) UIView  *cover;
@property (nonatomic, weak) UIView  *actionSheet;

@property (nonatomic, assign) CGFloat actionSheetHeight;
@property (nonatomic, assign, getter = isShow) BOOL show;

@property (nonatomic, copy) NSString  *title;
@property (nonatomic, copy) NSString  *cancelTitle;
@property (nonatomic, copy) NSString  *destructiveTitle;
@property (nonatomic, copy) NSArray   *otherTitles;
@property (nonatomic, copy) NSArray   *otherImages;

@end

@implementation SRActionSheet

#pragma mark - BLOCK

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                       selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;
{
    [[[self alloc] initWithTitle:title
                     cancelTitle:cancelTitle
                destructiveTitle:destructiveTitle
                     otherTitles:otherTitles
                selectSheetBlock:selectSheetBlock] show];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title            = title;
        _cancelTitle      = cancelTitle ? cancelTitle : @"取消";
        _destructiveTitle = destructiveTitle;
        _otherTitles      = otherTitles;
        _selectSheetBlock = selectSheetBlock;
        [self setupCover];
        [self setupActionSheet];
    }
    return self;
}

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                            otherImages:(NSArray  *)otherImages
                       selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock
{
    [[[self alloc] initWithTitle:title
                     cancelTitle:cancelTitle
                destructiveTitle:destructiveTitle
                     otherTitles:otherTitles
                     otherImages:otherImages
                selectSheetBlock:selectSheetBlock] show];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                  otherImages:(NSArray  *)otherImages
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title            = title;
        _cancelTitle      = cancelTitle ? cancelTitle : @"取消";
        _destructiveTitle = destructiveTitle;
        _otherTitles      = otherTitles;
        _otherImages      = otherImages;
        _selectSheetBlock = selectSheetBlock;
        [self setupCover];
        [self setupActionSheet];
    }
    return self;
}

#pragma mark - DELEGATE

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                               delegate:(id<SRActionSheetDelegate>)delegate
{
    [[[self alloc] initWithTitle:title
                     cancelTitle:cancelTitle
                destructiveTitle:destructiveTitle
                     otherTitles:otherTitles
                        delegate:delegate] show];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                     delegate:(id<SRActionSheetDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title            = title;
        _cancelTitle      = cancelTitle ? cancelTitle : @"取消";
        _destructiveTitle = destructiveTitle;
        _otherTitles      = otherTitles;
        _delegate         = delegate;
        [self setupCover];
        [self setupActionSheet];
    }
    return self;
}


+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                            otherImages:(NSArray  *)otherImages
                               delegate:(id<SRActionSheetDelegate>)delegate
{
    [[[self alloc] initWithTitle:title
                     cancelTitle:cancelTitle
                destructiveTitle:destructiveTitle
                     otherTitles:otherTitles
                     otherImages:otherImages
                        delegate:delegate] show];
}

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                  otherImages:(NSArray  *)otherImages
                     delegate:(id<SRActionSheetDelegate>)delegate
{
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title            = title;
        _cancelTitle      = cancelTitle ? cancelTitle : @"取消";
        _destructiveTitle = destructiveTitle;
        _otherTitles      = otherTitles;
        _otherImages      = otherImages;
        _delegate         = delegate;
        [self setupCover];
        [self setupActionSheet];
    }
    return self;
}

#pragma mark - Setup UI

- (void)setupCover {
    
    [self addSubview:({
        UIView *cover = [[UIView alloc] init];
        cover.frame = self.bounds;
        cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _cover = cover;
    })];
    _cover.alpha = 0;
}

- (void)setupActionSheet {
    
    [self addSubview:({
        UIView *actionSheet = [[UIView alloc] init];
        actionSheet.backgroundColor = kActionSheetViewColor;
        _actionSheet = actionSheet;
    })];
    
    CGFloat offsetY           = 0;
    CGFloat width             = self.frame.size.width;
    UIImage *normalImage      = [self imageFromColor:[UIColor whiteColor]];
    UIImage *highlightedImage = [self imageFromColor:kButtonHighlightedColor];
    
    if (_title && _title.length > 0) {
        [_actionSheet addSubview:({
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
    
    if (_otherTitles && _otherTitles.count > 0) {
        for (int i = 0; i < _otherTitles.count; i++) {
            [_actionSheet addSubview:({
                UIButton *otherBtn = [[UIButton alloc] init];
                otherBtn.frame = CGRectMake(0, offsetY, width, kRowButtonHeight);
                otherBtn.backgroundColor = [UIColor whiteColor];
                otherBtn.tag = i;
                [otherBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
                [otherBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                
                if (_otherImages && _otherImages.count > 0) {
                    UIImageView *icon = [[UIImageView alloc] init];
                    [otherBtn addSubview:({
                        icon.frame = CGRectMake(0, 0, kRowButtonHeight, kRowButtonHeight);
                        icon.image = _otherImages.count > i ? _otherImages[i] : nil;
                        icon.contentMode = UIViewContentModeCenter;
                        icon;
                    })];
                    
                    [otherBtn addSubview:({
                        UILabel *title = [[UILabel alloc] init];
                        title.frame = CGRectMake(CGRectGetMaxX(icon.frame), 0, width - CGRectGetMaxX(icon.frame), kRowButtonHeight);
                        title.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
                        title.tintColor = [UIColor blackColor];
                        title.text = _otherTitles[i];
                        title;
                    })];
                } else {
                    [otherBtn.titleLabel setFont:[UIFont systemFontOfSize:kButtonTitleFontSize]];
                    [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [otherBtn setTitle:_otherTitles[i] forState:UIControlStateNormal];
                }

                [otherBtn addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
                if (i == _otherTitles.count - 1) {
                    offsetY += kRowButtonHeight;
                } else {
                    offsetY += kRowButtonHeight + kRowLineHeight;
                }
                otherBtn;
            })];
        }
    }
    
    if (_destructiveTitle && _destructiveTitle.length > 0) {
        offsetY += kRowLineHeight;
        [_actionSheet addSubview:({
            UIButton *destructiveButton = [[UIButton alloc] init];
            destructiveButton.frame = CGRectMake(0, offsetY, width, kRowButtonHeight);
            destructiveButton.tag = _otherTitles.count ? _otherTitles.count : 0;
            destructiveButton.backgroundColor = [UIColor whiteColor];
            destructiveButton.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
            [destructiveButton setTitleColor:kDestructiveButtonNormalColor forState:UIControlStateNormal];
            [destructiveButton setTitle:_destructiveTitle forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [destructiveButton addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
             destructiveButton;
        })];
        offsetY += kRowButtonHeight;
    }
    
    [_actionSheet addSubview:({
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, width, kDividerViewHeight)];
        dividerView.backgroundColor = kDividerViewColor;
        dividerView;
    })];
    
    offsetY += kDividerViewHeight;
    [_actionSheet addSubview:({
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.frame = CGRectMake(0, offsetY, width, kRowButtonHeight);
        cancelBtn.tag = -1;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
         cancelBtn;
    })];
    
    offsetY += kRowButtonHeight;
    _actionSheet.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), offsetY);
    _actionSheetHeight = offsetY;
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

#pragma mark - Animations

- (void)show {
    
    if (self.isShow) {
        return;
    }
    
    self.show = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 1.0;
                         self.actionSheet.transform = CGAffineTransformMakeTranslation(0, -self.actionSheetHeight);
    } completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.9f initialSpringVelocity:0.7f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 0;
                         self.actionSheet.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Image From Color

- (UIImage *)imageFromColor:(UIColor *)color {
    
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
