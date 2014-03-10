//
//  ViewController.m
//  MNGridMenuSample
//
//  Created by Chenly on 14-2-12.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "ViewController.h"
#import "MNGridMenuViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) MNGridMenuViewController *vc1;
@property (nonatomic, strong) MNGridMenuViewController *vc2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg.png"]];
    self.title = @"菜单界面";
    
    self.segment.selectedSegmentIndex = 0;
    [self.segment sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSArray *)getItems
{
    NSMutableArray *items = [NSMutableArray array];
    
    for (int i = 0; i < 14; i ++) {
        
        MNGridMenuItem *item = [[MNGridMenuItem alloc] init];
        item.title = [NSString stringWithFormat:@"标题：%d", i];
        item.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]];
        
        if (i == 7 || i == 8) {
            
            NSMutableArray *childItems = [NSMutableArray array];
            for (int j = 0; j < i * 2; j ++) {
                
                MNGridMenuItem *childItem = [[MNGridMenuItem alloc] init];
                childItem.title = [NSString stringWithFormat:@"标题：%d", j];
                childItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", j]];
                childItem.superItem = item;
                childItem.delegate = self;
                [childItems addObject:childItem];
            }
            item.items = childItems;
        }
        item.delegate = self;
        [items addObject:item];
    }
    
    return items;
}

- (NSArray *)getItem2
{
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 7; i ++) {
        
        MNGridMenuItem *item = [[MNGridMenuItem alloc] init];
        item.title = [NSString stringWithFormat:@"标题：%d", i];
        item.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]];
        
        if (i == 2 || i == 3 || i == 4) {
            
            NSMutableArray *childItems = [NSMutableArray array];
            for (int j = 0; j < i * 2; j ++) {
                
                MNGridMenuItem *childItem = [[MNGridMenuItem alloc] init];
                childItem.title = [NSString stringWithFormat:@"标题：%d", j];
                childItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", j]];
                childItem.superItem = item;
                childItem.delegate = self;
                [childItems addObject:childItem];
            }
            item.items = childItems;
        }
        item.delegate = self;
        [items addObject:item];
    }
    
    return items;
}

#pragma mark - MNGridMenuItemDelegate

- (void)didClickMNGridMenuItem:(MNGridMenuItem *)item
{
    if (item.isGroupMenu) {
        
        [item showGroupView];
    }
    else
    {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = item.title;
        vc.view = [[UIView alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
        
        [item.superItem hideGroupViewAnimated:NO completion:nil];
    }
}

#pragma mark - Segment Event

- (IBAction)segmentChange:(id)sender {
    
    MNGridMenuViewController *vc;
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            
            if (self.vc1 == nil) {
                
                self.vc1 = [[MNGridMenuViewController alloc] initWithItems:[self getItems]];
                self.vc1.items = [self getItems];
                self.vc1.view.frame = CGRectMake(0, 20 + 44, 320, CGRectGetHeight([UIScreen mainScreen].bounds) - 20 - 44 - 49);
                [self.view addSubview:self.vc1.view];
                [self addChildViewController:self.vc1];
            }
            else
            {
                [self transitionFromViewController:self.vc2 toViewController:self.vc1 duration:0.25 options:0 animations:nil completion:nil];
            }
            vc = self.vc1;
            break;
        case 1:
            
            if (self.vc2 == nil) {
                
                self.vc2 = [[MNGridMenuViewController alloc] initWithItems:[self getItem2]];
                self.vc2.view.frame = CGRectMake(0, 20 + 44, 320, CGRectGetHeight([UIScreen mainScreen].bounds) - 20 - 44 - 49);
                [self addChildViewController:self.vc2];
            }
            [self transitionFromViewController:self.vc1 toViewController:self.vc2 duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];
            vc = self.vc2;
            break;
            
        default:
            break;
    }
    [vc didMoveToParentViewController:self];
}

@end
