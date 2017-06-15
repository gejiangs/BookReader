//
//  BaseTableViewController.h
//  BookReader
//
//  Created by 郭江 on 2017/6/14.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong)   UITableView *tableView;
@property (nonatomic, strong)   NSMutableArray *contentArray;

@end
