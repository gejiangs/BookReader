//
//  BookDetailViewController.m
//  BookReader
//
//  Created by 郭江 on 2017/6/14.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@property (nonatomic, strong)   UIWebView *webview;

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.item[@"title"];
    
    [self initUI];
    
    //获取缓存
    NSString *content = [[NSUserDefaults standardUserDefaults] objectForKey:self.item[@"link"]];
    if (content == nil) {
        [self loadData];
    }else{
        [self.webview loadHTMLString:content baseURL:nil];
    }
}

-(void)initUI
{
    [self addRightBarButton:@"刷新" target:self action:@selector(loadData)];
    
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_webview];
}

-(void)loadData
{
    NSURL *url = [NSURL URLWithString:self.item[@"link"]];
    
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
    NSString *str = [[content componentsSeparatedByString:@"<div class=\"article-con\">"] lastObject];
    str = [[str componentsSeparatedByString:@"<center><script>ad728();</script></center>"] firstObject];
    
//    NSString *top = [[str componentsSeparatedByString:@"<br/><span style='color:#4876FF'>"] firstObject];
//    NSString *bottom = [[str componentsSeparatedByString:@"---</span><br/>"] lastObject];
//    str = [NSString stringWithFormat:@"%@%@", top, bottom];
    
    [self.webview loadHTMLString:str baseURL:nil];
    
    //保存缓存
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:self.item[@"link"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
