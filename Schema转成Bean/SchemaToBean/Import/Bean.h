//
//  Bean.h
//  SchemaToClass
//
//  Created by Chenly on 14-1-20.
//  Copyright (c) 2014年 Chenly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONObject : NSObject

- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName;
- (instancetype)initWithJSONObject:(id)jsonObject;
- (NSData *)jsonData;

@end
