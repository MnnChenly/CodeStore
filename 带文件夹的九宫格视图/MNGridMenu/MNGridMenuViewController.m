//
//  MNGridMenuViewController.m
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "MNGridMenuViewController.h"

@interface MNGridMenuViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, weak) MNGridMenuItem *currentFolderItem;

@end

@implementation MNGridMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        
        self.items = items;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect rect = self.view.frame;
    rect.origin = CGPointZero;
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    if (self.items.count == 0) {
        
        return;
    }
    
    NSInteger rowIndex = 0;
    NSInteger colIndex = 0;
    for (MNGridMenuItem *item in self.items) {
        
        CGFloat x = 8 + kMNGridMenuItemWidth * colIndex;
        CGFloat y = kMNGridMenuItemHeight * rowIndex;
        
        item.view.frame = CGRectMake(x, y, kMNGridMenuItemWidth, kMNGridMenuItemHeight);
        [_scrollView addSubview:item.view];
        
        colIndex ++;
        if (colIndex == 4) {
            
            rowIndex ++;
            colIndex = 0;
        }
    }
    if (colIndex == 0) {
        rowIndex --;
    }
    _scrollView.contentSize = CGSizeMake(320, kMNGridMenuItemHeight * (rowIndex + 1));
    [self.view addSubview:_scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
