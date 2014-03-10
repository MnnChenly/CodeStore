//
//  UIView+ConvertToImage.h
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-13.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//
//  截取某个UIView转换成图片

#import <UIKit/UIKit.h>

@interface UIView (ConvertToImage)

- (UIImage *)convertToImage;
- (UIImage *)convertToImageWithScale:(CGFloat)scale edgeInsets:(UIEdgeInsets)edgeInsets;

@end
