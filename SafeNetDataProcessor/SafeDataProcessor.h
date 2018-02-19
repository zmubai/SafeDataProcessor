//
//  SafeDataProcessor.h
//  SafeNetDataProcessor
//
//  Created by zengbailiang on 2018/2/1.
//  Copyright © 2018年 zengbailiang. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 记录目的字段在的层级结构字符串：
 形式如：
 keyName{dstKeyName
 keyName[
 
 限定dstKeyName为字典类型
 keyName0{KeyName1{dstKeyName{
 
 限定dstKeyName为数组类型
 keyName0{KeyName1{dstKeyName[
 
 不限定dstKeyName类型
 keyName0{KeyName1{dstKeyName
 ...
 返回结果为dstKeyName对应的值
 */
@interface SafeDataProcessor : NSObject

/**
 层级结构字符串获取相应值
 @param formateString 记录目的字段在的层级结构字符串
 @param dataDictionary 输入的字典数据
 @return 返回获取的的值或者错误对象
 */
+ (id)getObjectWithFormmateString:(NSString*)formateString data:(NSDictionary*)dataDictionary;
@end
