//
//  UIImageView+common.m
//  绿色家园
//
//  Created by yons on 15/12/30.
//  Copyright (c) 2015年 蒋玉顺. All rights reserved.
//

#import "UIImageView+common.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (common)

- (void)imageURL:(NSString *)imageName {
    [self setImage:[UIImage imageNamed:imageName]];
}
- (void)setImageUrl:(NSString *)imageURL {
    [self sd_setImageWithURL:[NSURL URLWithString:imageURL] ];
}
- (void)setImageUrl:(NSString *)imageURL placeholderImage:(NSString *)placeholder {
    
    NSString *value = imageURL;
    NSString*imageStr=@"";

    if ((NSNull *)value == [NSNull null]) {
       imageStr=@"";
    }else
    {
        imageStr=imageURL;

    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:imageStr]
            placeholderImage:[UIImage imageNamed:placeholder]];
}
- (void)setImageUrl:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:imageURL placeholderImage:placeholder completed:completedBlock];
}
- (void)setImageUrl:(NSString *)imamgeURL completed:(SDWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:[NSURL URLWithString:imamgeURL] completed:completedBlock];
}





@end
