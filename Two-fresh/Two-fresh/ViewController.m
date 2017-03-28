//
//  ViewController.m
//  Two-fresh
//
//  Created by jiang on 2017/3/8.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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
    CGFloat  rowH=0;
    
    return rowH;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.view endEditing:YES];
    
}



@end
