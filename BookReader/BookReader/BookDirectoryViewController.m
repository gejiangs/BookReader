//
//  BookDirectoryViewController.m
//  BookReader
//
//  Created by 郭江 on 2017/6/14.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BookDirectoryViewController.h"
#import "BookDetailViewController.h"

@interface BookDirectoryViewController ()

@property (nonatomic, assign)   NSInteger readIndex;

@end

@implementation BookDirectoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"目录";
    self.title = self.item[@"title"];
    
    [self addRightBarButton:@"刷新" target:self action:@selector(loadData)];
    
    //获取缓存
    self.contentArray = [[NSUserDefaults standardUserDefaults] objectForKey:self.item[@"list"]];
    if (self.contentArray == nil && self.contentArray.count == 0) {
        [self loadData];
    }else{
        [self.tableView reloadData];
        
        //滚动至阅读
        NSString *readIndexKey = [NSString stringWithFormat:@"%@_read_index", self.item[@"list"]];
        self.readIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:readIndexKey] integerValue];
        if (self.readIndex >= 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.readIndex inSection:0]
                                  atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    }
}

-(void)loadData
{
    NSURL *url = [NSURL URLWithString:self.item[@"list"]];
    
    // 快捷方式获得session对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *string = [[NSString alloc] initWithData:data encoding:enc];
        
        [self convertContent:string];
    }];
    
    // 启动任务
    [task resume];
}

-(void)convertContent:(NSString *)content
{
    NSURL *url = [NSURL URLWithString:self.item[@"list"]];
    NSString *website = [NSString stringWithFormat:@"%@:%@", url.scheme, url.host];
    
    self.contentArray = [NSMutableArray array];
    NSString *str = [[content componentsSeparatedByString:@"<ul class=\"clearfix chapter-list\">"] lastObject];
    str = [[str componentsSeparatedByString:@"<center style='background: none repeat scroll"] firstObject];
    NSArray *list = [str componentsSeparatedByString:@"</a></span></li>"];
    for (NSString *s in list) {
        NSArray *a = [s componentsSeparatedByString:@"\">"];
        NSString *title = [a lastObject];
        NSString *link = [[[a firstObject] componentsSeparatedByString:@"<li><span><a href=\""] lastObject];
        
        [self.contentArray addObject:@{@"link":[NSString stringWithFormat:@"%@%@", website, link], @"title":title}];
    }
    
    //保存缓存
    [[NSUserDefaults standardUserDefaults] setObject:self.contentArray forKey:self.item[@"list"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
    cell.detailTextLabel.text = @"";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if (indexPath.row == self.readIndex) {
        cell.detailTextLabel.text = @"上次看到这里";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.readIndex = indexPath.row;
    [self.tableView reloadData];
    
    NSString *readIndexKey = [NSString stringWithFormat:@"%@_read_index", self.item[@"list"]];
    [[NSUserDefaults standardUserDefaults] setObject:@(indexPath.row) forKey:readIndexKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BookDetailViewController *vc = [[BookDetailViewController alloc] init];
    vc.item = self.contentArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
