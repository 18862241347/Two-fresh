
//
//  HomeViewController.m
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController


- (void)initCustomNabBarView
{
    
    // wx.freshfresh.com
    
}

- (void)initSettingData
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)queryCatList
{
    NSMutableDictionary *paraDic_ = [NSMutableDictionary dictionary];
    
    
    
    if (!self.serviceManager)
    {
        self.serviceManager = [[XLAFServiceManger alloc] init];
    }
    self.serviceManager.delegate = self;
    [GlobalUtils show_HUD:@""];
    [self.serviceManager postDataWithMethod:@"wx.freshfresh.com" withDictionary:paraDic_];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark--
#pragma mark--UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger   sectionCount=3;
    return sectionCount;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger   rowCount=1;
    
    return rowCount;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[UITableViewCell cellWithTableView:tableView];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat  rowH=10;
    
    return rowH;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self queryCatList];

}


@end
