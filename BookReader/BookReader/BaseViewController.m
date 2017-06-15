//
//  BaseViewController.m
//  BookReader
//
//  Created by 郭江 on 2017/6/15.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pushViewControllerName:(NSString *)VCName {
    id class = [[NSClassFromString(VCName) alloc] init];
    if (!class) {
        NSLog(@"%@ is not exist", VCName);
        return;
    }
    [self.navigationController pushViewController:class animated:YES];
}
-(void)pushViewControllerName:(NSString *)VCName animated:(BOOL)animated
{
    id objClass = [[NSClassFromString(VCName) alloc] init];
    if (objClass == nil) {
        NSLog(@"ViewController:%@ is not exist", VCName);
        return;
    }
    
    [self.navigationController pushViewController:objClass animated:animated];
}

-(void)addLeftBarButton:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    button.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = button;
}

-(void)addRightBarButton:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:title
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:action];
    button.tintColor = [UIColor blackColor];
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    self.navigationItem.rightBarButtonItems = @[button, space_item];
}

-(void)addLeftBarImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 40, 40);
    [barButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:space_item, item, nil];
}

-(void)addRightBarImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 40, 40);
    [barButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    UIBarButtonItem *space_item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space_item.width = -10;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:space_item,item,  nil];
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
