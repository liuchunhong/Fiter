//
//  WTYScreenCollectionViewCell.m
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "WTYScreenCollectionViewCell.h"

@interface WTYScreenCollectionViewCell ()


@end

@implementation WTYScreenCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.contentBtn];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentBtn.frame = self.bounds;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.contentBtn setTitle:@"" forState:UIControlStateNormal];
}

#pragma mark - setter/getter

- (UIButton *)contentBtn {
    if (!_contentBtn) {
        _contentBtn = [[UIButton alloc] initWithFrame:self.bounds];
        if ([UIScreen mainScreen].bounds.size.width  == 320.0) {
             _contentBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        }else{
             _contentBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        }
        [_contentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentBtn;
}

- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(WTYScreenCollectionViewCell:btnClick:)]) {
        [self.delegate WTYScreenCollectionViewCell:self btnClick:btn];
    }
}

@end
