//
//  WTYScreenViewController.m
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "WTYScreenViewController.h"
#import "WTYScreenCollectionViewCell.h"
#import "ChildScreenModel.h"
#import "WTYScreenHeaderView.h"
#import "WTYCollectionViewTagFlowLayout.h"

#import "Masonry/Masonry.h"
#import "UIImage+resizableImage.h"


@interface WTYScreenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WTYScreenCollectionViewCellDelegate,WTYCollectionViewTagFlowLayoutDelegate>

//collectionView
@property (strong, nonatomic) UICollectionView * collectionView;

/** 重置按钮 */
@property (strong, nonatomic) UIButton * resetBut;
/** 确定按钮 */
@property (strong, nonatomic) UIButton * determineBut;



@end
static NSString * const reuseIdentifier = @"screenViewCell";
static NSString * const headerReuseIdentifier = @"headeViewIdentifier";
static NSString * const footerReuseIdentifier = @"footerViewIdentifier";

@implementation WTYScreenViewController


- (instancetype)init
{
    if (self = [super init]) {
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectArray = [NSMutableArray array];
    
    [self.view addSubview:self.collectionView];    
    [self.resetBut addTarget:self action:@selector(resetButClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.determineBut addTarget:self action:@selector(determineButClick:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
}
 
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil ) {
        _dataArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
        NSArray  *dicArray = [NSArray arrayWithContentsOfFile:path];
        //加载本地文件
        for (NSDictionary *dic in dicArray) {
            ChildScreenModel *screenModel = [ChildScreenModel modelWithDic:dic];
            [_dataArray addObject:screenModel];
        }
    }
    return _dataArray;  
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WTYCollectionViewTagFlowLayout *layout = [[WTYCollectionViewTagFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _width,[UIScreen mainScreen].bounds.size.height- 50 ) collectionViewLayout:layout];
        layout.delegate = self;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[WTYScreenCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[WTYScreenHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
        [_collectionView registerClass:[WTYScreenFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdentifier];
    }
    
    return _collectionView;
}

- (UIButton *)resetBut//重置
{
    if (!_resetBut) {
        _resetBut = [[UIButton alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, self.width/2, 50)];
        [_resetBut setBackgroundColor:[UIColor whiteColor]];
        [_resetBut setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_resetBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.view addSubview:_resetBut];
    }
    return _resetBut;
}
- (UIButton *)determineBut//确定
{
    if (!_determineBut) {
        _determineBut = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2, [UIScreen mainScreen].bounds.size.height - 50, self.width/2, 50)];
        [_determineBut setBackgroundColor:[UIColor redColor]];
        [_determineBut setTitle:@"确定" forState:UIControlStateNormal];
        [_determineBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_determineBut setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.view addSubview:_determineBut];
    }
    return _determineBut;
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    ChildScreenModel * model = self.dataArray[section];
    return model.childList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTYCollectionViewTagFlowLayout *layout = (WTYCollectionViewTagFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    ChildScreenModel * model = self.dataArray[indexPath.section];
    ScreenModel *innerModel =  model.childList[indexPath.item];
    CGRect frame = [[NSString stringWithFormat:@"  %@  ",innerModel.name] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]} context:nil];
    return CGSizeMake(frame.size.width + 10, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){  
        WTYScreenHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        ChildScreenModel *model = self.dataArray[indexPath.section];
        header.titleString = model.name;
        return header;
    }  
    else  { 
        WTYScreenFooterView * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdentifier forIndexPath:indexPath];
        return footer;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WTYScreenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectedIndexPath = indexPath;
    ChildScreenModel * model = self.dataArray[indexPath.section];
    ScreenModel *innerModel = model.childList[indexPath.item];
    [cell.contentBtn setTitle:[NSString stringWithFormat:@"  %@  ",innerModel.name]  forState:UIControlStateNormal];
    if ([innerModel.isSelected isEqualToString:@"1"]) {
        [cell.contentBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_select_bg"] forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_select_bg"] forState:UIControlStateHighlighted];
    }else{
        [cell.contentBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_normal_bg"] forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_normal_bg"] forState:UIControlStateHighlighted];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        WTYScreenCollectionViewCell *cell = (WTYScreenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ChildScreenModel * model = self.dataArray[indexPath.section];
    ScreenModel *innerModel = model.childList[indexPath.item];
    if ([innerModel.isSelected isEqualToString:@"1"]) {
        innerModel.isSelected = @"0";
    } else {
        innerModel.isSelected = @"1";
    }
    
    if ([innerModel.isSelected isEqualToString:@"1"]) {
        [cell.contentBtn setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_select_bg"] forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_select_bg"] forState:UIControlStateHighlighted];
        [self.selectArray addObject:innerModel];
    }else{
        [cell.contentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_normal_bg"] forState:UIControlStateNormal];
        [cell.contentBtn setBackgroundImage:[UIImage resizableImageWithOriginalImageName:@"tag_normal_bg"] forState:UIControlStateHighlighted];
        [self.selectArray removeObject:innerModel];
    }
}


//重置按钮点击
- (void)resetButClick:(UIButton *)btn{
    for (ScreenModel *model in self.selectArray) {
        model.isSelected = @"0";
    }
    [self.selectArray removeAllObjects];
    [self.collectionView reloadData];
    self.determineButtonClick(@"");
}

//确定按钮点击
- (void)determineButClick:(UIButton *)btn{
    if (self.selectArray.count == 0) {
        self.determineButtonClick(@"");
    }else{
        self.determineButtonClick([self toJSONData:[self convertArrayToDic:self.selectArray]]);
    }
}

- (NSString *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    if ([jsonData length] > 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData 
                                     encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

//将数组转成字典数组
- (NSArray *)convertArrayToDic:(NSArray *)Array
{
    NSMutableArray *dicArray = [NSMutableArray array];
    [Array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ScreenModel *model =  (ScreenModel *)obj;
        [dicArray addObject:@{@"id":model.pId}];
    }];
    return dicArray;
}


#pragma cell的代理方法
- (void)WTYScreenCollectionViewCell:(WTYScreenCollectionViewCell *)cell btnClick:(UIButton *)btn
{
    [self collectionView:self.collectionView didSelectItemAtIndexPath:cell.selectedIndexPath];
}

@end
