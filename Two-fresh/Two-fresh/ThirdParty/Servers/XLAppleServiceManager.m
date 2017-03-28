//
//  XLAppleServiceManager.m
//  Michelin
//
//  Created by 谢传波 on 15/10/15.
//  Copyright © 2015年 Michelin. All rights reserved.
//

#import "XLAppleServiceManager.h"

@interface XLAppleServiceManager()

@end

@implementation XLAppleServiceManager
@synthesize delegate;

//get method
- (void)getDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary
{
    //获取请求的URL
    NSString *urlStr_ = [self getUrlOfMethod:method_];
    NSURL *url_ = [NSURL URLWithString:urlStr_];
    
    //参数处理
    NSMutableDictionary *baseInfoDic_ = [self handlerParameter:dictionary WithMethod:method_];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:6.0];
    
    //请求方式
    [request setHTTPMethod:@"GET"];
    
    //设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //设置body
    NSData *postBody = [NSJSONSerialization dataWithJSONObject:baseInfoDic_ options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:postBody];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        //        NSLog(@"data:%@", [data description]);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        NSLog(@"string:%@",string);
        
        if (!error && responseCode == 200)
        {
            
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
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
                //数据不是JSON格式
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                
                [dictionary setObject:[NSNumber numberWithInteger:-200] forKey:server_return_Code];
                
                [dictionary setObject:@"返回数据错误" forKey:server_return_Message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
                {
                    [self.delegate dataSourceDidError:dictionary withMethod:method_];
                }
                
            }
            
        }
        else
        {
            //End Error
            //error responseCode != 200
            
            [dictionary setObject:[NSNumber numberWithInteger:-100] forKey:server_return_Code];
            
            [dictionary setObject:@"请求服务失败\n请检查网络!" forKey:server_return_Message];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
            {
                [self.delegate dataSourceDidError:dictionary withMethod:method_];
            }
        }
    }];
    
}

//post method
- (void)postDataWithMethod:(NSString *)method_ withDictionary:(NSMutableDictionary*)dictionary
{
    
    //获取请求的URL
    NSString *urlStr_ = [self getUrlOfMethod:method_];
    NSURL *url_ = [NSURL URLWithString:urlStr_];
    
    //参数处理
    NSMutableDictionary *baseInfoDic_ = [self handlerParameter:dictionary WithMethod:method_];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url_
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:6.0];
    
    //请求方式
    [request setHTTPMethod:@"POST"];
    
    //设置请求头
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //设置body
    NSData *postBody = [NSJSONSerialization dataWithJSONObject:baseInfoDic_ options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:postBody];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        
        //        NSLog(@"data:%@", [data description]);
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        NSLog(@"string:%@",string);
        
        if (!error && responseCode == 200)
        {
            
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
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
                //数据不是JSON格式
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                
                [dictionary setObject:[NSNumber numberWithInteger:-200] forKey:server_return_Code];
                
                [dictionary setObject:@"返回数据错误" forKey:server_return_Message];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
                {
                    [self.delegate dataSourceDidError:dictionary withMethod:method_];
                }
                
            }
            
        }
        else
        {
            //End Error
            //error responseCode != 200
            
            [dictionary setObject:[NSNumber numberWithInteger:-100] forKey:server_return_Code];
            
            [dictionary setObject:@"请求服务失败\n请检查网络!" forKey:server_return_Message];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(dataSourceDidError:withMethod:)])
            {
                [self.delegate dataSourceDidError:dictionary withMethod:method_];
            }
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
    
    /*
     //所有接口都需要添加硬件设备id
     [parameter_ setObject:@"3" forKey:@"app"];
     [parameter_ setObject:@"ad5133feacd235892a21a843e4d121c28c7c0c65" forKey:@"did"];
     //ticket
     NSString *ticket_ = [[JSessionInfo sharedInstance].userInfoDictionary objectForKey:USER_TICKET];
     if (!ticket_)
     {
     ticket_ = @"";
     }
     [parameter_ setObject:ticket_ forKey:USER_TICKET];
     */
    
    /*
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter_
     options:NSJSONWritingPrettyPrinted
     error:nil];
     
     NSString *parameterJsonStr_ = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     
     [parameter_ removeAllObjects];
     [parameter_ setObject:parameterJsonStr_ forKey:parameterKey];
     */
    
    return parameter_;
    
}

@end
