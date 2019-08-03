//
//  YWAlert.m
//  WowoMerchant
//
//  Created by kaiwei Xu on 2018/6/5.
//  Copyright © 2018年 NanjingYunWo. All rights reserved.
//

#import "YWAlert.h"
#import <KWOCMacroDefinite/KWOCMacro.h>
#import <Masonry/Masonry.h>
#import <KWCategoriesLib/NSString+Addition.h>

#define kDefaultTitleSize kBoldFont(17)
#define kDefaultMsgSize   kFont(15)
#define kDefaultBtnSize   kFont(16)
#define kDefaultColor     [UIColor blackColor]
#define kDefaultBtnColor  RGB(153,153,153)
#define kHilightBtnColor  RGB(48,131,255)
#define kBttonHeight      kHeight(50)
#define kMessageMaxShowHeight   kHeight(180)
#define kLineSpacing      3

@interface YWAlert ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *popView;
@property (nonatomic, strong) UIView *hline;
@property (nonatomic, strong) UIView *vline;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) void(^actionBlock)(NSInteger index);
@end

@implementation YWAlert

static YWAlert *sharedInstance = nil;
static dispatch_once_t onceToken;

+ (instancetype)sharedAlert{
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YWAlert alloc] init];
    });
    return sharedInstance;
}

//单例销毁
+ (void)destroy{
    onceToken = 0;
    sharedInstance = nil;
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;
    }
    return _backView;
}

- (UIView *)popView{
    if (!_popView) {
        _popView = [[UIView alloc] init];
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.layer.cornerRadius = 10;
        _popView.layer.masksToBounds = YES;
    }
    return _popView;
}

- (UIView *)hline {
    if (!_hline) {
        _hline = [[UIView alloc] init];
        _hline.backgroundColor = RGB(136, 136, 136);
    }
    return _hline;
}

- (UIView *)vline {
    if (!_vline) {
        _vline = [[UIView alloc] init];
        _vline.backgroundColor = RGB(136, 136, 136);
    }
    return _vline;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)msgLabel{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textAlignment = NSTextAlignmentCenter;
        _msgLabel.numberOfLines = 0;
    }
    return _msgLabel;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn addTarget:self
                     action:@selector(actionButtonCliked:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        [_rightBtn addTarget:self
                     action:@selector(actionButtonCliked:)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.showsHorizontalScrollIndicator = NO;
    }
    return _textView;
}

- (void)actionButtonCliked:(UIButton *)btn{
    [self close:^{
        if (btn == self.leftBtn) {
            if (self.actionBlock) {
                self.actionBlock(0);
            }
        }else{
            if (self.actionBlock) {
                self.actionBlock(1);
            }
        }
    }];
}

- (void)close:(void(^)(void))block{
    [UIView animateWithDuration:0.25f animations:^{
        self.backView.alpha = 0;
        self.popView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [self.popView removeFromSuperview];
        [YWAlert destroy];
        if (block) {
            block();
        }
    }];
}

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
          actionAtIndex:(void(^)(NSInteger index))block{
    
    return [self popAlertTitle:title
                     titleFont:kDefaultTitleSize
                    titleColor:kDefaultColor
                    titleAlign:NSTextAlignmentCenter
                       message:msg
                       msgFont:kDefaultMsgSize
                      msgColor:kDefaultColor
                   leftBtnText:okText
                      lbtnFont:kDefaultBtnSize
                     lbtnColor:kHilightBtnColor
                  rightBtnText:nil
                      rbtnFont:nil
                     rbtnColor:nil
                 actionAtIndex:block];
}

/**
 内容-确认【最精简样式】
 
 @param msg msg description
 */
- (void)popAlertMessage:(NSString *)msg{
    [self popAlertTitle:nil message:msg
              okBtnText:@"知道了"
          actionAtIndex:nil];
}

/**
 标题-内容-取消-确定（title=nil标题为空）

 @param title title description
 @param msg msg description
 @param block block description
 */
- (void)popConfirmTitle:(NSString *)title
              message:(NSString *)msg
        actionAtIndex:(void(^)(NSInteger index))block{
    
    //默认标题字体大小22
    //默认标题文案黑色
    //默认内容字体大小15
    //默认内容文案黑色
    return [self popAlertTitle:title
                     titleFont:kDefaultTitleSize
                    titleColor:kDefaultColor
                    titleAlign:NSTextAlignmentCenter
                       message:msg
                       msgFont:kDefaultMsgSize
                      msgColor:kDefaultColor
                   leftBtnText:@"取消"
                      lbtnFont:kDefaultBtnSize
                     lbtnColor:kDefaultBtnColor
                  rightBtnText:@"确定"
                      rbtnFont:kDefaultBtnSize
                     rbtnColor:kHilightBtnColor
                 actionAtIndex:block];
}


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
        actionAtIndex:(void(^)(NSInteger index))block{
    
    //默认标题字体大小22
    //默认标题文案黑色
    //默认内容字体大小15
    //默认内容文案黑色
    return [self popAlertTitle:title
                     titleFont:kDefaultTitleSize
                    titleColor:kDefaultColor
                    titleAlign:NSTextAlignmentCenter
                       message:msg
                       msgFont:kDefaultMsgSize
                      msgColor:kDefaultColor
                   leftBtnText:lbtnText
                      lbtnFont:kDefaultBtnSize
                     lbtnColor:kDefaultBtnColor
                  rightBtnText:rbtnText
                      rbtnFont:kDefaultBtnSize
                     rbtnColor:kHilightBtnColor
                 actionAtIndex:block];
}


/**
 长文本弹框（过长可滚动展示）

 @param title 标题
 @param msg 内容
 @param okText 确定
 */
- (void)popLongTextAlertTitle:(NSString *)title
                      message:(NSString *)msg
                       okText:(NSString *)okText{
    return [self popAlertTitle:title
                     titleFont:kDefaultTitleSize
                    titleColor:kDefaultColor
                    titleAlign:NSTextAlignmentLeft
                       message:msg
                       msgFont:kFont(15)
                      msgColor:RGB(102, 102, 102)
                   leftBtnText:okText
                      lbtnFont:kDefaultBtnSize
                     lbtnColor:kHilightBtnColor
                  rightBtnText:nil
                      rbtnFont:nil
                     rbtnColor:nil
                 actionAtIndex:nil];
}


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
        actionAtIndex:(void(^)(NSInteger index))block{
    
    self.actionBlock = block;
    
    self.window = [UIApplication sharedApplication].delegate.window;
    
    //UI初始化控件以及布局
    [self.window addSubview:self.backView];
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.window);
    }]; 
    [self.window addSubview:self.popView];
    [self.popView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_window);
        make.left.equalTo(_window).offset(kWidth(35));
        make.right.equalTo(_window).offset(-kWidth(35));
    }];
    
    if (title.length) {
        [self.popView addSubview:self.titleLabel];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.popView);
            make.top.equalTo(self.popView).offset(kHeight(20));
            make.left.equalTo(self.popView).offset(kWidth(15));
            make.right.equalTo(self.popView).offset(-kWidth(15));
        }];
        self.titleLabel.text = title;
        self.titleLabel.textColor = tColor;
        self.titleLabel.font = tFont;
        self.titleLabel.textAlignment = align;
    }
    
    CGFloat msgHeight = [msg getAttributTextHeightWithSpace:kLineSpacing
                                                   withFont:msgFont
                                                  withWidth:(SCREEN_WIDTH - kWidth(100))];
    if (msgHeight > kMessageMaxShowHeight) {
        [self.popView addSubview:self.textView];
        self.textView.attributedText = [msg attributeWithLineSpace:kLineSpacing];
        self.textView.textColor = msgColor;
        self.textView.font = msgFont;
        [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (title.length) {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(kHeight(5));
            }else{
                make.top.equalTo(self.popView).offset(kHeight(25));
            }
            make.left.equalTo(self.popView).offset(kWidth(15));
            make.right.equalTo(self.popView).offset(-kWidth(15));
            make.height.mas_equalTo(kMessageMaxShowHeight);
        }];
    }else{
        [self.popView addSubview:self.msgLabel];
        self.msgLabel.attributedText = [msg attributeWithLineSpace:kLineSpacing];
        self.msgLabel.textColor = msgColor;
        self.msgLabel.font = msgFont;
        self.msgLabel.textAlignment = align;
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (title.length) {
                make.top.equalTo(self.titleLabel.mas_bottom).offset(kHeight(10));
            }else{
                make.top.equalTo(self.popView).offset(kHeight(25));
            }
            make.left.equalTo(self.popView).offset(kWidth(15));
            make.right.equalTo(self.popView).offset(-kWidth(15));
        }];
    }
    
    [self.popView addSubview:self.hline];
    [self.hline mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (msgHeight > kMessageMaxShowHeight) {
            make.top.equalTo(self.textView.mas_bottom).offset(kHeight(0));
        }else{
            CGFloat offsetY = title.length ? kHeight(15) : kHeight(20);
            make.top.equalTo(self.msgLabel.mas_bottom).offset(offsetY);
        }
        make.height.mas_equalTo(@0.5);
        make.left.right.equalTo(self.popView);
    }];
    if (lbtnText.length && rbtnText.length) {
        [self.popView addSubview:self.leftBtn];
        [self.popView addSubview:self.rightBtn];
        [self.leftBtn setTitle:lbtnText forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:lbtnColor forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = lbtnFont;
        [self.rightBtn setTitle:rbtnText forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:rbtnColor forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = rbtnFont;
        //2个按钮
        [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.popView);
            make.top.equalTo(self.hline.mas_bottom);
            make.width.equalTo(self.popView).multipliedBy(0.5);
            make.height.mas_equalTo(kBttonHeight);
            make.bottom.equalTo(self.popView);
        }];
        [self.rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.popView);
            make.top.equalTo(self.hline.mas_bottom);
            make.width.equalTo(self.popView).multipliedBy(0.5);
            make.height.mas_equalTo(kBttonHeight);
            make.bottom.equalTo(self.popView);
        }];
        [self.popView addSubview:self.vline];
        [self.vline mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.hline.mas_bottom);
            make.width.mas_equalTo(@0.5);
            make.height.equalTo(self.leftBtn);
            make.centerX.equalTo(self.popView);
        }];
    }else{
        //1个按钮
        [self.popView addSubview:self.leftBtn];
        [self.leftBtn setTitle:lbtnText forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:lbtnColor forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = lbtnFont;
        [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.popView);
            make.top.equalTo(self.hline.mas_bottom);
            make.width.equalTo(self.popView);
            make.height.mas_equalTo(kBttonHeight);
            make.bottom.equalTo(self.popView);
        }];
    }
    
    //开始动画显示
    [self show];
    
}

- (void)show{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

    
    [self.popView.layer addAnimation:popAnimation forKey:nil];
    
    [UIView animateWithDuration:0.4f animations:^{
        self.backView.alpha = 0.5f;
    }];
}

@end
