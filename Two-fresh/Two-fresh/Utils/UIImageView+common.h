//
//  UIImageView+common.h
//  绿色家园
//
//  Created by yons on 15/12/30.
//  Copyright (c) 2015年 蒋玉顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
@interface UIImageView (common )

/**
 *     加载网络图片
 */
- (void)setImageUrl:(NSString *)imageURL;
/**
 *       加载网络图片和背静图片
 */
- (void)setImageUrl:(NSString *)imageURL placeholderImage:(NSString *)placeholder;

- (void)setImageUrl:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

- (void)setImageUrl:(NSString *)imamgeURL completed:(SDWebImageCompletionBlock)completedBlock;



@end
