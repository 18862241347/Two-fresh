
//
//  XLAFServiceManger.m
//  SesProject
//
//  Created by 谢传波 on 15/4/30.
//  Copyright (c) 2015年 ___coco-sh___. All rights reserved.
//

#define parameterKey @"postData"

#import "XLAFServiceManger.h"

@interface XLAFServiceManger()

@end

@implementation XLAFServiceManger
@synthesize delegate;


//get method
- (void)getDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary
{
     //获取请求的URL
     NSString *urlStr_ = [self getUrlOfMethod:method_];
     
     //参数处理
     NSMutableDictionary *baseInfoDic_ = [self handlerParameter:dictionary WithMethod:method_];
    
    XLAFBaseService *afBaseService_ = [XLAFBaseService shareInstance];
    
    [afBaseService_.operationManager GET:urlStr_ parameters:baseInfoDic_ success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        // NSLog(@"request success");
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dictionary = (NSDictionary *)responseObject;
            
            NSInteger returnCode_ = [[dictionary objectForKey:server_return_Code] integerValue];
            if (returnCode_ == server_return_SusseccCode)
            {
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidLoad:withMethod:)])
                {
                    [self.delegate dataSourceDidLoad:dictionary withMethod:method_];
                }
                
            }
            else
            {
                if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidFailed:withMethod:)])
                {
                    [self.delegate dataSourceDidFailed:dictionary withMethod:method_];
                }
                
            }
            
        }
        else
        {
            NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
            
            [dictionary setObject:[NSNumber numberWithInteger:-200] forKey:server_return_Code];
            
            [dictionary setObject:@"返回数据错误" forKey:server_return_Message];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
            {
                [self.delegate dataSourceDidError:dictionary withMethod:method_];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        
        [dictionary setObject:[NSNumber numberWithInteger:-100] forKey:server_return_Code];
        
        [dictionary setObject:@"请求服务失败\n请检查网络!" forKey:server_return_Message];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
        {
            [self.delegate dataSourceDidError:dictionary withMethod:method_];
        }
        
    }];
    
}

//post method
- (void)postDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary
{

     //获取请求的URL
     NSString *urlStr_ = [self getUrlOfMethod:method_];
     
     //参数处理
     NSMutableDictionary *baseInfoDic_ = [self handlerParameter:dictionary WithMethod:method_];
    
    XLAFBaseService *afBaseService_ = [XLAFBaseService shareInstance];
    
    
    urlStr_ =@"";
    [afBaseService_.operationManager POST:urlStr_ parameters:baseInfoDic_ success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *dictionary = (NSDictionary *)responseObject;
             
             
             NSData *jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
             NSString *jsonStr_ = [[NSString alloc]initWithData:jsonData_ encoding:NSUTF8StringEncoding];
             NSLog(@"response json:%@", jsonStr_);
           
             NSString *filePatch = @"/Users/jiang/Desktop/column.plist";
             [jsonStr_ writeToFile:filePatch atomically:YES];
             
             NSInteger returnCode_ = [[dictionary objectForKey:server_return_Code] integerValue];
             if (returnCode_ == server_return_SusseccCode)
             {
                 if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidLoad:withMethod:)])
                 {
                     [self.delegate dataSourceDidLoad:dictionary withMethod:method_];
                 }
                 
             }
             else if (returnCode_ == server_return_UnLogIn)
             {
                 if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
                 {
                     [self.delegate dataSourceDidError:dictionary withMethod:method_];
                 }
             }
             else
             {
                 if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidFailed:withMethod:)])
                 {
                     [self.delegate dataSourceDidFailed:dictionary withMethod:method_];
                 }
                 
             }
             
         }
         else
         {
             NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
             
             [dictionary setObject:[NSNumber numberWithInteger:-200] forKey:server_return_Code];
             
             [dictionary setObject:@"返回数据错误" forKey:server_return_Message];
             
             if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
             {
                 [self.delegate dataSourceDidError:dictionary withMethod:method_];
             }
             
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
         NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
         
         [dictionary setObject:[NSNumber numberWithInteger:-100] forKey:server_return_Code];
         
         [dictionary setObject:@"网络通讯\n请检查网络!" forKey:server_return_Message];
         
         if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
         {
             [self.delegate dataSourceDidError:dictionary withMethod:method_];
         }
         
     }];
}

#pragma mark-
#pragma mark---私有方法

//URL处理(不同的请求，请求路径有所不同)
- (NSString *)getUrlOfMethod:(NSString *)method_
{
    NSMutableString *urlStr_ = [NSMutableString string];
    
    [urlStr_ appendString:APP_SERVICE_BASE_URL];
    
    //不同方法，如果需要对URL进行特殊处理，在此处处理
    if ([method_ isEqualToString:@""])
    {
        //        [urlStr_ appendString:[NSString stringWithFormat:@"%@/%@",APP_LOAGIN_SERVER_URL,method_]];
        
    }
    else
    {
        [urlStr_ appendString:[NSString stringWithFormat:@"%@", method_]];
    }
    
    
    return [NSString stringWithString:urlStr_];
    
}

//参数处理(某些请求可能会添加特定的参数)
- (NSMutableDictionary *)handlerParameter:(NSMutableDictionary *)parameter_ WithMethod:(NSString *)method_
{
    
    //不同方法对参数需要做特殊处理， 在此处处理
    if ([method_ isEqualToString:@""])
    {
        
    }
    
    return parameter_;
    
}

@end
