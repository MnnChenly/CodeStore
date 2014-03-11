//
//  MNGridMenuGroupView.m
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "MNGridMenuGroupView.h"
#import "MNGridMenuItem.h"
#import "UIView+ConvertToImage.h"

#import <QuartzCore/QuartzCore.h>

@interface MNGridMenuGroupView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

#define kSpaceValue 19
#define kBorderValue 8

@implementation MNGridMenuGroupView

- (id)initWithItems:(NSArray *)items
{
    CGFloat width = 320 - kBorderValue * 2;
    CGFloat height = kMNGridMenuItemHeight * 3 + 2 * kSpaceValue;
    CGRect frame = CGRectMake(0, 0, width, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor redColor];
        
        _items = items;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        NSInteger rowIndex = 0;
        NSInteger colIndex = 0;
        NSInteger pageIndex = 0;
        for (MNGridMenuItem *item in self.items) {
            
            CGFloat x = kSpaceValue + (kSpaceValue + kMNGridMenuItemWidth) * colIndex + width * pageIndex;
            CGFloat y = kSpaceValue + kMNGridMenuItemHeight * rowIndex;
            
            item.view.frame = CGRectMake(x, y, kMNGridMenuItemWidth, kMNGridMenuItemHeight);
            [_scrollView addSubview:item.view];
            
            colIndex ++;
            if (colIndex == 3) {
                
                rowIndex ++;
                if (rowIndex == 3) {
                    
                    rowIndex = 0;
                    pageIndex ++;
                }
                colIndex = 0;
            }
        }
        if (colIndex == 0) {
            rowIndex --;
            if (rowIndex < 0) {
                
                pageIndex --;
            }
        }
        _scrollView.contentSize = CGSizeMake((pageIndex + 1) * width, height);
        
        if (pageIndex > 0) {
            
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20)];
            _pageControl.enabled = NO;
            _pageControl.numberOfPages = pageIndex + 1;
            [self addSubview:_pageControl];
        }
        [self addSubview:_scrollView];
    }
    return self;
}

- (UIImage *)image
{
    if (!_image) {
        
        //获取作为菜单的图片前，隐藏里面item的title和pagecontroller
        self.pageControl.hidden = YES;
        for (MNGridMenuItem *item in self.items) {
            
            for (UIView *view in item.view.subviews) {
                
                if ([view isKindOfClass:[UILabel class]]) {
                    
                    view.hidden = YES;
                    break;
                }
            }
        }
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [[UIApplication sharedApplication].keyWindow sendSubviewToBack:self];
        [self setNeedsDisplay];
        
        [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate: [NSDate date]];
        
        _image = [self convertToImage];
        
        //获取作为菜单的图片后，还原里面item的title和pagecontroller
        self.pageControl.hidden = NO;
        for (MNGridMenuItem *item in self.items) {
            
            for (UIView *view in item.view.subviews) {
                
                if ([view isKindOfClass:[UILabel class]]) {
                    
                    view.hidden = NO;
                    break;
                }
            }
        }
        [self removeFromSuperview];
    }
    return _image;
}

- (void)willDismiss
{
    //文件夹中回到第一屏
    self.scrollView.contentOffset = CGPointZero;
    _pageControl.currentPage = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
