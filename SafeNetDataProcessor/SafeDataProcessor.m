//
//  SafeDataProcessor.m
//  SafeNetDataProcessor
//
//  Created by zengbailiang on 2018/2/1.
//  Copyright © 2018年 zengbailiang. All rights reserved.
//

#import "SafeDataProcessor.h"
#import "NSObject+SafeData.h"

@implementation SafeDataProcessor

#pragma mark -
//获取特定结构的数据Example:a{ b[
//a{ b{ c{ d
+ (id)getObjectWithFormmateString:(NSString*)formateString data:(NSDictionary*)dataDictionary
{
    if ([self isDealOverWithFormattorString:formateString]) {
        return nil;
    }
    //边解析，边获取
    NSError *error;
    
    if (![dataDictionary isDictionaryClass]) {
        NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"解析失败formatString:%@,dataDictionary:%@",formateString,dataDictionary], NSLocalizedDescriptionKey, @"dataDictionary非字典无法进一步获取", NSLocalizedFailureReasonErrorKey, @"检查入参",NSLocalizedRecoverySuggestionErrorKey,nil];
        
        error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo1];
        return error;
    }
    
    NSString *keyName = [self keyNameWithFormattorString:&formateString];
    NSString *type = [self nearTypeWithFormattorString:&formateString];
    if ([type isEqualToString:@"dictionary"]) {
        
        NSDictionary *keyValue = [dataDictionary valueForKey:keyName];
        if (![keyValue isDictionaryClass]) {
            NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"类型不匹配formatString:%@,keName:%@,keyValue:%@",formateString,keyName,keyValue], NSLocalizedDescriptionKey, @"keyValue不是期待的字典类型", NSLocalizedFailureReasonErrorKey, @"检查入参",NSLocalizedRecoverySuggestionErrorKey,nil];
            error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo1];
            return error;
        }
        else
        {
            if (formateString.length == 0) {
                return keyValue;
            }
            else
            {
                return [self getObjectWithFormmateString:formateString data:keyValue];
            }
        }
    }
    else if([type isEqualToString:@"array"])
    {
        NSArray *keyValue = [dataDictionary valueForKey:keyName];
        if ([keyValue isArrayClass]) {
            return keyValue;
        }
        else
        {
            NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"类型不匹配formatString:%@,keName:%@,keyValue:%@",formateString,keyName,keyValue], NSLocalizedDescriptionKey, @"keyValue不是期待的数组类型", NSLocalizedFailureReasonErrorKey, @"检查入参",NSLocalizedRecoverySuggestionErrorKey,nil];
            error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo1];
            return error;
        }
    }
    else
    {
        id keVlaue = [dataDictionary valueForKey:keyName];
        if (keVlaue) {
            //非数组或字典类型直接获取返回。
            return keVlaue;
        }
        else
        {
            NSDictionary *userInfo1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"无法获取keyValue或者值为空formatString:%@,keyName:%@,dataDictionary%@",formateString,keyName,dataDictionary], NSLocalizedDescriptionKey, @"keyValue无法获取或为空", NSLocalizedFailureReasonErrorKey, @"检查入参",NSLocalizedRecoverySuggestionErrorKey,nil];
            
            error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:0 userInfo:userInfo1];
            return  error;
        }
    }
}

#pragma mark private
+ (BOOL)isDealOverWithFormattorString:(NSString*)formattorString
{
    if (formattorString.length == 0) {
        return YES;
    }
    return NO;
}

+ (NSString*)nearTypeWithFormattorString:(NSString**)formattorString
{
    if ([*formattorString length] == 0) {
        return nil;
    }
    
    NSString *symbol = [*formattorString substringToIndex:1];
    *formattorString = [*formattorString substringFromIndex:1];
    if ([symbol isEqualToString:@"{"]) {
        return @"dictionary";
    }
    else if([symbol isEqualToString:@"["])
    {
        return @"array";
    }
    else
    {
        return nil;
    }
}

+ (NSString*)keyNameWithFormattorString:(NSString**)formattorString
{
    if ([*formattorString length] == 0) {
        return nil;
    }
    NSRange keyRange;
    
    NSRange dictionarySymbolRange = [*formattorString rangeOfString:@"{"];
    NSRange arraySymbolRange = [*formattorString rangeOfString:@"["];
    
    if (dictionarySymbolRange.location != NSNotFound &&
        arraySymbolRange.location != NSNotFound) {
        if (dictionarySymbolRange.location < arraySymbolRange.location) {
            keyRange = NSMakeRange(0, dictionarySymbolRange.location);
        }
        else
        {
            keyRange = NSMakeRange(0, arraySymbolRange.location);
        }
    }
    else if (dictionarySymbolRange.location != NSNotFound)
    {
        keyRange = NSMakeRange(0, dictionarySymbolRange.location);
    }
    else if (arraySymbolRange.location != NSNotFound)
    {
        keyRange = NSMakeRange(0, arraySymbolRange.location);
    }
    else
    {
        //没有找到 直接获取
        keyRange = NSMakeRange(0, (*formattorString).length);
    }
    NSString *keyName = [*formattorString substringWithRange:keyRange];
    
    //更新formattorString
    if ([*formattorString length] >= keyRange.length + 1) {
        *formattorString = [*formattorString substringFromIndex:keyRange.length];
    }
    else
    {
        *formattorString = @"";
    }
    
    return keyName;
}
@end
