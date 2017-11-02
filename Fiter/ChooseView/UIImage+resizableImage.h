//
//  UIImage+resizableImage.h
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (resizableImage)

//Original 原始图片的名称 返回 拉伸后的图片
+(UIImage *)resizableImageWithOriginalImageName:(NSString *)Original;

@end
