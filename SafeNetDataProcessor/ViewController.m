//
//  ViewController.m
//  SafeNetDataProcessor
//
//  Created by zengbailiang on 2018/2/1.
//  Copyright © 2018年 zengbailiang. All rights reserved.
//

#import "ViewController.h"
#import "SafeDataProcessor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"json" ofType:@"txt"];
    NSString *jsonString = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonError = nil;
    NSDictionary *testDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    if (jsonError) {
        NSLog(@"error0：%@ ",jsonError);
        return;
    }

    NSNumber *status = [SafeDataProcessor getObjectWithFormmateString:@"data{status" data:testDictionary];
    
    NSDictionary *result = [SafeDataProcessor getObjectWithFormmateString:@"data{result{" data:testDictionary];
    
    NSArray *list = [SafeDataProcessor getObjectWithFormmateString:@"data{result{list" data:testDictionary];
    
    NSNumber *page = [SafeDataProcessor getObjectWithFormmateString:@"data{result{all_page" data:testDictionary];
    
    NSLog(@"\n statu:%@,\n page:%@,\n list:%@,\n result:%@,\n ",status,page,list,result);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
