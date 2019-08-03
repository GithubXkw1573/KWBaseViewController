//
//  YWBaseViewController.h
//  WowoMerchant
//
//  Created by 许开伟 on 2018/5/29.
//  Copyright © 2018年 NanjingYunWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KWPublicUISDK/PublicHeader.h>
#import <MJRefresh/MJRefresh.h>

typedef NS_ENUM(NSInteger, KWLoadType) {
    KWLoadTypeRefresh =0,//刷新
    KWLoadTypeMore=1,//加载更多
};

typedef void (^returnNeedData)(id resultData);

@interface YWBaseViewController : UIViewController<YWNaviBarViewDelegate>

@property (nonatomic, strong) YWNaviBarView *naviBar;


/**
 VC之间传递数据专用，需要在子类实现
 */
@property (nonatomic, copy) returnNeedData resultData;


/**
 获取上个页面controller

 @return return value description
 */
- (UIViewController *)preViewController;

- (void)leftButtonAction:(UIButton *)btn;

//需要子类复写
- (void)rightButtonAction:(UIButton *)btn;

/**
 *  判断是否是手机号码
 *
 *  @param mobileNum 字符串
 *
 *  @return bool
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum;


////菊花loading
//- (void)showHUD;
//- (void)HidenHUD;


/**
 封装下拉刷新控件至基类
 
 @param completion block返回结果
 @return nil
 */
- (MJRefreshStateHeader *)loadMJRefresh:(void (^)(void))completion;
//转菊花的style
- (MJRefreshStateHeader *)loadCircleMJRefresh:(void (^)(void))completion;

- (MJRefreshAutoFooter *)loadFootMJRefresh:(void (^)(void))completion;

@end
