
//
//  JSessionInfo.m
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "JSessionInfo.h"


static JSessionInfo *sessionInfo = nil;

@implementation JSessionInfo
@synthesize userDictionary;

+ (JSessionInfo *)sharedInstance
{
    
    @synchronized(self){
        
        if (!sessionInfo)
        {
            sessionInfo = [[JSessionInfo alloc] init];

            sessionInfo.userDictionary = [NSMutableDictionary dictionary];
        }
    }
    
    return sessionInfo;
}

- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

-(id)init
{
    self=[super init];
    
    if (self)
    {
    }
    
    return self;
}

@end
