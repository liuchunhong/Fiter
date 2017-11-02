//
//  ViewController.m
//  Fiter
//
//  Created by 刘春红 on 2017/9/8.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "ViewController.h"
#import "WTYMainScreeningViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 40, 100, 100);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn
{
    WTYMainScreeningViewController *vc = [[WTYMainScreeningViewController alloc] init];
    //这两句必须有
    vc.currentIndex = 0;
    self.definesPresentationContext = YES; //self is presenting view controller
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    /** 设置半透明度 */
    vc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    [vc showVc];
    vc.determineJsonString = ^(NSString *jsonString) {
           NSLog(@"%@",jsonString);
    };
    vc.dismiss = ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; 
    };
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:NO completion:nil];  
}
  

@end
