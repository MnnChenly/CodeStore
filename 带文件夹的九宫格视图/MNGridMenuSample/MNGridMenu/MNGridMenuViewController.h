//
//  MNGridMenuViewController.h
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNGridMenuItem.h"

@interface MNGridMenuViewController : UIViewController

@property (nonatomic, copy) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items;

@end
