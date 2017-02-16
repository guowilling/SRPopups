//
//  SRActionSheetView.h
//  SRActionSheetDemo
//
//  Created by 郭伟林 on 16/7/5.
//  Copyright © 2016年 SR. All rights reserved.
//

/**
 *  If you have any question, submit an issue or contact me.
 *  QQ: 1990991510
 *  Email: guowilling@qq.com
 *
 *  If this repo helps you, please give it a star, thanks a lot.
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
 @param index       Top is 0 and ++ to down, but cancelBtn's index is -1.
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
 Default is SROtherActionItemAlignmentCenter when no images.
 Default is SROtherActionItemAlignmentLeft when there are images.
 */
@property (nonatomic, assign) SROtherActionItemAlignment otherActionItemAlignment;

/**
 Create a sheet with block.
 
 @param title            Title on the top, not must.
 @param cancelTitle      Title of action item at the bottom, not must.
 @param destructiveTitle Title of action item at the other action items bottom, not must.
 @param otherTitles      Title of other action items, must.
 @param otherImages      Image of other action items, not must.
 @param selectSheetBlock The call-back's block when select a action item.
 */
+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title
                                cancelTitle:(NSString *)cancelTitle
                           destructiveTitle:(NSString *)destructiveTitle
                                otherTitles:(NSArray  *)otherTitles
                                otherImages:(NSArray  *)otherImages
                           selectSheetBlock:(ActionSheetDidSelectSheetBlock)selectSheetBlock;

/**
 Create a action sheet with delegate.
 */
+ (instancetype)sr_actionSheetViewWithTitle:(NSString *)title
                                cancelTitle:(NSString *)cancelTitle
                           destructiveTitle:(NSString *)destructiveTitle
                                otherTitles:(NSArray  *)otherTitles
                                otherImages:(NSArray  *)otherImages
                                   delegate:(id<SRActionSheetDelegate>)delegate;

- (void)show;

@end
