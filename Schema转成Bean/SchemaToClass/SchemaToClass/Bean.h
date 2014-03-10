//
//  Bean.h
//  SchemaToClass
//
//  Created by Chenly on 14-1-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bean : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *document;                 //类的注释
@property (nonatomic, copy) NSDictionary *properties;       
@property (nonatomic, copy) NSDictionary *documentations;       //属性的注释
@property (nonatomic, copy) NSDictionary *arrayPropertyTypes;   //数组类型属性存放的元素类型

@end