//
//  XLAFBaseService.m
//  SesProject
//
//  Created by 谢传波 on 15/5/9.
//  Copyright (c) 2015年 ___coco-sh___. All rights reserved.
//

#define request_time_out 60

#import "XLAFBaseService.h"

static XLAFBaseService *baseService = nil;

@interface XLAFBaseService()

@end

@implementation XLAFBaseService

+ (instancetype) shareInstance
{
    if (!baseService)
    {
        baseService = [[XLAFBaseService alloc] init];
        baseService.operationManager = [[AFHTTPRequestOperationManager alloc] init];
        baseService.operationManager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
//        baseService.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        baseService.operationManager.requestSerializer.timeoutInterval = request_time_out;
        
        baseService.operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        baseService.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];
        
        /*
        [baseService.operationManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        */
        
//        [baseService.operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        
//        baseService.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/xml", @"application/json", nil];
        
//        baseService.operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        
    }
    
    return baseService;
    
}

@end
