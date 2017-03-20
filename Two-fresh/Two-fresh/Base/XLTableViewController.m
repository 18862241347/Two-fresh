//
//  XLTableViewController.m
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "XLTableViewController.h"

@interface XLTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation XLTableViewController

-(void)setIsGrouped:(BOOL)isGrouped
{
    _isGrouped = isGrouped;
}

-(UITableView *)tableView
{
    if (_tableView==nil) {
        UITableView *tableView;
        CGFloat tableViewY = CGRectGetMaxY(self.barView.frame);
        if (_isGrouped == YES)
        {
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableViewY, SCREEN_WIDTH, SCREEN_HEIGHT-tableViewY) style:UITableViewStyleGrouped];
        }else
        {
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableViewY, SCREEN_WIDTH, SCREEN_HEIGHT-tableViewY) style:UITableViewStylePlain];
        }
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _tableView = tableView;
        
    }
    return _tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.tableView.backgroundColor = AppBackGroundColor;

}


#pragma mark ----
#pragma mark ----UITableViewDelegate----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[UITableViewCell cellWithTableView:tableView];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*bgView=[[UIView alloc]init];
    bgView.backgroundColor=AppBackGroundColor;
    return bgView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*bgView = [[UIView alloc]init];
    bgView.backgroundColor = AppBackGroundColor;
    return bgView;
    
}



@end
