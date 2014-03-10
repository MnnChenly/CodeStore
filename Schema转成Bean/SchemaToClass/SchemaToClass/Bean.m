//
//  Bean.m
//  SchemaToClass
//
//  Created by Chenly on 14-1-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "Bean.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"  //忽略掉performSelector的警告

@implementation Bean

+ (NSArray *)getPropertyNamesOfClass:(Class)class
{
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList(class, &propertyCount);
    NSMutableArray * propertyNames = [NSMutableArray array];
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}

+ (NSString *)getPropertyTypeOfClass:(Class)class propertyName:(NSString *)propertyName
{
    unsigned int propertyCount = 0;
    objc_property_t * properties = class_copyPropertyList(class, &propertyCount);
    NSArray *propertyNames = [Bean getPropertyNamesOfClass:class];
    NSInteger index = [propertyNames indexOfObject:propertyName];
    assert(index >= 0 && index < propertyNames.count);
    objc_property_t property = properties[index];
    const char * propAttr = property_getAttributes(property);
    NSString *propString = [NSString stringWithUTF8String:propAttr];
    NSArray *attrArray = [propString componentsSeparatedByString:@","];
    free(properties);
    NSString *propertyType = attrArray[0];
    propertyType = [propertyType substringWithRange:NSMakeRange(3, propertyType.length - 4)];
    return propertyType;
}

@end