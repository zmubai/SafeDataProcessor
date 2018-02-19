

//
//  NSObject+SafeData.m
//  SafeNetDataProcessor
//
//  Created by zengbailiang on 2018/2/2.
//  Copyright © 2018年 zengbailiang. All rights reserved.
//

#import "NSObject+SafeData.h"

@implementation NSObject (SafeData)
- (BOOL)isDictionaryClass
{
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArrayClass
{
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)isStringClass
{
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)isNumberClass
{
    return [self isKindOfClass:[NSNumber class]];
}

@end
