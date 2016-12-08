//
//  SRActionSheetView.h
//  SRActionSheetDemo
//
//  Created by 郭伟林 on 16/7/5.
//  Copyright © 2016年 SR. All rights reserved.
//

/**
 *  If you have any question, please issue or contact me.
 *  QQ: 1990991510
 *  Email: guowilling@qq.com
 *
 *  If you like it, please star it, thanks a lot.
 *  Github: https://github.com/guowilling/SRActionSheet
 *
 *  Have Fun.
 */

#import <UIKit/UIKit.h>

@class SRActionSheet;

typedef NS_ENUM(NSInteger, SROtherActionItemAlignment) {
    SROtherActionItemAlignmentLeft,
    SROtherActionItemAlignmentCenter
};


@protocol SRActionSheetDelegate <NSObject>

@required

/**
 Delegate method

 @param actionSheet The SRActionSheet instance.
 @param index       Top is 0 and 0++ to down, but cancelBtn's index is -1.
 */
- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index;

@end

/**
 Block callback

 @param actionSheet The same as the delegate.
 @param index       The same as the delegate.
 */
typedef void (^ActionSheetDidSelectSheetBlock)(SRActionSheet *actionSheet, NSInteger index);

@interface SRActionSheet : UIView

/**
 Default is SROtherActionItemAlignmentCenter when no images but when there are images default is SROtherActionItemAlignmentLeft.
 */
@property (nonatomic, assign) SROtherActionItemAlignment otherActionItemAlignment;

#pragma mark - BLOCK

/**
 Show a action sheet with block, and the action item have title only.

 @param title            The title on the top.
 @param cancelTitle      The title of action item at the bottom.
 @param destructiveTitle The title of action item at the other action items bottom.
 @param otherTitles      The title of other action items.
 @param selectSheetBlock The call-back's block when select a action item.
 */
+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                        selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

/**
 Show a action sheet with block, and the action item have title and image both.
 
 @param title            The title on the top.
 @param cancelTitle      The title of action item at the bottom.
 @param destructiveTitle The title of action item at the other action items bottom.
 @param otherTitles      The title of other action items.
 @param otherImages      The image of other action items.
 @param selectSheetBlock The call-back's block when select a action item.
 */
+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                            otherImages:(NSArray  *)otherImages
                       selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                  otherImages:(NSArray  *)otherImages
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

#pragma mark - DELEGATE

/**
 Show a action sheet with delegate, and the action item have title only.
 */
+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                               delegate:(id<SRActionSheetDelegate>)delegate;

/**
 Show a action sheet with delegate, and the action item have title and image both.
 */
+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                            otherImages:(NSArray  *)otherImages
                               delegate:(id<SRActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                  otherImages:(NSArray  *)otherImages
                     delegate:(id<SRActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                     delegate:(id<SRActionSheetDelegate>)delegate;

- (void)show;
- (void)dismiss;

@end
