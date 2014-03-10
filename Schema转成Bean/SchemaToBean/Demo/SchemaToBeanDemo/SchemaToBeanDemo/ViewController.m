//
//  ViewController.m
//  SchemaToBeanDemo
//
//  Created by Chenly on 14-2-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "ViewController.h"
#import "BULLETIN_BO.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //读取BULLETIN_BO.txt文件内容（json字符串），然后转换成对象
    id jsonFromFile = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BULLETIN_BO" ofType:@"txt"]] options:NSJSONReadingMutableContainers error:nil];
    BULLETIN_READ_TYPE *a = [[BULLETIN_READ_TYPE alloc] initWithJSONObject:jsonFromFile];
    
    assert(a);
    
    a.bulletin_ID = NO;
    a.bulletin_READ_ID = @"哦啦啦啦啦啦拉拉啦拉拉";
    [a comm_OBJ_DOC_RELAtIndex:1].doc_NAME = @"哈哈";
    a.staff_NAME.product_NAME = @"new name";
    a.staff_NAME.product_DESC = @"XIN JIA DE";
    NSString *jsonString = [[NSString alloc] initWithData:a.jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"读取BULLETIN_BO.txt文件内容（json字符串），然后转换成对象：\n%@", jsonString);
    
    //通过代码新建对象，设置相关属性然后转换成json字符串打印输出
    a = [BULLETIN_READ_TYPE alloc];
    a.bulletin_ID = NO;
    a.bulletin_READ_ID = @"哦啦拉拉";
    [a comm_OBJ_DOC_RELAtIndex:1].doc_NAME = @"哈哈";
    a.staff_NAME.product_NAME = @"new name";
    a.staff_NAME.product_DESC = @"XIN JIA DE";
    a.status_CD = @[@"s1", @"s2", @"s3", @"s4"];
    
    NSMutableArray *bs = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        
        COMM_OBJ_DOC_REL_TYPE *b = [COMM_OBJ_DOC_REL_TYPE alloc];
        b.doc_ID = [NSString stringWithFormat:@"fu jian ming cheng:%d", i];
        [bs addObject:b];
    }
    
    PRODUCT_TYPE *c = [PRODUCT_TYPE alloc];
    c.product_NAME = @"产品名称";
    c.prod_FUNC_TYPE = @"类型";
    a.staff_NAME = c;
    a.bulletin_TITLE = 101;
    jsonString = [[NSString alloc] initWithData:a.jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"通过代码新建对象，设置相关属性然后转换成json字符串打印输出：\n%@", jsonString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
