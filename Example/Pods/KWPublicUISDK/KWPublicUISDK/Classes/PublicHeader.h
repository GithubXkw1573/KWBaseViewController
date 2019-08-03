//
//  PublicHeader.h
//  Pods
//
//  Created by kaiwei Xu on 2019/8/3.
//

#ifndef PublicHeader_h
#define PublicHeader_h

#import "YWAlert.h"
#import "YWNaviBarView.h"
#import <KWCategoriesLib/UIColor+Hex.h>

//16进制颜色
#define hexColor(x) [UIColor hexString:x]

//常用色值
// APP主题色,以后可能会修改，所以主题颜色统一用此宏定义
#define WormThemeColor hexColor(@"3083ff")

//  调试可能会用到的常见颜色
#define KWhite                             [UIColor whiteColor]
#define KRed                               [UIColor redColor]
#define KImagePlaceHolderColor             hexColor(@"f5f5f5")
#define kBlackFontColor                    hexColor(@"333333")
#define kGrayFontColor                     hexColor(@"666666")
#define kLightFontColor                    hexColor(@"999999")
#define kBackGroundColor                   hexColor(@"f5f5f5")
#define kTextFieldBottomLineEditingColor   hexColor(@"d2e6ff")

#define kCellLineColor                     hexColor(@"e1e1e1")
#define kCellLineColor2                    hexColor(@"eeeeee")
#define kOrangeFontColor                   hexColor(@"e69e7c")
#define kUnableBtnColor                    hexColor(@"bad7ff")
#define kHighLightBtnColor                 hexColor(@"2268cc")
#define KRedColor                          hexColor(@"ff4343")

//Alert
#define WormAlert     [YWAlert sharedAlert]
#define Alert(msg)    [WormAlert popAlertMessage:msg]

#endif /* PublicHeader_h */
