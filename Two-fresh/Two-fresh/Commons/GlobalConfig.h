//
//  GlobalConfig.h
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#ifndef OrderPhone_Global_h
#define OrderPhone_Global_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//.storyboard
#define STORYBOARD_NAME (IS_IPAD? @"Main_iPad": @"Main_iPhone")

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1472), [[UIScreen mainScreen] currentMode].size) : NO)

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]                       //屏幕尺寸
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width             //屏幕宽度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height           //屏幕高度

#define iPhone5Width 320

//判断设备系统
#define  DEVICE_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define SHORT_VERSION_STRING [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define BUILD_VERSION_STRING [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//Iphone&Ipad 的键盘高度
//Iphone  横屏
#define IPHONE_LANDSCAPE_KEYBOARD_HEIGHT 140+50
//Iphone  竖屏
#define IPHONE_PORTRAIT_KEYBOARD_HEIGHT 266
//Ipad  横屏
#define IPAD_LANDSCAPE_KEYBOARD_HEIGHT 352+50
//Ipad  竖屏
#define IPAD_PORTRAIT_KEYBOARD_HEIGHT 264+50
//text和键盘间距
#define TEXTFIELD_KEYBOARD_DISTANCE 100

#define CELLH 10


//tabbarController
#define ROOTTAB ((AppDelegate*)[[UIApplication sharedApplication] delegate]).rootTab
#ifdef DEBUG
//#  define DLog(fmt, ...) do { NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__); [file release]; } while(0)
#  define DLog(fmt, ...) do { NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; NSLog((@"%@(%d) " fmt), [file lastPathComponent], __LINE__, ##__VA_ARGS__);  } while(0)
#  define DLog_METHOD NSLog(@"%s", __func__)
#  define DLog_CMETHOD NSLog(@"%@/%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#  define COUNT(p) NSLog(@"%s(%d): count = %d/n", __func__, __LINE__, [p retainCount]);
#  define DLog_TRACE(x) do {printf x; putchar('/n'); fflush(stdout);} while (0)
#else
#  define DLog(...)
#  define DLog_METHOD
#  define DLog_CMETHOD
#  define COUNT(p)
#  define DLog_TRACE(x)
#endif

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self






#define CellLineHeight 5

//       颜色值
//customer navBar background color
#define CustomNavBarBackgroundColor UICOLOR_HEX(0xFEF935)
//APP background color
#define AppBackGroundColor UICOLOR_HEX(0xf0f2f5)
//APP red backgroundColor
#define kAppRedColor UICOLOR_HEX(0xff3e3e)
//APP orange backgroundColor
#define kAppOrangeColor UICOLOR_HEX(0xff6633)
#define kAppGrayColor UICOLOR_HEX(0xa5a4a8)
#define kAppBlackColor UICOLOR_HEX(0x484746)
#define kAppYellowColor UICOLOR_HEX(0xFCD34D)
//cell灰色分割线颜色
#define CellLightGrayLineColour UICOLOR_HEX(0xdddddd)
//蒙层
#define GreyLayerBackgroundColor [UIColor colorWithRed:72 / 255.0 green:71 / 255.0 blue:70 / 255.0 alpha:0.6];



//  颜色
#define UICOLOR_HEX(hexColor) \
[UIColor colorWithRed: (((hexColor >> 16) & 0xFF)) / 255.0f green: (((hexColor >> 8) & 0xFF)) / 255.0f blue: ((hexColor & 0xFF)) / 255.0f alpha:1.0f]




#endif
