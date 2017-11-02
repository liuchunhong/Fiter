//
//  AF_MainScreeningViewController.h
//  差五个让步
//
//  Created by Elephant on 16/5/5.
//  Copyright © 2016年 Elephant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^determineButtonClickAndJsonString)(NSString *jsonString);

typedef void(^dismissSelf)();


@interface WTYMainScreeningViewController : UIViewController

//当前选中的第几个
@property (nonatomic, assign) NSInteger currentIndex;

- (void)showVc;

@property (copy, nonatomic) determineButtonClickAndJsonString determineJsonString;    //确定点击的jsonString

@property (copy, nonatomic) dismissSelf dismiss;    //消失

@end
