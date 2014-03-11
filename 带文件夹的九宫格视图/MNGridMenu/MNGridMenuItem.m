//
//  MNGridMenuItem.m
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "MNGridMenuItem.h"
#import "MNGridMenuGroupView.h"
#import <QuartzCore/QuartzCore.h>

@interface MNGridMenuItem()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isGroupMenu;
@property (nonatomic, strong) MNGridMenuGroupView *groupView;
@property (nonatomic, strong) UILabel *groupTitleLabel;
@property (nonatomic, strong) UIView *groupTapView;
@property (nonatomic, assign) BOOL isGroupHidden;

@end

@implementation MNGridMenuItem

- (UIView *)view
{
    if (!_view) {
        
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMNGridMenuItemHeight, kMNGridMenuItemWidth)];
        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake(8, 8, 60, 60);
        _imageButton.layer.cornerRadius = 6.7;
        [_imageButton.layer setMasksToBounds:YES];
        if (self.isGroupMenu) {
            
            self.image = ((MNGridMenuGroupView *)self.groupView).image;
        }
        [_imageButton setImage:self.image forState:UIControlStateNormal];
        [_imageButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:_imageButton];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 68, 60, 20)];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_view addSubview:_titleLabel];
    }
    return _view;
}

- (UIView *)groupView
{
    if (self.isGroupMenu && !_groupView) {
        
        _groupView = [[MNGridMenuGroupView alloc] initWithItems:self.items];
    }
    return _groupView;
}

- (void)showGroupView
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.groupTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, window.center.y - 200, 320, 40)];
    self.groupTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.groupTitleLabel.textColor = [UIColor whiteColor];
    self.groupTitleLabel.text = self.title;
    self.groupTitleLabel.font = [UIFont systemFontOfSize:27.0];
    
    self.groupTapView = [[UIView alloc] initWithFrame:rect];
    self.groupTapView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self.groupTitleLabel addGestureRecognizer:tapGR];
    [self.groupTapView addGestureRecognizer:tapGR];
    
    self.groupView.center = window.center;
    
    [window addSubview:self.groupTapView];
    [window addSubview:_groupTitleLabel];
    [window addSubview:self.groupView];
    [window makeKeyAndVisible];
    
    CGFloat duration = 0.2;
    
    CGFloat scale = 60.0 / 304.0;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:scale];
    scaleAnimation.toValue = @1;
    scaleAnimation.duration = duration;
    
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimation.fromValue = [NSNumber numberWithFloat:(6.7 / scale)];
    cornerRadiusAnimation.toValue = @34;
    cornerRadiusAnimation.duration = duration;
    
    CGPoint centerPoint = window.center;
    CGPoint itemCenterPoint = [self.imageButton.superview convertPoint:self.imageButton.frame.origin toView:nil];
    itemCenterPoint.x += 60 / 2;
    itemCenterPoint.y += 60 / 2;
    CGPoint fromPosition = self.groupView.layer.position;
    fromPosition.x = fromPosition.x - (centerPoint.x - itemCenterPoint.x);
    fromPosition.y = fromPosition.y - (centerPoint.y - itemCenterPoint.y);
    CGPoint toPosition = fromPosition;
    toPosition.x = toPosition.x - (itemCenterPoint.x - centerPoint.x);
    toPosition.y = toPosition.y - (itemCenterPoint.y - centerPoint.y);
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:toPosition];
    positionAnimation.duration = duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, cornerRadiusAnimation, positionAnimation];
    group.duration = duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeBoth;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.groupView.layer addAnimation:group forKey:@"groupAnimation"];
    
    self.groupTapView.alpha = 0;
    self.groupTitleLabel.alpha = 0;
    [UIView animateWithDuration:duration animations:^{
        
        self.groupTapView.alpha = 0.65;
        self.groupTitleLabel.alpha = 1;
    }];
    
    _isGroupHidden = NO;
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGR
{
    [self hideGroupViewAnimated:YES completion:nil];
}

- (void)hideGroupViewAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [(MNGridMenuGroupView *)self.groupView willDismiss];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (animated) {
        
        CGFloat duration = 0.2;
        [CATransaction begin];
        
        CGFloat scale = 60.0 / 304.0;
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1;
        scaleAnimation.toValue = [NSNumber numberWithFloat:scale];
        scaleAnimation.duration = duration;
        
        CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        cornerRadiusAnimation.fromValue = @34;
        cornerRadiusAnimation.toValue = [NSNumber numberWithFloat:(6.7 / scale)];
        cornerRadiusAnimation.duration = duration;
        
        CGPoint centerPoint = window.center;
        CGPoint itemCenterPoint = [self.imageButton.superview convertPoint:self.imageButton.frame.origin toView:nil];
        itemCenterPoint.x += 60 / 2;
        itemCenterPoint.y += 60 / 2;
        CGPoint fromPosition = self.groupView.layer.position;
        fromPosition.x = fromPosition.x - (centerPoint.x - itemCenterPoint.x);
        fromPosition.y = fromPosition.y - (centerPoint.y - itemCenterPoint.y);
        CGPoint toPosition = fromPosition;
        toPosition.x = toPosition.x - (itemCenterPoint.x - centerPoint.x);
        toPosition.y = toPosition.y - (itemCenterPoint.y - centerPoint.y);
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:toPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:fromPosition];
        positionAnimation.duration = duration;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[scaleAnimation, cornerRadiusAnimation, positionAnimation];
        group.duration = duration;
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeBoth;
        
        [self.groupView.layer addAnimation:group forKey:@"groupAnimation"];
        
        [UIView animateWithDuration:duration animations:^{
            
            self.groupTapView.alpha = 0;
            self.groupTitleLabel.alpha = 0;
        } completion:^(BOOL finished) {
            
            [self hideGroupViewAnimated:NO completion:completion];
        }];
        
        [CATransaction commit];
    }
    else
    {
        [self.groupTapView removeFromSuperview];
        [self.groupView removeFromSuperview];
        [_groupTitleLabel removeFromSuperview];
        if (completion) {
            
            completion();
        }
        _isGroupHidden = YES;
    }
}

- (void)setItems:(NSArray *)items
{
    if (items.count > 0) {
        
        _items = items;
        _isGroupMenu = YES;
    }
    else
    {
        _items = nil;
        _isGroupMenu = NO;
    }
}

- (void)clickButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didClickMNGridMenuItem:)]) {
        
        [self.delegate didClickMNGridMenuItem:self];
    }
}

@end
