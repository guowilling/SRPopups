//
//  SRActionSheetView.h
//  SRActionSheet
//
//  Created by 郭伟林 on 16/7/5.
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
 @param actionSheet The SRActionSheet instance.
 @param index       The top is 0 and ++ to down, but cancel item's index is -1.
 */
- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index;

@end

/**
 @param actionSheet The same as the delegate.
 @param index       The same as the delegate.
 */
typedef void (^SRActionSheetDidSelectSheetBlock)(SRActionSheet *actionSheet, NSInteger index);

@interface SRActionSheet : UIView

/**
 The alignment of other action items. 
 If no images default is SROtherActionItemAlignmentCenter otherwise default is SROtherActionItemAlignmentLeft.
 */
@property (nonatomic, assign) SROtherActionItemAlignment otherActionItemAlignment;

/**
 Creates and returns an action sheet with title, cancelTitle, destructiveTitle, otherTitles, otherImages and selectSheetBlock.
 
 @param title            The title In the top.
 @param cancelTitle      The title of action item at the bottom.
 @param destructiveTitle The title of action item at the other action items bottom.
 @param otherTitles      The title of other action items.
 @param otherImages      The image of other action items.
 @param selectSheetBlock The callback block when select a action item.
 @return A SRActionSheet object.
 */
+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages selectSheetBlock:(SRActionSheetDidSelectSheetBlock)selectSheetBlock;

/**
 Creates and returns an action sheet with delegate.
 */
+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle otherTitles:(NSArray *)otherTitles otherImages:(NSArray *)otherImages delegate:(id<SRActionSheetDelegate>)delegate;

/**
 Displays the receiver.
 */
- (void)show;

@end
