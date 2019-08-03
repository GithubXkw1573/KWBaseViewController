//
//  KWOCMacro.h
//  Pods
//
//  Created by kaiwei Xu on 2019/7/24.
//

#ifndef KWOCMacro_h
#define KWOCMacro_h

//-------------------获取设备大小-------------------------
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kWidth(x)  (x * SCREEN_WIDTH/375.f)
#define kHeight(x) kWidth(x)

//是否是刘海屏（iPhoneX+）
#define IsNotchScreen (SCREEN_HEIGHT > 800 ? YES : NO)

//NavBar高度
#define NaviBarHeight (IsNotchScreen ? 88 : 64)

//StatusBar高度
#define StatusBarHeight (IsNotchScreen ? 44 : 20)

//Tabbar高度
#define TabBarHeight (IsNotchScreen ? 83 : 49)

//自定义适配
#define fixPt(x,y,z) (ScreenWidth <= 320 ? x : (ScreenWidth <= 375 ? y : z))

//字体
#define kFont(x)     [UIFont systemFontOfSize:x]
#define kBoldFont(x) [UIFont boldSystemFontOfSize:x]

//颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)    RGBA(r, g, b, 1.0f)

//获取系统版本
#define IOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]
#define iOS_9_Later    IOS_VERSION >= 9.0
#define iOS_10_Later   IOS_VERSION >= 10.0
#define iOS_11_Later   IOS_VERSION >= 11.0

//class类型判断
#define kIsDic(x) [x isKindOfClass:[NSDictionary class]]
#define kIsArr(x) [x isKindOfClass:[NSArray class]]
#define kIsStr(x) [x isKindOfClass:[NSString class]]

//UIImage
#define ImageNamed(imageName) [UIImage imageNamed:imageName]

//系统单利
#define USER_DEFAULTS          [NSUserDefaults standardUserDefaults]
#define NOTIFICATION_CENTER    [NSNotificationCenter defaultCenter]


//weakSelf
#define Weakify(type)  __weak typeof(type) weak##type = type;
#define Strongfy(type)  __strong typeof(type) type = weak##type

//userDefault 存取
#define disk_set(object, key)   \
({ \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];\
[defaults setObject:object forKey:key];  \
[defaults synchronize];\
})

#define disk_get(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]


#define disk_remove(_key)                                         \
({                                                                          \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults removeObjectForKey:_key];                                     \
[defaults synchronize];                                                 \
})

//----------------------------- 沙盒路径 ------------------------//
// 获取沙盒主目录路径
#define DEF_Sandbox_HomeDir     NSHomeDirectory()
// 获取Documents目录路径
#define DEF_DocumentsDir        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 获取Caches目录路径
#define DEF_CachesDir           [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//----------------------------- NSString赋值避免null ------------------------//
#define String_NotNil(string) (((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) ? ([string isKindOfClass:[NSNumber class]] ? [NSString stringWithFormat:@"%@",string] : @"") : string)


//----------------------------- 常用UI控件快速生成 ------------------------//
#define CreateGLabel(lbl,fnt,color,txt,alignment,superView)   \
lbl = [[UILabel alloc] init];  \
lbl.font = fnt;  \
lbl.textColor = color;  \
lbl.text = txt;  \
lbl.textAlignment = alignment;  \
[superView addSubview:lbl];

#define CreateLabel(lbl,fnt,color,txt,alignment,superView)   \
UILabel *lbl = [[UILabel alloc] init];  \
lbl.font = fnt;  \
lbl.textColor = color;  \
lbl.text = txt;  \
lbl.textAlignment = alignment;  \
[superView addSubview:lbl];

#define CreateGButton(btn,fnt,color,txt,sel,superView)  \
btn = [[UIButton alloc] init];  \
btn.titleLabel.font = fnt;  \
[btn setTitle:txt forState:UIControlStateNormal];  \
[btn setTitleColor:color forState:UIControlStateNormal];  \
[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];  \
[superView addSubview:btn];

#define CreateButton(btn,fnt,color,txt,sel,superView)  \
UIButton *btn = [[UIButton alloc] init];  \
btn.titleLabel.font = fnt;  \
[btn setTitle:txt forState:UIControlStateNormal];  \
[btn setTitleColor:color forState:UIControlStateNormal];  \
[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];  \
[superView addSubview:btn];

#define CreateImgButton(btn,imgName,sel,superView)  \
UIButton *btn = [[UIButton alloc] init];  \
[btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];  \
[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];  \
[superView addSubview:btn];

#define CreateGImgButton(btn,imgName,sel,superView)  \
btn = [[UIButton alloc] init];  \
[btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];  \
[btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];  \
[superView addSubview:btn];

#define CreateGImageView(imgv,imgName,superView)  \
imgv = [[UIImageView alloc] init];  \
imgv.image = [UIImage imageNamed:imgName];  \
[superView addSubview:imgv];

#define CreateImageView(imgv,imgName,superView)  \
UIImageView *imgv = [[UIImageView alloc] init];  \
imgv.image = [UIImage imageNamed:imgName];  \
[superView addSubview:imgv];

#define CreateGView(view,bgColor,superView)  \
view = [[UIView alloc] init];   \
view.backgroundColor = bgColor;  \
[superView addSubview:view];

#define CreateView(view,bgColor,superView)  \
UIView *view = [[UIView alloc] init];   \
view.backgroundColor = bgColor;  \
[superView addSubview:view];


#endif /* KWOCMacro_h */
