//
// WTYCollectionViewTagFlowLayout.h
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTYCollectionViewTagFlowLayout;
@protocol WTYCollectionViewTagFlowLayoutDelegate <NSObject>

@optional
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WTYCollectionViewTagFlowLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WTYCollectionViewTagFlowLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(WTYCollectionViewTagFlowLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end

@interface WTYCollectionViewTagFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<WTYCollectionViewTagFlowLayoutDelegate> delegate;

@end
