//
//  XMViewController4.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMViewController4.h"

@interface XMViewController4 ()

@end

@implementation XMViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"click me!";
    self.datePicker.dateShowType = DateShowingTypeMDHM;
    //如果传其他时间，年份必须是今年，必须带年份传入
    self.datePicker.maximumDate = [NSDate date];
    NSString *time = @"11-02 00:00 ";
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"MM-dd HH:mm";
    NSDate *date = [formate dateFromString:time];
//    self.datePicker.maximumDate = date;
}

@end
