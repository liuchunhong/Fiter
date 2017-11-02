//
//  WTYScreenModel.m
//  XinHua
//
//  Created by 刘春红 on 2017/6/22.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "ChildScreenModel.h"

@implementation ScreenModel
+(instancetype)modelWithDic:(NSDictionary *)dic
{
    ScreenModel *sc = [[ScreenModel alloc] init];
    sc.pId = dic[@"id"];
    sc.name = dic[@"name"];
    sc.isSelected = @"0";
    return sc;
}
@end

@implementation ChildScreenModel
+(instancetype)modelWithDic:(NSDictionary *)dic
{
    ChildScreenModel *sc = [[ChildScreenModel alloc] init];
    sc.pId = dic[@"id"];
    sc.name = dic[@"name"];
    sc.childList = [NSMutableArray array];
    for (NSDictionary *di in dic[@"childList"]) {
        ScreenModel *scModel = [ScreenModel modelWithDic:di];
        [sc.childList addObject:scModel];
    }
    return sc;
}
@end



