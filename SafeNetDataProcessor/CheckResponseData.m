//
//  CheckResponseData.m
//  SafeNetDataProcessor
//
//  Created by zengbailiang on 2018/2/12.
//  Copyright © 2018年 zengbailiang. All rights reserved.
//

#import "CheckResponseData.h"
/*

 {
     "data":{
         "status":200,
         "result":{
             "list":Array[20],
             "all_page":20
         }
     },
     "status":0
 }
 */
@implementation CheckResponseData
+ (NSDictionary *)resultWithResponseDictionary:(NSDictionary*)responseDictionary
{
    NSAssert([responseDictionary isKindOfClass:[NSDictionary class]], @"responseDictionary should be dictionary class");
    
    if (![responseDictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    NSDictionary *data = [responseDictionary valueForKey:@"data"];
    if (![data isKindOfClass:[NSDictionary class]])  return nil;
    
    NSDictionary *result = [data valueForKey:@"result"];
    if (![result isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    else
    {
        return result;
    }
}

+ (NSArray *)getListWithResponseDictionary:(NSDictionary*)responseDictionary
{
    NSDictionary *result = [self resultWithResponseDictionary:responseDictionary];
    
    NSArray *list  = [result valueForKey:@"list"];
    
    return [list isKindOfClass:[NSArray class]]?list:nil;
}

@end
