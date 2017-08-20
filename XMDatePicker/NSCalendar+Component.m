//
//  NSCalendar+Component.m
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/20.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//

#import "NSCalendar+Component.h"

@implementation NSCalendar (Component)

+ (NSDateComponents *)componetsFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:date];
    return components;

}

@end
