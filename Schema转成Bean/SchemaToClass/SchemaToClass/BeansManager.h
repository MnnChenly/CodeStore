//
//  BeansManager.h
//  SchemaToClass
//
//  Created by Chenly on 14-1-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeansManager : NSObject

- (void)writeBeans:(NSArray *)beans importFiles:(NSArray *)importFiles toDirectory:(NSString *)directory fileName:(NSString *)fileName;

@end
