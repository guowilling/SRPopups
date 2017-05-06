//
//  SRActionSheetView.h
//  SRActionSheet
//
//  Created by https://github.com/guowilling on 16/7/5.
//  Copyright © 2016年 SR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRActionSheet;

typedef NS_ENUM(NSInteger, SROtherActionItemAlignment) {
    SROtherActionItemAlignmentLeft,
    SROtherActionItemAlignmentCenter
};

@protocol SRActionSheetDelegate <NSObject>

/**
 @param index The top is 0 and ++ to down, but cancel item's index is -1.
 */
- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index;

@end

/**
 @param index The same as the delegate.
 */
typedef void (^SRActionSheetDidSelectActionBlock)(SRActionSheet *actionSheet, NSInteger index);

@interface SRActionSheet : UIView

/**
 If no images default is SROtherActionItemAlignmentCenter otherwise default is SROtherActionItemAlignmentLeft.
 */
@property (nonatomic, assign) SROtherActionItemAlignment otherActionItemAlignment;

+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages selectActionBlock:(SRActionSheetDidSelectActionBlock)selectActionBlock;

+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages delegate:(id<SRActionSheetDelegate>)delegate;

- (void)show;

@end
