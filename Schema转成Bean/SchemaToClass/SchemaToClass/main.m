//
//  main.m
//  SchemaToClass
//
//  Created by Chenly on 14-1-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXMLElement.h"
#import "Bean.h"
#import "BeansManager.h"

void exitForWrongArgs(NSString *error)
{
    NSLog(@"Error: %@", error);
    exit(1);
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        if (argc < 2) {
            
            exitForWrongArgs(@"缺少参数！");
        }
        else if(argc > 3)
        {
            exitForWrongArgs(@"多余参数！");
        }
        
        NSString *rootPath = [NSString stringWithUTF8String:argv[0]];
        rootPath = [rootPath stringByDeletingLastPathComponent];
        NSString *filePath = nil;
        NSString *outputPath = nil;
        
        for (int i = 1; i < argc; i ++) {
            
            NSString *argStr = [NSString stringWithUTF8String:argv[i]];
            
            if ([argStr rangeOfString:@"-out="].location == NSNotFound) {
                
                if (filePath) {
                    
                    exitForWrongArgs(@"参数不正确, 检查参数格式");
                }
                else
                {
                    if ([argStr rangeOfString:@"/"].location == 0) {
                        
                        filePath = argStr;
                    }
                    else if ([argStr rangeOfString:@".."].location == 0) {
                        
                        filePath = [[rootPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[argStr substringFromIndex:3]];
                    }
                    else if ([argStr rangeOfString:@"."].location == 0) {
                        
                        filePath = [rootPath stringByAppendingPathComponent:[argStr substringFromIndex:2]];
                    }
                    else
                    {
                        filePath = [rootPath stringByAppendingPathComponent:argStr];
                    }
                }
            }
            else
            {
                if (outputPath) {
                    
                    exitForWrongArgs(@"参数不正确, 检查是否存在两个-out");
                }
                else
                {
                    argStr = [argStr substringFromIndex:5];
                    
                    if ([argStr rangeOfString:@"/"].location == 0) {
                        
                        outputPath = argStr;
                    }
                    else if ([argStr rangeOfString:@".."].location == 0) {
                        
                        outputPath = [[rootPath stringByDeletingLastPathComponent] stringByAppendingPathComponent:[argStr substringFromIndex:3]];
                    }
                    else if ([argStr rangeOfString:@"."].location == 0) {
                        
                        outputPath = [rootPath stringByAppendingPathComponent:[argStr substringFromIndex:2]];
                    }
                    else
                    {
                        outputPath = [rootPath stringByAppendingPathComponent:argStr];
                    }
                }
            }
        }
        
        if (!outputPath) {
            
            outputPath = rootPath;
        }
        BOOL filePathIsDirectory;
        BOOL outputPathIsDirectory;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&filePathIsDirectory] || filePathIsDirectory) {

            exitForWrongArgs(@"schema文件不存在");
        }

        if (![[NSFileManager defaultManager] fileExistsAtPath:outputPath isDirectory:&outputPathIsDirectory] || !outputPathIsDirectory) {
            
            exitForWrongArgs(@"文件输出目录错误");
        }

        NSMutableArray *beans = [NSMutableArray array];
        NSMutableArray *importFiles = [NSMutableArray array];
        
        RXMLElement *root = [RXMLElement elementFromXMLFilePath:filePath];
        
        [root iterateWithRootXPath:@"//*[local-name()='import']" usingBlock:^(RXMLElement *importElement) {
        
            NSString *fileName = [[[importElement attribute:@"schemaLocation"] lastPathComponent] stringByDeletingPathExtension];
            [importFiles addObject:fileName];
        }];
        
        
        [root iterateWithRootXPath:@"//*[local-name()='complexType']" usingBlock:^(RXMLElement *beanElement) {
            
            Bean *bean = [[Bean alloc] init];
            bean.name = [beanElement attribute:@"name"];
            
            RXMLElement *documentation = [beanElement child:@"annotation.documentation" inNamespace:@"http://www.w3.org/2001/XMLSchema"];
            bean.document = documentation.text;
            
            NSMutableDictionary *properties = [NSMutableDictionary dictionary];
            NSMutableDictionary *documentations = [NSMutableDictionary dictionary];
            NSMutableDictionary *arrayPropertyTypes = [NSMutableDictionary dictionary];

            NSMutableArray *elements = [[NSMutableArray alloc] init];
            [elements addObjectsFromArray:[[beanElement child:@"all" inNamespace:@"http://www.w3.org/2001/XMLSchema"] children:@"element" inNamespace:@"http://www.w3.org/2001/XMLSchema"]];
            [elements addObjectsFromArray:[[beanElement child:@"sequence" inNamespace:@"http://www.w3.org/2001/XMLSchema"] children:@"element" inNamespace:@"http://www.w3.org/2001/XMLSchema"]];
            [elements addObjectsFromArray:[[beanElement child:@"any" inNamespace:@"http://www.w3.org/2001/XMLSchema"] children:@"element" inNamespace:@"http://www.w3.org/2001/XMLSchema"]];
            [elements addObjectsFromArray:[[beanElement child:@"choice" inNamespace:@"http://www.w3.org/2001/XMLSchema"] children:@"element" inNamespace:@"http://www.w3.org/2001/XMLSchema"]];
            
            for (RXMLElement *property in elements) {
                
                NSString *propertyType = [property attribute:@"type"];
                NSInteger subIndex = [propertyType rangeOfString:@":"].location;
                if (subIndex != NSNotFound) {
                    
                    propertyType = [propertyType substringFromIndex:subIndex + 1];
                }
                
                NSString *additionDocumentation = @"";
                if ([property attribute:@"maxOccurs"]) {
                    
                    [properties setObject:@"array" forKey:[property attribute:@"name"]];
                    if ([propertyType isEqualToString:@"string"]) {
                        
                        propertyType = @"NSString";
                    }
                    else
                    {
                        propertyType = [propertyType capitalizedString];
                    }
                    [arrayPropertyTypes setObject:propertyType forKey:[property attribute:@"name"]];
                }
                else
                {
                    [properties setObject:propertyType forKey:[property attribute:@"name"]];
                }
                
                RXMLElement *documentation = [property child:@"annotation.documentation" inNamespace:@"http://www.w3.org/2001/XMLSchema"];
                [documentations setObject:[NSString stringWithFormat:@"%@  %@", documentation.text, additionDocumentation] forKey:[property attribute:@"name"]];
            }
            bean.properties = properties;
            bean.documentations = documentations;
            bean.arrayPropertyTypes = arrayPropertyTypes;
            [beans addObject:bean];
        }];
        
        BeansManager *manager = [[BeansManager alloc] init];
        NSString *fileName = [filePath lastPathComponent];
        [manager writeBeans:beans importFiles:importFiles toDirectory:outputPath fileName:[fileName stringByDeletingPathExtension]];
    }
    
    return 0;
}

