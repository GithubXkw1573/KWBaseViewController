//
//  YWNaviBarView.h
//  WowoMerchant
//
//  Created by kaiwei Xu on 2018/6/6.
//  Copyright © 2018年 NanjingYunWo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YWNaviBarStyle) {
    YWNaviBarStyleBackAndTitle = 0,
    YWNaviBarStyleOnlyTitle = 1,
    YWNaviBarStyleOnlyBack = 2,
    YWNaviBarStyleBackAndTitleAndRightButton = 3,
    YWNaviBarStyleCustom = 4,
    YWNaviBarStyleTitleAndRightButton = 5,
};

@protocol YWNaviBarViewDelegate <NSObject>
@optional
- (void)leftButtonAction:(UIButton *)btn;
- (void)rightButtonAction:(UIButton *)btn;
@end

@interface YWNaviBarView : UIView
@property (nonatomic, weak) id<YWNaviBarViewDelegate> delegate;
@property (nonatomic, assign) YWNaviBarStyle barStyle;//默认只有返回按钮和标题

@property (nonatomic, assign) BOOL hiddenLeftButton;//默认不隐藏左边按钮
@property (nonatomic, assign) BOOL hiddenRightButton;//默认不隐藏右边按钮
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isShadow; //新增阴影
/**
 建议用此方法初始化
 
 @param style 样式
 @return return value description
 */
- (instancetype)initWithStyle:(YWNaviBarStyle)style
                     delegate:(id<YWNaviBarViewDelegate>)delegate;

//设置标题
- (void)setTitleText:(NSString *)text;

//设置右边按钮文案[可选]
- (void)setRightButtonText:(NSString *)text;

//设置右边按钮图片素材[可选]
- (void)setRightButtonImg:(UIImage *)img;

//设置右边按钮字体
- (void)setRightButtonTitleFont:(UIFont *)font;
//设置右边按钮文字颜色
- (void)setRightButtonTextColor:(UIColor *)color;

//设置左边按钮图片素材[可选]
- (void)setLeftButtonImg:(UIImage *)img;

//隐藏底部细线
- (void)hiddenBottomLine;
//显示底部细线
- (void)showBottomLine;

//移除所有子view,方便重写自定义
- (void)removeAllSubviews;

@end
