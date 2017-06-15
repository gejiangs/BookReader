//
//  BaseViewController.h
//  BookReader
//
//  Created by 郭江 on 2017/6/15.
//  Copyright © 2017年 郭江. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)pushViewControllerName:(NSString *)VCName;
-(void)pushViewControllerName:(NSString *)VCName animated:(BOOL)animated;

-(void)addLeftBarButton:(NSString *)title target:(id)target action:(SEL)action;
-(void)addRightBarButton:(NSString *)title target:(id)target action:(SEL)action;
-(void)addLeftBarImageName:(NSString *)imageName target:(id)target action:(SEL)action;
-(void)addRightBarImageName:(NSString *)imageName target:(id)target action:(SEL)action;


@end
