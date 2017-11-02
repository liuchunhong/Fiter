//
//  AF_MainScreeningViewController.m
// 
//
//  Created by Elephant on 16/5/5.
//  Copyright © 2016年 Elephant. All rights reserved.
//

#import "WTYMainScreeningViewController.h"

#import "WTYScreenViewController.h"

#define offset [UIScreen mainScreen].bounds.size.width - 50

@interface WTYMainScreeningViewController () 

@property (strong, nonatomic)   UIWindow *window;//Window
@property (strong, nonatomic) WTYScreenViewController *rvc ;    //筛选的vc
@end

@implementation WTYMainScreeningViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dismissWindow{
    //设置视图偏移
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = self.window.frame;
        rect.origin.x += (offset);
        self.window.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        self.window.hidden = YES;
        self.window = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /** 点击视图关闭window */
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissWindow)];
    [self.view addGestureRecognizer:tap];
    
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0, offset, [UIScreen mainScreen].bounds.size.height)];
        _window.hidden = NO;
        _window.rootViewController = self.rvc;  
    }
    return _window;
}
- (WTYScreenViewController *)rvc{
    if (!_rvc) {
        /** 加载window */
        _rvc = [[WTYScreenViewController alloc] init];
        _rvc.currentIndex = _currentIndex;
        typeof(self) __weak weakself = self;
        _rvc.determineButtonClick = ^(NSString *jsonString) {
            weakself.determineJsonString(jsonString);
            [weakself dismissWindow];
        };
        _rvc.width = offset;
    }
    return _rvc;
}

- (void)showVc
{
    //设置视图偏移
    [UIView animateWithDuration:.3 animations:^{
        CGRect rect = self.window.frame;
        rect.origin.x -= (offset);
        self.window.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }];
}

@end
