//
//  UIImage+common.m
//  绿色家园
//
//  Created by yons on 15/12/30.
//  Copyright (c) 2015年 蒋玉顺. All rights reserved.
//


#import "UIImage+common.h"

@implementation UIImage (Extension)

+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}
+(UIImage *)clipSquareImage:(UIImage *)image
{
    // 获取到图片后，进行剪切
    CGSize imgSize=image.size;
    CGFloat rectW=imgSize.width;
    if (imgSize.width>imgSize.height) {
        rectW=imgSize.height;
        
    }
    CGFloat rectH=rectW;
    
    CGFloat rectX=(imgSize.width-rectW)/2;
    CGFloat rectY=(imgSize.height-rectH)/2;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(rectX, rectY, rectW, rectH));
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return thumbScale;
}

+(UIImage *)clipCircularImage:(UIImage *)image
{
    
    CGFloat W = image.size.width;
    CGFloat H = image.size.height;
    CGFloat redius = ((W <= H) ? W : H)/2;
    CGRect  rect = CGRectMake( W/2-redius, H/2-redius, redius*2, redius*2);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImage.size.width, newImage.size.height), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newImage.size.width/2, newImage.size.height/2) radius:redius startAngle:0 endAngle:M_PI*2 clockwise:0];
    [path addClip];
    [newImage drawAtPoint:CGPointZero];
    
    UIImage *imageCut = UIGraphicsGetImageFromCurrentImageContext();
    
    return imageCut;
    
}
@end
