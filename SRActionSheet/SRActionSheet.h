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

#pragma mark - BLOCK

/**
 Show a action sheet with block's way call-back, and the action item have title only.

 @param title            The title of action item which on the top.
 @param cancelTitle      The title of action item which at the bottom.
 @param destructiveTitle The title of action item which at the other action items bottom.
 @param otherTitles      The titles of other action items.
 @param selectSheetBlock The call-back's block when select a action item.
 */
+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                        selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

/**
 Show a action sheet with block's way call-back, and the action item have title and image both.
 
 @param title            The title of action item which on the top.
 @param cancelTitle      The title of action item which at the bottom.
 @param destructiveTitle The title of action item which at the other action items bottom.
 @param otherTitles      The titles of other action items.
 @param otherImages      The images of other action items.
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
                  otherImages:(NSArray  *)otherImages
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

#pragma mark - DELEGATE

/**
 Show a action sheet with delegate's way call-back, and the action item have title only.
 
 @param title            The title of action item which on the top.
 @param cancelTitle      The title of action item which at the bottom.
 @param destructiveTitle The title of action item which at the other action items bottom.
 @param otherTitles      The titles of other action items.
 @param delegate         The call-back's delegate when select a action item.
 */
+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                       destructiveTitle:(NSString *)destructiveTitle
                            otherTitles:(NSArray  *)otherTitles
                               delegate:(id<SRActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
                  cancelTitle:(NSString *)cancelTitle
             destructiveTitle:(NSString *)destructiveTitle
                  otherTitles:(NSArray  *)otherTitles
                     delegate:(id<SRActionSheetDelegate>)delegate;

/**
 Show a action sheet with delegate's way call-back, and the action item have title and image both.
 
 @param title            The title of action item which on the top.
 @param cancelTitle      The title of action item which at the bottom.
 @param destructiveTitle The title of action item which at the other action items bottom.
 @param otherTitles      The titles of other action items.
 @param otherImages      The images of other action items.
 @param delegate         The call-back's delegate when select a action item.
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

@end
