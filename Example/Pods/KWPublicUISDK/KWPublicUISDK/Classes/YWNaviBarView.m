//
//  YWNaviBarView.m
//  WowoMerchant
//
//  Created by kaiwei Xu on 2018/6/6.
//  Copyright © 2018年 NanjingYunWo. All rights reserved.
//

#import "YWNaviBarView.h"
#import <KWOCMacroDefinite/KWOCMacro.h>
#import <Masonry/Masonry.h>

#define kButtonWidth kWidth(60)
#define kButtonHeight (NaviBarHeight - StatusBarHeight)
#define kTitleColor [UIColor blackColor]

@interface YWNaviBarView ()
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIImageView *backImgView;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *bottomLine;
@end

@implementation YWNaviBarView


/**
 建议用此方法初始化

 @param style 样式
 @return return value description
 */
- (instancetype)initWithStyle:(YWNaviBarStyle)style
                     delegate:(id<YWNaviBarViewDelegate>)delegate{
    //导航栏frame固定
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, NaviBarHeight);
    if (self = [super initWithFrame:frame]) {
        self.delegate = delegate;
        _barStyle = style;
        self.backgroundColor = [UIColor whiteColor];
        //初始化子控件
        [self initSubviews];
    }
    return self;
}

- (instancetype)init{
    //导航栏frame固定
    return [self initWithStyle:YWNaviBarStyleBackAndTitle delegate:nil];
}

//复写掉initWithFrame，让外层自定义frame失效
- (instancetype)initWithFrame:(CGRect)frame{
    //导航栏frame固定
    return [self initWithStyle:YWNaviBarStyleBackAndTitle delegate:nil];
}

- (void)initSubviews{
    if (self.barStyle == YWNaviBarStyleOnlyBack) {
        [self setupLeftButton];
    }else if (self.barStyle == YWNaviBarStyleOnlyTitle){
        [self setupTitle];
    }else if (self.barStyle == YWNaviBarStyleBackAndTitle){
        [self setupLeftButton];
        [self setupTitle];
    }else if (self.barStyle == YWNaviBarStyleBackAndTitle){
        [self setupLeftButton];
        [self setupTitle];
    }else if (self.barStyle == YWNaviBarStyleTitleAndRightButton){
        [self setupTitle];
        [self setupRightButton];
    }else if (self.barStyle == YWNaviBarStyleBackAndTitleAndRightButton) {
        [self setupLeftButton];
        [self setupTitle];
        [self setupRightButton];
    } else{
        //自定义
    }
    [self setupBottomLine];//默认不加底部细线
}

- (void)setupLeftButton{
    self.leftButton = [[UIButton alloc] init];
    self.leftButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self.leftButton];
    [self.leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.backImgView = [[UIImageView alloc] init];
    self.backImgView.image = ImageNamed(@"ic_chevron_left");
    self.backImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backImgView];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(self);
        make.width.mas_equalTo(kButtonWidth);
        make.height.mas_equalTo(kButtonHeight);
    }];
    
    [self.backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.leftButton);
    }];
}

- (void)leftButtonAction{
    if ([self.delegate respondsToSelector:@selector(leftButtonAction:)]) {
        [self.delegate leftButtonAction:self.leftButton];
    }
}

- (void)setupTitle{
    self.titleLabel  = [[UILabel alloc] init];
    self.titleLabel.font = kFont(18);
    self.titleLabel.textColor = kTitleColor;
    self.titleLabel.text = @"蜗蜗商家";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(kButtonHeight);
        make.bottom.equalTo(self);
        make.left.greaterThanOrEqualTo(self).offset(kButtonWidth+5);
        make.right.lessThanOrEqualTo(self).offset(-kButtonWidth-5);
    }];
}

- (void)setTitleText:(NSString *)text{
    self.titleLabel.text = text;
}

- (void)setupRightButton{
    self.rightButton = [[UIButton alloc] init];
    self.rightButton.backgroundColor = [UIColor clearColor];
    self.rightButton.titleLabel.font = kFont(15);
    [self.rightButton setTitleColor:RGB(48,131,255) forState:UIControlStateNormal];
    [self addSubview:self.rightButton];
    [self.rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.equalTo(self);
        make.width.mas_equalTo(kButtonWidth);
        make.height.mas_equalTo(kButtonHeight);
    }];
}

- (void)rightButtonAction{
    if ([self.delegate respondsToSelector:@selector(rightButtonAction:)]) {
        [self.delegate rightButtonAction:self.rightButton];
    }
}

- (void)setRightButtonText:(NSString *)text{
    [self.rightButton setTitle:text forState:UIControlStateNormal];
}

- (void)setRightButtonImg:(UIImage *)img{
    [self.rightButton setImage:img forState:UIControlStateNormal];
}

- (void)setLeftButtonImg:(UIImage *)img{
    self.backImgView.image = img;
}

- (void)setupBottomLine{
    self.bottomLine = [[UIImageView alloc] init];
    self.bottomLine.backgroundColor = RGB(225, 225, 225);
    [self addSubview:self.bottomLine];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)hiddenBottomLine{
    self.bottomLine.hidden = YES;
}
- (void)showBottomLine{
    self.bottomLine.hidden = NO;
}

- (void)removeAllSubviews{
    for(UIView *v in self.subviews){
        [v removeFromSuperview];
    }
}

- (void)setBarStyle:(YWNaviBarStyle)barStyle{
    if (_barStyle != barStyle) {
        _barStyle = barStyle;
        //先移除现有的
        [self removeAllSubviews];
        //再根据新的style，初始化子视图
        [self initSubviews];
    }
}

- (void)setHiddenLeftButton:(BOOL)hiddenLeftButton{
    self.leftButton.hidden = hiddenLeftButton;
    self.backImgView.hidden = hiddenLeftButton;
}

- (void)setRightButtonTitleFont:(UIFont *)font {
    self.rightButton.titleLabel.font = font;
}

- (void)setRightButtonTextColor:(UIColor *)color {
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
}

- (void)setHiddenRightButton:(BOOL)hiddenRightButton{
    self.rightButton.hidden = hiddenRightButton;
}

- (void)setIsShadow:(BOOL)isShadow{
    _isShadow = isShadow;
    if (isShadow) {
        self.bottomLine.hidden = YES;
        self.layer.shadowColor = RGBA(51, 51, 51, 0.1).CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowOpacity = 4;
    }
}
@end
