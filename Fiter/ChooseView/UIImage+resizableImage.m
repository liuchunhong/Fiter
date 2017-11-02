//
//  UIImage+resizableImage.m
//  XinHua
//
//  Created by 刘春红 on 2017/6/21.
//  Copyright © 2017年 刘春红. All rights reserved.
//

#import "UIImage+resizableImage.h"

@implementation UIImage (resizableImage)

+(UIImage *)resizableImageWithOriginalImageName:(NSString *)Original
{
    UIImage *originalImage = [UIImage imageNamed:Original];
    return [originalImage resizableImageWithCapInsets:UIEdgeInsetsMake(originalImage.size.height * 0.5, originalImage.size.width * 0.5, originalImage.size.height * 0.5, originalImage.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
}

@end
