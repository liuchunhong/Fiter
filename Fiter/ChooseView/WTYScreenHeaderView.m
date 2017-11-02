//
//  WTYScreenHeaderView.m
//  XinHua
//
//  Created by 刘春红 on 2017/6/22.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "WTYScreenHeaderView.h"
#import "Masonry.h"

@interface WTYScreenHeaderView ()

//底部的线
@property (nonatomic, strong) UILabel *titleLable;

@end
@implementation WTYScreenHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createLabel]; 
    }
    return self;
    
}

- (void)createLabel
{
    _titleLable = [[UILabel alloc] init];
    _titleLable.font = [UIFont systemFontOfSize:15.0f];
    _titleLable.textColor = [UIColor redColor];
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    _titleLable.text = _titleString;
}

@end


@interface WTYScreenFooterView ()

//底部的线
@property (nonatomic, strong) UIView *lineView;

@end
@implementation WTYScreenFooterView
 - (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createLine]; 
    }
    return self;
}

- (void)createLine
{
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor blueColor];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(self.mas_width).offset(-40);
        make.height.mas_equalTo(1);
        
    }];
}
@end

