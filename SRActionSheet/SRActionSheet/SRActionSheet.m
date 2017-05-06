//
//  SRActionSheetView.m
//  SRActionSheet
//
//  Created by https://github.com/guowilling on 16/7/5.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "SRActionSheet.h"

#define SCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define SCREEN_WIDTH          [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT         [UIScreen mainScreen].bounds.size.height
#define SCREEN_ADJUST(Value)  SCREEN_WIDTH * (Value) / 375.0

#define kActionItemHeight  SCREEN_ADJUST(50)
#define kLineHeight        0.5
#define kDividerHeight     7.5

#define kTitleFontSize       SCREEN_ADJUST(15)
#define kActionItemFontSize  SCREEN_ADJUST(17)

#define kActionSheetColor            [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]
#define kTitleColor                  [UIColor colorWithRed:111.0f/255.0f green:111.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
#define kActionItemHighlightedColor  [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define kDestructiveItemNormalColor  [UIColor colorWithRed:255.0f/255.0f green:10.00f/255.0f blue:10.00f/255.0f alpha:1.0f]
#define kDividerColor                [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f]

@interface SRActionSheet ()

@property (nonatomic, weak) id<SRActionSheetDelegate> delegate;

@property (nonatomic, copy) SRActionSheetDidSelectActionBlock selectActionBlock;

@property (nonatomic, weak) UIView *cover;
@property (nonatomic, weak) UIView *actionSheet;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) NSString *destructiveTitle;
@property (nonatomic, copy) NSArray  *otherTitles;
@property (nonatomic, copy) NSArray  *otherImages;

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat actionSheetHeight;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;

@property (nonatomic, strong) NSMutableArray *otherActionItems;

@end

@implementation SRActionSheet

- (NSMutableArray *)otherActionItems {
    
    if (!_otherActionItems) {
        _otherActionItems = [NSMutableArray array];
    }
    return _otherActionItems;
}

- (UIImage *)normalImage {
    
    if (!_normalImage) {
        _normalImage = [self imageFromColor:[UIColor whiteColor]];
    }
    return _normalImage;
}

- (UIImage *)highlightedImage {
    
    if (!_highlightedImage) {
        _highlightedImage = [self imageFromColor:kActionItemHighlightedColor];
    }
    return _highlightedImage;
}

#pragma mark - BLOCK

+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages selectActionBlock:(SRActionSheetDidSelectActionBlock)selectActionBlock {
    
    return [[self alloc] initWithTitle:title cancelTitle:cancelTitle destructiveTitle:destructiveTitle otherTitles:otherTitles otherImages:otherImages selectActionBlock:selectActionBlock];
}

- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages selectActionBlock:(SRActionSheetDidSelectActionBlock)selectActionBlock {
    
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title             = title;
        _cancelTitle       = cancelTitle;
        _destructiveTitle  = destructiveTitle;
        _otherTitles       = otherTitles;
        _otherImages       = otherImages;
        _selectActionBlock = selectActionBlock;
        [self setupCover];
        [self setupActionSheet];
    }
    return self;
}

#pragma mark - DELEGATE

+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages delegate:(id<SRActionSheetDelegate>)delegate {
    
    return [[self alloc] initWithTitle:title cancelTitle:cancelTitle destructiveTitle:destructiveTitle otherTitles:otherTitles otherImages:otherImages delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages delegate:(id<SRActionSheetDelegate>)delegate {
    
    if (self = [super initWithFrame:SCREEN_BOUNDS]) {
        _title            = title;
        _cancelTitle      = cancelTitle;
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

- (void)setupActionSheet {
    
    [self addSubview:({
        UIView *actionSheet = [[UIView alloc] init];
        actionSheet.backgroundColor = kActionSheetColor;
        _actionSheet = actionSheet;
    })];
    
    _offsetY = 0;
    
    [self setupTitleLabel];
    
    [self setupOtherActionItems];
    
    [self setupDestructiveActionItem];
    
    [_actionSheet addSubview:({
        UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, _offsetY, self.frame.size.width, kDividerHeight)];
        dividerView.backgroundColor = kDividerColor;
        dividerView;
    })];
    
    [self setupCancelActionItem];
    
    _actionSheet.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), _offsetY);
    _actionSheetHeight = _offsetY;
}

- (void)setupCover {
    
    [self addSubview:({
        UIView *cover = [[UIView alloc] init];
        cover.frame = self.bounds;
        cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
        cover.alpha = 0;
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _cover = cover;
    })];
}

- (void)setupTitleLabel {
    
    if (!_title && _title.length == 0) {
        return;
    }
    [_actionSheet addSubview:({
        UILabel *titleLabel        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kActionItemHeight)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor       = kTitleColor;
        titleLabel.textAlignment   = NSTextAlignmentCenter;
        titleLabel.font            = [UIFont systemFontOfSize:kTitleFontSize];
        titleLabel.numberOfLines   = 0;
        titleLabel.text            = self.title;
        titleLabel;
    })];
    _offsetY += kActionItemHeight + kLineHeight;
}

- (void)setupOtherActionItems {
    
    if (!_otherTitles || _otherTitles.count == 0) {
        return;
    }
    for (int i = 0; i < _otherTitles.count; i++) {
        [_actionSheet addSubview:({
            UIButton *otherBtn = [[UIButton alloc] init];
            otherBtn.frame = CGRectMake(0, _offsetY, self.frame.size.width, kActionItemHeight);
            otherBtn.backgroundColor = [UIColor whiteColor];
            otherBtn.tag = i;
            [otherBtn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
            [otherBtn setBackgroundImage:self.highlightedImage forState:UIControlStateHighlighted];
            [otherBtn addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
            [otherBtn addSubview:({
                UIView *otherItem = [[UIView alloc] init];
                otherItem.backgroundColor = [UIColor clearColor];
                otherItem.userInteractionEnabled = NO;
                CGSize maxTitleSize = [self maxSizeInStrings:_otherTitles];
                if (_otherImages && _otherImages.count > 0) {
                    UIImageView *icon = [[UIImageView alloc] init];
                    [otherItem addSubview:({
                        icon.frame = CGRectMake(0, 0, kActionItemHeight, kActionItemHeight);
                        icon.image = _otherImages.count > i ? _otherImages[i] : nil;
                        icon.contentMode = UIViewContentModeCenter;
                        icon.tag = 2;
                        icon;
                    })];
                    [otherItem addSubview:({
                        UILabel *title = [[UILabel alloc] init];
                        title.frame = CGRectMake(CGRectGetMaxX(icon.frame), 0, maxTitleSize.width, kActionItemHeight);
                        title.font = [UIFont systemFontOfSize:kActionItemFontSize];
                        title.tintColor = [UIColor blackColor];
                        title.text = _otherTitles[i];
                        title.tag = 1;
                        title;
                    })];
                    otherItem.frame = CGRectMake(10, 0, kActionItemHeight + maxTitleSize.width, kActionItemHeight);
                } else {
                    [otherItem addSubview:({
                        UILabel *title = [[UILabel alloc] init];
                        title.frame = CGRectMake(0, 0, maxTitleSize.width, kActionItemHeight);
                        title.font = [UIFont systemFontOfSize:kActionItemFontSize];
                        title.tintColor = [UIColor blackColor];
                        title.text = _otherTitles[i];
                        title.textAlignment = NSTextAlignmentCenter;
                        title.tag = 1;
                        title;
                    })];
                    otherItem.frame = CGRectMake(self.frame.size.width * 0.5 - maxTitleSize.width * 0.5, 0, maxTitleSize.width, kActionItemHeight);
                }
                [self.otherActionItems addObject:otherItem];
                otherItem;
            })];
            if (i == _otherTitles.count - 1) {
                _offsetY += kActionItemHeight;
            } else {
                _offsetY += kActionItemHeight + kLineHeight;
            }
            otherBtn;
        })];
    }
}

- (void)setupDestructiveActionItem {
    
    if (!_destructiveTitle && _destructiveTitle.length == 0) {
        return;
    }
    _offsetY += kLineHeight;
    [_actionSheet addSubview:({
        UIButton *destructiveButton = [[UIButton alloc] init];
        destructiveButton.frame = CGRectMake(0, _offsetY, self.frame.size.width, kActionItemHeight);
        destructiveButton.tag = _otherTitles.count ? _otherTitles.count : 0;
        destructiveButton.backgroundColor = [UIColor whiteColor];
        destructiveButton.titleLabel.font = [UIFont systemFontOfSize:kActionItemFontSize];
        [destructiveButton setTitleColor:kDestructiveItemNormalColor forState:UIControlStateNormal];
        [destructiveButton setTitle:_destructiveTitle forState:UIControlStateNormal];
        [destructiveButton setBackgroundImage:self.normalImage forState:UIControlStateNormal];
        [destructiveButton setBackgroundImage:self.highlightedImage forState:UIControlStateHighlighted];
        [destructiveButton addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
        destructiveButton;
    })];
    _offsetY += kActionItemHeight;
}

- (void)setupCancelActionItem {
    
    if (!_cancelTitle || _cancelTitle.length == 0) {
        return;
    }
    _offsetY += kDividerHeight;
    [_actionSheet addSubview:({
        UIButton *cancelBtn = [[UIButton alloc] init];
        cancelBtn.frame = CGRectMake(0, _offsetY, self.frame.size.width, kActionItemHeight);
        cancelBtn.tag = -1;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kActionItemFontSize];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:self.highlightedImage forState:UIControlStateHighlighted];
        [cancelBtn addTarget:self action:@selector(didSelectSheet:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn;
    })];
    _offsetY += kActionItemHeight;
}

#pragma mark - Actions

- (void)didSelectSheet:(UIButton *)button {
    
    if (_selectActionBlock) {
        _selectActionBlock(self, button.tag);
    }
    if ([_delegate respondsToSelector:@selector(actionSheet:didSelectSheet:)]) {
        [_delegate actionSheet:self didSelectSheet:button.tag];
    }
    [self dismiss];
}

#pragma mark - Animations

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 1.0;
                         self.actionSheet.transform = CGAffineTransformMakeTranslation(0, -self.actionSheetHeight);
                     }
                     completion:nil];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 0.0;
                         self.actionSheet.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

#pragma mark - Assist Methods

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

- (CGSize)maxSizeInStrings:(NSArray *)strings {
    
    CGSize maxSize = CGSizeZero;
    CGFloat maxWith = 0.0;
    for (NSString *string in strings) {
        CGSize size = [self sizeOfString:string withFont:[UIFont systemFontOfSize:kActionItemFontSize]];
        if (maxWith < size.width) {
            maxWith = size.width;
            maxSize = size;
        }
    }
    return maxSize;
}

- (CGSize)sizeOfString:(NSString *)string withFont:(UIFont *)font {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - Public Methods

- (void)setOtherActionItemAlignment:(SROtherActionItemAlignment)otherActionItemAlignment {
    
    _otherActionItemAlignment = otherActionItemAlignment;
    
    switch (otherActionItemAlignment) {
        case SROtherActionItemAlignmentLeft:
        {
            for (UIView *actionItem in self.otherActionItems) {
                UILabel *title = [actionItem viewWithTag:1];
                title.textAlignment = NSTextAlignmentLeft;
                CGRect newFrame = actionItem.frame;
                newFrame.origin.x = 10;
                actionItem.frame = newFrame;
            }
            break;
        }
        case SROtherActionItemAlignmentCenter:
        {
            for (UIView *actionItem in self.otherActionItems) {
                UILabel *title = [actionItem viewWithTag:1];
                title.textAlignment = NSTextAlignmentCenter;
                CGRect newFrame = actionItem.frame;
                newFrame.origin.x = self.frame.size.width * 0.5 - newFrame.size.width * 0.5;
                actionItem.frame = newFrame;
            }
            break;
        }
    }
}

@end
