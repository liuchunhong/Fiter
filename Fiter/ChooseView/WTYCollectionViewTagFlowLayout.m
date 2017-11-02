//
// WTYCollectionViewTagFlowLayout.h
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "WTYCollectionViewTagFlowLayout.h"

@interface WTYCollectionViewTagFlowLayout()

@property (nonatomic, strong) NSMutableArray *itemAttributes;

@property (nonatomic, assign) CGFloat contentHeight;

//当前的itemSize
@property (nonatomic, assign) CGSize currentSize;

@end

@implementation WTYCollectionViewTagFlowLayout

- (id)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.itemSize = CGSizeMake(100.0f, 26.0f);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
    self.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 1);
    _itemAttributes = [NSMutableArray array];
}

#pragma mark -

- (void)prepareLayout {
    [self.itemAttributes removeAllObjects];
    self.contentHeight = 0;//每一次 都要显示的时候 要将它置0
    //初始的位置
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    //collection 的section个数
    NSInteger secCount = self.collectionView.numberOfSections;
    for (NSInteger j = 0; j < secCount; j++) {
        //每一个的header布局
        UICollectionViewLayoutAttributes *hederattributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:j]];
        hederattributes.frame =CGRectMake(0, self.contentHeight, self.collectionView.frame.size.width, 40);
        [self.itemAttributes addObject:hederattributes];
        //y的位置要循环加
        originY += hederattributes.frame.size.height;
        //显示内容的高度也要一直加
        self.contentHeight += hederattributes.frame.size.height + self.sectionInset.top; 
        //section中 的item个数
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:j];
        //循环里面cell的布局
        for (NSInteger i = 0; i < itemCount; i++) {      
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            //每个item的大小
            CGSize itemSize = [self itemSizeForIndexPath:indexPath];
            //当下一个cell超出显示的范围的时候 就要在另一行显示
            if ((originX + itemSize.width + self.sectionInset.right/2) > self.collectionView.frame.size.width) {
                originX = self.sectionInset.left;
                originY += itemSize.height + self.minimumLineSpacing;
                 self.contentHeight +=  itemSize.height +self.minimumLineSpacing;
            }
            //当每一个section的第一个数据 也要另一行显示
            if (i == 0) {
                _currentSize = itemSize;
                self.contentHeight +=_currentSize.height + self.minimumLineSpacing;
            }else{
                _currentSize = CGSizeZero;
            }
            //每一个的cell的大小
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
            [self.itemAttributes addObject:attributes];
            originX += itemSize.width + self.minimumInteritemSpacing;
        }
        originX = self.sectionInset.left;
        self.contentHeight += self.minimumLineSpacing;
         //每一个的footer布局
        UICollectionViewLayoutAttributes *footerttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForRow:0 inSection:j]];
        footerttributes.frame =CGRectMake(0, self.contentHeight, self.collectionView.frame.size.width, 1);
        self.contentHeight +=  1;
        originY = self.contentHeight  + self.sectionInset.bottom;
        [self.itemAttributes addObject:footerttributes];
    }
    
    self.contentHeight += self.sectionInset.bottom;
}
//
- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

//返回显示控件的所有布局
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.itemAttributes;
}

#pragma mark -


- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
   return self.itemSize;
}

@end
