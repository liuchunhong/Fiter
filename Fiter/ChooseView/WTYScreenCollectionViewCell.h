//
//  WTYScreenCollectionViewCell.h
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTYScreenCollectionViewCell;
@protocol WTYScreenCollectionViewCellDelegate <NSObject>

- (void) WTYScreenCollectionViewCell:(WTYScreenCollectionViewCell*)cell 
                            btnClick:(UIButton *)btn;
@end
@interface WTYScreenCollectionViewCell : UICollectionViewCell
//选择的按钮
@property (nonatomic,strong) UIButton  *contentBtn;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;


@property (nonatomic, weak)  id<WTYScreenCollectionViewCellDelegate> delegate;

@end
