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

@interface Bean : NSObject
@end

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

+ (BOOL)isReadonlyProperty:(NSString *)propertyName class:(Class)class
{
    objc_property_t property = class_getProperty(class, [propertyName cStringUsingEncoding:NSUTF8StringEncoding]);
    const char *attributes = property_getAttributes(property);
    NSArray *attrs = [[NSString stringWithUTF8String:attributes] componentsSeparatedByString:@","];
    for (NSString *attr in attrs) {
        
        //Attributes中包含R的表示ReadOnly，各个字符对应的意思可以搜"Property Type String"
        if ([attr isEqualToString:@"R"]) {
           
            return YES;
        }
    }
    return NO;
}

@end

@implementation JSONObject

- (instancetype)initWithJSONObject:(id)jsonObject
{
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
        
        NSArray *propertyNames = [Bean getPropertyNamesOfClass:[self class]];
        for (NSString *propertyName in propertyNames) {
            
            SEL selector = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [propertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[propertyName substringToIndex:1] uppercaseString]]]);
            
            if ([self respondsToSelector:selector]) {
                
                id value = jsonDictionary[propertyName];
                if ([value isKindOfClass:[NSNumber class]]) {
                    
                    NSMethodSignature* signature = [[self class] instanceMethodSignatureForSelector:selector];
                    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
                    [invocation setTarget:self];
                    [invocation setSelector:selector];
                    
                    double doubleValue = [value doubleValue];
                    NSInteger integerValue = [value integerValue];
                    if (doubleValue == integerValue) {
                        
                        [invocation setArgument:&integerValue atIndex:2];   //从2开始，0、1为target和selector
                    }
                    else
                    {
                        [invocation setArgument:&doubleValue atIndex:2];   //从2开始，0、1为target和selector
                    }
                    
                    [invocation invoke];
                }
                else if([value isKindOfClass:[NSArray class]]) {
                    
                    NSMutableArray *objects = [NSMutableArray array];
                    for (id obj in (NSArray *)value) {
                        
                        NSString *objectType = [self returnTypeOfArrayProperty:propertyName];
                        if ([objectType isEqualToString:@"NSString"]) {
                            
                            [objects addObject:obj];
                        }
                        else
                        {
                            JSONObject *objectValue = [[NSClassFromString(objectType) alloc] initWithJSONObject:obj];
                            [objects addObject:objectValue];
                        }
                    }
                    [self performSelector:selector withObject:objects];
                }
                else if([value isKindOfClass:[NSDictionary class]])
                {
                    NSString *propertyType = [Bean getPropertyTypeOfClass:[self class] propertyName:propertyName];
                    JSONObject *objectValue = [[NSClassFromString(propertyType) alloc] initWithJSONObject:value];
                    
                    [self performSelector:selector withObject:objectValue];
                }
                else
                {
                    [self performSelector:selector withObject:value];
                }
            }
        }
        return self;
    }
    else
    {
        return nil;
    }
}
- (NSData *)jsonData
{
    NSArray *propertyNames = [Bean getPropertyNamesOfClass:[self class]];
    NSMutableDictionary *propertiesDictionary = [NSMutableDictionary dictionary];
    for (NSString *propertyName in propertyNames) {
        
        if ([Bean isReadonlyProperty:propertyName class:[self class]]) {
            
            continue;
        }
        
        NSString *propertyNameUppercase = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[propertyName substringToIndex:1] uppercaseString]];
        SEL hasPropertySelector = NSSelectorFromString([NSString stringWithFormat:@"has%@", propertyNameUppercase]);
        BOOL hasValue = (BOOL)[self performSelector:hasPropertySelector];
        if (!hasValue) {
            
            continue;
        }
        
        SEL selector = NSSelectorFromString(propertyName);
        Method method = class_getInstanceMethod([self class], selector);
        
        if ([self respondsToSelector:selector]) {
            
            NSMethodSignature* signature = [[self class] instanceMethodSignatureForSelector:selector];
            NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:self];
            [invocation setSelector:selector];
            [invocation invoke];
            
            double doubleValue = 0;
            [invocation getReturnValue:&doubleValue];
            [propertiesDictionary setObject:[NSNumber numberWithDouble:doubleValue] forKey:propertyName];
            
            NSString *returnType = [[NSString alloc] initWithUTF8String:method_copyReturnType(method)];
            if ([returnType isEqualToString:@"B"] || [returnType isEqualToString:@"c"]) {
                
                BOOL boolValue;
                [invocation getReturnValue:&boolValue];
                [propertiesDictionary setObject:[NSNumber numberWithBool:boolValue] forKey:propertyName];
            }
            else if ([returnType isEqualToString:@"d"]) {
                
                double doubleValue;
                [invocation getReturnValue:&doubleValue];
                [propertiesDictionary setObject:[NSNumber numberWithDouble:doubleValue] forKey:propertyName];
            }
            else if ([returnType isEqualToString:@"q"] || [returnType isEqualToString:@"i"]) {
                
                NSInteger integerValue;
                [invocation getReturnValue:&integerValue];
                [propertiesDictionary setObject:[NSNumber numberWithInteger:integerValue] forKey:propertyName];
            }
            else if ([returnType isEqualToString:@"@"]) {
                
                id returnValue = [self performSelector:selector];
                
                if (returnValue) {
                    
                    if ([returnValue isKindOfClass:[NSArray class]]) {
                        
                        NSMutableArray *objects = [NSMutableArray array];
                        for (id obj in (NSArray *)returnValue) {
                            
                            if ([obj isKindOfClass:[NSString class]]) {
                                
                                [objects addObject:obj];
                            }
                            else
                            {
                                [objects addObject:[NSJSONSerialization JSONObjectWithData:[obj jsonData] options:NSJSONReadingMutableContainers error:nil]];
                            }
                        }
                        [propertiesDictionary setObject:objects forKey:propertyName];
                    }
                    else if ([returnValue isKindOfClass:[NSString class]]) {
                        
                        [propertiesDictionary setObject:returnValue forKey:propertyName];
                    }
                    else
                    {
                        [propertiesDictionary setObject:[NSJSONSerialization JSONObjectWithData:[returnValue jsonData] options:NSJSONReadingMutableContainers error:nil] forKey:propertyName];
                    }
                }
            }
            else
            {
                NSLog(@"propertyName:%@, type:%@", propertyName, returnType);
            }
        }
    }
    if ([NSJSONSerialization isValidJSONObject:propertiesDictionary]) {
        
        return [NSJSONSerialization dataWithJSONObject:propertiesDictionary options:NSJSONWritingPrettyPrinted error:nil];
    }
    NSLog(@"error-propertiesDictionary:%@", propertiesDictionary);
    return nil;
}

- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName
{
    return nil;
}

@end
