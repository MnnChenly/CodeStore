//
//  MNGridMenuGroupView.h
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNGridMenuGroupView : UIView <UIScrollViewDelegate>

@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, copy) NSArray *items;

- (id)initWithItems:(NSArray *)items;
- (void)willDismiss;

@end
