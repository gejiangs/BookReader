//
//  FirstViewController.m
//  BookReader
//
//  Created by 郭江 on 2017/6/7.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "FirstViewController.h"
#import "BookDirectoryViewController.h"

@interface FirstViewController ()


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"小说";
    
    self.contentArray = [NSMutableArray array];
    [self.contentArray addObject:@{@"title":@"桃运神医混都市", @"list":@"http://www.kenshu.cc/xiaoshuo/44805/0/"}];
    [self.contentArray addObject:@{@"title":@"玄界之门", @"list":@"http://www.kenshu.cc/xiaoshuo/33853/0"}];
    [self.contentArray addObject:@{@"title":@"大主宰", @"list":@"http://www.kenshu.cc/xiaoshuo/784/0/"}];
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *item = self.contentArray[indexPath.row];
    cell.textLabel.text = item[@"title"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BookDirectoryViewController *vc = [[BookDirectoryViewController alloc] init];
    vc.item = self.contentArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
