//
//  XLTableViewController.h
//  Two-fresh
//
//  Created by jiang on 2017/3/20.
//  Copyright © 2017年 蒋玉顺. All rights reserved.
//

#import "BaseViewController.h"

@interface XLTableViewController : BaseViewController


@property (nonatomic, strong) UITableView*tableView;

/// tableView的样式
@property (nonatomic, assign) BOOL isGrouped;




@end
