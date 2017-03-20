//
//  UIImage+common.h
//  绿色家园
//
//  Created by yons on 15/12/30.
//  Copyright (c) 2015年 蒋玉顺. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/// 返回一张可以随意拉伸不变形的图片
+ (UIImage *)resizableImage:(NSString *)name;

/// 剪切一张正方形图片
+ (UIImage*)clipSquareImage:(UIImage*)image;

/// 将图片截成圆形图片
+ (UIImage *)clipCircularImage:(UIImage *)image;

@end
