//
//  WTYScreenViewController.h
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
// 筛选的controller

#import <UIKit/UIKit.h>


typedef void(^determineButtonClick)(NSString *jsonString);

@interface WTYScreenViewController : UIViewController

//数组
@property (nonatomic, strong) NSMutableArray *dataArray;

//选中的数组
@property (nonatomic, strong) NSMutableArray *selectArray;

@property (assign, nonatomic) CGFloat width;

//当前选中的第几个
@property (nonatomic, assign) NSInteger currentIndex;

@property (copy, nonatomic) determineButtonClick determineButtonClick;    //点击确定的回调
@end
