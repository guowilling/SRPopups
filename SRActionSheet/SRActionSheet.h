//
//  SRActionSheetView.h
//  SRActionSheetDemo
//
//  Created by 郭伟林 on 16/7/5.
//  Copyright © 2016年 SR. All rights reserved.
//

/**
 *  If you have any question, please issue or contact me.
 *  QQ: 396658379
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

 @param actionSheetView The same to the delegate.
 @param index           The same to the delegate.
 */
typedef void (^ActionSheetDidSelectSheetBlock)(SRActionSheet *actionSheetView, NSInteger index);

@interface SRActionSheet : UIView

#pragma mark - BLOCK

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray  *)otherButtonTitles
                       selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray  *)otherButtonTitles
             selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

#pragma mark - DELEGATE

+ (void)sr_showActionSheetViewWithTitle:(NSString *)title
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                 destructiveButtonTitle:(NSString *)destructiveButtonTitle
                      otherButtonTitles:(NSArray  *)otherButtonTitles
                               delegate:(id<SRActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray  *)otherButtonTitles
                     delegate:(id<SRActionSheetDelegate>)delegate;

@end
