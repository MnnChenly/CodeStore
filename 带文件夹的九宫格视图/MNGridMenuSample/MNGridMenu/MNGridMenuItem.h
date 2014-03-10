//
//  MNGridMenuItem.h
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNGridMenuViewController;
@class MNGridMenuItem;

#define kMNGridMenuItemWidth 76
#define kMNGridMenuItemHeight 88

@protocol MNGridMenuItemDelegate <NSObject>

- (void)didClickMNGridMenuItem:(MNGridMenuItem *)item;

@end

@interface MNGridMenuItem : NSObject

@property (nonatomic, weak) id<MNGridMenuItemDelegate> delegate;

@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, strong) UIImage *image;   //图片
@property (nonatomic, readonly) UIView *view;   //整个菜单展示的视图(包含图片和标题)

@property (nonatomic, copy) NSArray *items;             //子菜单
@property (nonatomic, readonly) UIView *groupView;      //文件夹视图
@property (nonatomic, readonly) BOOL isGroupMenu;       //是否为文件夹菜单
@property (nonatomic, weak) MNGridMenuItem *superItem;  //父菜单

- (void)showGroupView;  //显示文件夹
- (void)hideGroupViewAnimated:(BOOL)animated completion:(void (^)(void))completion;  //隐藏文件夹

@end
