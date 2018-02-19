//
//  NSObject+SafeData.h
//  SafeNetDataProcessor
//
//  Created by zengbailiang on 2018/2/2.
//  Copyright © 2018年 zengbailiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SafeData)
- (BOOL)isDictionaryClass;
- (BOOL)isArrayClass;
- (BOOL)isStringClass;
- (BOOL)isNumberClass;
@end
