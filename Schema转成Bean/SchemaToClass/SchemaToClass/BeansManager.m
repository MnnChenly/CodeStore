//
//  BeansManager.m
//  SchemaToClass
//
//  Created by Chenly on 14-1-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import "BeansManager.h"
#import "Bean.h"

@implementation BeansManager

- (void)writeBeans:(NSArray *)beans importFiles:(NSArray *)importFiles toDirectory:(NSString *)directory fileName:(NSString *)fileName
{
    NSMutableString *stringBufferH = [NSMutableString stringWithString:@"#import <Foundation/Foundation.h>\n#import \"Bean.h\"\n"];
    NSMutableString *stringBufferM = [NSMutableString stringWithFormat:@"#import \"%@.h\"\n\n", fileName];
    
    for (NSString *importFile in importFiles) {
        
        [stringBufferH appendFormat:@"#import \"%@.h\"\n", importFile];
    }
    [stringBufferH appendString:@"\n"];
    
    for (Bean *bean in beans) {
        
        [stringBufferH appendFormat:@"@class %@;\n", [bean.name capitalizedString]];
    }
    [stringBufferH appendString:@"\n"];
    
    for (Bean *bean in beans) {
        
        NSMutableArray *propertyStrings = [[NSMutableArray alloc] init];      //所有属性声明
        NSMutableArray *hasPropertyStrings = [[NSMutableArray alloc] init];   //所有属性的has属性声明
        NSMutableArray *setMethodStrings = [[NSMutableArray alloc] init];     //所有.m中set方法的实现
        
        [stringBufferM appendFormat:@"@implementation %@\n", [bean.name capitalizedString]];

        [stringBufferH appendFormat:@"/*\n\t%@\n*/\n", bean.document];
        [stringBufferH appendFormat:@"@interface %@ : JSONObject\n", [bean.name capitalizedString]];
        
        NSEnumerator *keyEnumerator = bean.properties.keyEnumerator;
        NSString *key;
        while ((key = [keyEnumerator nextObject])) {
            
            NSInteger lowercaseToIndex = [key rangeOfString:@"_"].location;
            if (lowercaseToIndex == NSNotFound) {
                lowercaseToIndex = 0;
            }
            NSString *propertyName = [key stringByReplacingCharactersInRange:NSMakeRange(0, lowercaseToIndex) withString:[[key substringToIndex:lowercaseToIndex] lowercaseString]];
            NSString *propertyType = bean.properties[key];
            NSString *propertyNameUppercase = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[propertyName substringToIndex:1] uppercaseString]];
            
            NSString *propertyString = [NSString stringWithFormat:@"@property (nonatomic, readonly) BOOL has%@;\n", propertyNameUppercase];
            NSString *hasPropertyString = [NSString stringWithFormat:@"%@%@;\t//%@\n", [self parsePropertyType:propertyType hasHeader:YES], propertyName, bean.documentations[key]];
            

            NSMutableString *setMethodString = [NSMutableString stringWithFormat:@"- (void)set%@:(%@)%@\n{\n", propertyNameUppercase, [self parsePropertyType:propertyType hasHeader:NO], propertyName];
            if (!([propertyType isEqualToString:@"integer"] || [propertyType isEqualToString:@"decimal"] || [propertyType isEqualToString:@"boolean"])) {
                
                [setMethodString appendFormat:@"\tif (%@ == nil)\n\t\t_has%@ = NO;\n\telse\n\t", propertyName, propertyNameUppercase];
            }
            [setMethodString appendFormat:@"\t_has%@ = YES;\n\t_%@ = %@;\n}\n", propertyNameUppercase, propertyName, propertyName];
            
            [propertyStrings addObject:propertyString];
            [hasPropertyStrings addObject:hasPropertyString];
            [setMethodStrings addObject:setMethodString];
        }
        
        for (NSString *str in propertyStrings) {
            
            [stringBufferH appendString:str];
        }
        for (NSString *str in hasPropertyStrings) {
            
            [stringBufferH appendString:str];
        }
        for (NSString *str in setMethodStrings) {
            
            [stringBufferM appendString:str];
        }
        
        //数组Property的getterAtIndex方法
        NSMutableString *returnTypeMethod = [NSMutableString stringWithString:@"- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName\n{\n"];
        keyEnumerator = bean.arrayPropertyTypes.keyEnumerator;
        while ((key = [keyEnumerator nextObject])) {
            
            NSInteger lowercaseToIndex = [key rangeOfString:@"_"].location;
            if (lowercaseToIndex == NSNotFound) {
                lowercaseToIndex = 0;
            }
            NSString *propertyName = [key stringByReplacingCharactersInRange:NSMakeRange(0, lowercaseToIndex) withString:[[key substringToIndex:lowercaseToIndex] lowercaseString]];
            [stringBufferH appendFormat:@"- (%@ *)%@AtIndex:(NSInteger)index;\n", bean.arrayPropertyTypes[key], propertyName];
            [stringBufferM appendFormat:@"- (%@ *)%@AtIndex:(NSInteger)index\n{\n\treturn _%@[index];\n}\n", bean.arrayPropertyTypes[key], propertyName, propertyName];
            
            [returnTypeMethod appendFormat:@"\tif ([propertyName isEqualToString:@\"%@\"]) {\n\t\treturn @\"%@\";\n\t}\n", propertyName, bean.arrayPropertyTypes[key]];
        }
        [returnTypeMethod appendString:@"\treturn nil;\n}\n"];
        [stringBufferM appendString:returnTypeMethod];
        [stringBufferH appendString:@"@end\n\n"];
        [stringBufferM appendString:@"@end\n\n"];
    }
    
    NSString *filePath = [directory stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"h"]];
    [stringBufferH writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    filePath = [directory stringByAppendingPathComponent:[fileName stringByAppendingPathExtension:@"m"]];
    [stringBufferM writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (NSString *)parsePropertyType:(NSString *)propertyType hasHeader:(BOOL)hasHeader
{
    if (hasHeader) {
        
        if ([propertyType isEqualToString:@"string"]) {
            
            return @"@property (nonatomic, copy) NSString *";
        }
        if ([propertyType isEqualToString:@"decimal"]) {
            
            return @"@property (nonatomic, assign) double ";
        }
        if ([propertyType isEqualToString:@"integer"] || [propertyType isEqualToString:@"int"]) {
            
            return @"@property (nonatomic, assign) NSInteger ";
        }
        if ([propertyType isEqualToString:@"boolean"]) {
            
            return @"@property (nonatomic, assign) BOOL ";
        }
        if ([propertyType isEqualToString:@"array"]) {
            
            return @"@property (nonatomic, copy) NSArray *";
        }
        return [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *", [propertyType capitalizedString]];
    }
    else
    {
        if ([propertyType isEqualToString:@"string"]) {
            
            return @"NSString *";
        }
        if ([propertyType isEqualToString:@"decimal"]) {
            
            return @"double";
        }
        if ([propertyType isEqualToString:@"integer"] || [propertyType isEqualToString:@"int"]) {
            
            return @"NSInteger";
        }
        if ([propertyType isEqualToString:@"boolean"]) {
            
            return @"BOOL";
        }
        if ([propertyType isEqualToString:@"array"]) {
            
            return @"NSArray *";
        }
        return [NSString stringWithFormat:@"%@ *", [propertyType capitalizedString]];
    }
}

@end
