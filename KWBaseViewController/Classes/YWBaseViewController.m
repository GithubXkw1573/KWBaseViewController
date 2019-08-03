//
//  YWBaseViewController.m
//  WowoMerchant
//
//  Created by 许开伟 on 2018/5/29.
//  Copyright © 2018年 NanjingYunWo. All rights reserved.
//

#import "YWBaseViewController.h"
#import <KWCategoriesLib/NSArray+Safe.h>
#import <KWLogger/KWLogger.h>
#import <KWPublicUISDK/PublicHeader.h>

@interface YWBaseViewController ()<UIGestureRecognizerDelegate>

//@property(nonatomic,strong)MBProgressHUD *prohud;

@end

@implementation YWBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    //禁用系统自带的导航栏
    self.navigationController.navigationBarHidden = YES;
    //恢复手势返回
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //将导航栏提到最上层，防止阴影被遮住
    [self.view bringSubviewToFront:self.naviBar];
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    //打印controller页面名称，便于调试定位
    DDLogDebug(@"进入页面：%@", NSStringFromClass([self class]));
    
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     
    //默认统一背景色
    self.view.backgroundColor = kBackGroundColor;
    
    //默认统一加上默认的导航栏样式
    self.naviBar = [[YWNaviBarView alloc]
                    initWithStyle:YWNaviBarStyleBackAndTitle delegate:self];
        [self.view addSubview:self.naviBar];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//修复iOS8向下20像素的问题

}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if (self.isViewLoaded && !self.view.window) {
        self.view = nil;
    }
    
}

- (UIViewController *)preViewController{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        return [viewControllers safeObjectAtIndex:(viewControllers.count-2)];
    }else{
        return nil;
    }
}

#pragma mark ------- 导航栏UI 交互 委托 (子类可复写) ------
- (void)leftButtonAction:(UIButton *)btn{
    //如果子类不复写，默认动作是返回上一页
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//需要子类复写
- (void)rightButtonAction:(UIButton *)btn{
    
}


#pragma mark  判断是否为手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    NSString *MOBILE = @"^1\\d{10}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
    
    
    
}

//#pragma mark - loading菊花
//
//- (void)showHUD {
//    [Hud showLoadingWithMessage:nil addToView:self.view];
//}
//
//- (void)HidenHUD {
//    [Hud hideLoading];
//}

#pragma mark MJRefresh_Header
- (MJRefreshStateHeader *)loadMJRefresh:(void (^)(void))completion {
    //动画类刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (completion) {
            completion();
        }
    }];
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    //设置普通状态的动画图片
    [header setImages:[self normalImages] forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:[self refreshImages] forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:[self refreshImages] forState:MJRefreshStateRefreshing];
    
    return header;
}

//转菊花的style
- (MJRefreshStateHeader *)loadCircleMJRefresh:(void (^)(void))completion {
    //动画类刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (completion) {
            completion();
        }
    }];
    
    header.lastUpdatedTimeLabel.hidden= YES;
    header.stateLabel.hidden = YES;
    //设置普通状态的动画图片
    [header setImages:[self normalCircleImages] forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:[self refreshCircleImages] forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [header setImages:[self refreshCircleImages] forState:MJRefreshStateRefreshing];
    
    return header;
    
}

- (MJRefreshAutoFooter *)loadFootMJRefresh:(void (^)(void))completion {
    MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (completion) {
            completion();
        }
    }];
//    footer.automaticallyRefresh = NO;
//    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    footer.hidden = YES;//一开始默认隐藏
    return footer;
}

- (NSMutableArray *)normalImages {
    NSMutableArray  *normalImages = [[NSMutableArray alloc] init];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"wowo_refresh_1"]];
    
    [normalImages addObject:image];
    
    return normalImages;
}

//正在刷新状态下的图片
- (NSMutableArray *)refreshImages {
    NSMutableArray *refreshImages = [[NSMutableArray alloc] init];
    //                循环添加图片
    for (NSUInteger i = 1; i <= 20; i++ ) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"wowo_refresh_%lu", (unsigned long)i]];
        [refreshImages safeAddObject:image];
    }
    return refreshImages;
}

- (NSMutableArray *)normalCircleImages {
    NSMutableArray  *normalImages = [[NSMutableArray alloc] init];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"im_activity_1"]];
    [normalImages addObject:image];
    return normalImages;
}

//正在刷新状态下的图片
- (NSMutableArray *)refreshCircleImages {
    NSMutableArray *refreshImages = [[NSMutableArray alloc] init];
    //                循环添加图片
    for (NSUInteger i = 1; i <= 12; i++ ) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"im_activity_%ld", i]];
        [refreshImages safeAddObject:image];
    }
    return refreshImages;
}

- (void)dealloc{
    //管理是否存在内存泄漏
    DDLogDebug(@"页面释放：%@", NSStringFromClass([self class]));
}

@end
