//
//  WTYScreenModel.h
//  XinHua
//
//  Created by 刘春红 on 2017/6/22.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "JSONModel/JSONModel.h"

@interface ScreenModel : JSONModel

@property (copy, nonatomic) NSString<Optional>* id;            //标题
@property (copy, nonatomic) NSString<Optional>*  pId;       //id
@property (copy, nonatomic) NSString<Optional>*  name;       //id

@property (copy, nonatomic) NSString<Optional>* isSelected;

//创建模型
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end

@protocol ScreenModel

@end

@interface ChildScreenModel : JSONModel

@property (copy, nonatomic) NSString<Optional>* id;            //标题
@property (copy, nonatomic) NSString<Optional>*  pId;       //id
@property (copy, nonatomic) NSString<Optional>*  name;       //id
@property (strong, nonatomic) NSMutableArray<ScreenModel,Optional>* childList;

//创建模型
+ (instancetype)modelWithDic:(NSDictionary *)dic;

@end

