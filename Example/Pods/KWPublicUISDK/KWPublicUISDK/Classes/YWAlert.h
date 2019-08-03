//
//  YWAlert.h
//  WowoMerchant
//
//  Created by kaiwei Xu on 2018/6/5.
//  Copyright © 2018年 NanjingYunWo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWAlert : NSObject

+ (instancetype)sharedAlert;

/************************ 云蜗通用弹框控件 **************************/

/**
 标题-内容-OK（title=nil标题为空）
 
 @param title title description
 @param msg msg description
 @param okText okText description
 @param block block description
 */
- (void)popAlertTitle:(NSString *)title
              message:(NSString *)msg
            okBtnText:(NSString *)okText
        actionAtIndex:(void(^)(NSInteger index))block;

/**
 内容-确认【最精简样式】
 
 @param msg msg description
 */
- (void)popAlertMessage:(NSString *)msg;


/**
 标题-内容-取消-确定（title=nil标题为空）
 
 @param title title description
 @param msg msg description
 @param block block description
 */
- (void)popConfirmTitle:(NSString *)title
                message:(NSString *)msg
          actionAtIndex:(void(^)(NSInteger index))block;



/**
 支持自定义左右按钮样式
 
 @param title title description
 @param msg msg description
 @param lbtnText lbtnText description
 @param rbtnText rbtnText description
 @param block block description
 */
- (void)popAlertTitle:(NSString *)title
              message:(NSString *)msg
          leftBtnText:(NSString *)lbtnText
         rightBtnText:(NSString *)rbtnText
        actionAtIndex:(void(^)(NSInteger index))block;


/**
 长文本弹框（过长可滚动展示）
 
 @param title 标题
 @param msg 内容
 @param okText 确定
 */
- (void)popLongTextAlertTitle:(NSString *)title
                      message:(NSString *)msg
                       okText:(NSString *)okText;

/**
 全部自定义
 
 @param title title description
 @param tFont tFont description
 @param tColor tColor description
 @param msg msg description
 @param msgFont msgFont description
 @param msgColor msgColor description
 @param lbtnText lbtnText description
 @param lbtnFont lbtnFont description
 @param lbtnColor lbtnColor description
 @param rbtnText rbtnText description
 @param rbtnFont rbtnFont description
 @param rbtnColor rbtnColor description
 @param block block description
 */
- (void)popAlertTitle:(NSString *)title
            titleFont:(UIFont *)tFont
           titleColor:(UIColor *)tColor
           titleAlign:(NSTextAlignment)align
              message:(NSString *)msg
              msgFont:(UIFont *)msgFont
             msgColor:(UIColor *)msgColor
          leftBtnText:(NSString *)lbtnText
             lbtnFont:(UIFont *)lbtnFont
            lbtnColor:(UIColor *)lbtnColor
         rightBtnText:(NSString *)rbtnText
             rbtnFont:(UIFont *)rbtnFont
            rbtnColor:(UIColor *)rbtnColor
        actionAtIndex:(void(^)(NSInteger index))block;

@end
