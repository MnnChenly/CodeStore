//
//  UIView+ConvertToImage.m
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-13.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "UIView+ConvertToImage.h"

@implementation UIView (ConvertToImage)

- (UIImage *)convertToImage
{
    return [self convertToImageWithScale:1 edgeInsets:UIEdgeInsetsZero];
}

- (UIImage *)convertToImageWithScale:(CGFloat)scale edgeInsets:(UIEdgeInsets)edgeInsets
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect rect = CGRectMake(edgeInsets.left, edgeInsets.top, image.size.width - edgeInsets.left - edgeInsets.right, image.size.height - edgeInsets.top - edgeInsets.bottom);
    rect.origin.x *= 2;
    rect.origin.y *= 2;
    rect.size.width *= 2;
    rect.size.height *= 2;
    image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, rect)];
    
    return image;
}

@end
