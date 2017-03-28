//
//  XLAFBaseService.h
//  SesProject
//
//  Created by 谢传波 on 15/5/9.
//  Copyright (c) 2015年 ___coco-sh___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface XLAFBaseService : NSObject

@property (nonatomic,strong) AFHTTPRequestOperationManager *operationManager;

//单例
+ (instancetype) shareInstance;

@end
