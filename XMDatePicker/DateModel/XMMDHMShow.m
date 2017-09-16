//
//  XMMDHMShow.m
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/19.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//month、day、hour and minite

#import "XMMDHMShow.h"

@implementation XMMDHMShow

- (NSInteger)numberOfComponents {
    return 4;
}


- (NSInteger)numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//months
        return self.months.count;
    }else if (component == 1) {//days
        return [self caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
    }else if (component == 2) {
        return self.hours.count;
    }else if (component == 3) {
        return self.minites.count;
    }
    return kDefaultComponentNum;
}

- (int)caculateDaysOfFebaryFromYear:(int)year {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    int temYear = (int)component.year;
    if (temYear %4 == 0) {
        return 29;
    }
    return 28;
}

- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//months
        return self.months[row];
    }else if (component == 1) {//days
        return [self caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
    }else if (component == 2) {
        return self.hours[row];
    }else if (component == 3) {
        return self.minites[row];
    }
    return kDefaultTitle;
}

- (NSString *)selectedTitleForRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {//months
        //更新日期
//        self.currentMonth = [self.months[row] intValue];
//        [pickerView reloadComponent:component+1];
//        NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
//        self.currentDay = [self.days[selectedRow] intValue];
        [self updateMonthAtRow:row Component:component+1];
        
    }else if (component == 1) {//days
        self.currentDay = [self.days[row] intValue];
    }else if (component == 2) {
        self.currentHour = [self.hours[row] intValue];
    }else if (component == 3) {
        self.currentMinite = [self.minites[row] intValue];
    }
    NSString *dateString = [NSString stringWithFormat:@"%.2d-%.2d %.2d:%.2d",
                            self.currentMonth,
                            self.currentDay,
                            self.currentHour,
                            self.currentMinite];
    NSString *tempStr = nil;
    BOOL isValid = [self p_isVaildOfSelectedTimeWithDateString:&tempStr];
    if (!isValid) {
        dateString = tempStr;
    }
    return dateString;
}

- (BOOL)p_isVaildOfSelectedTimeWithDateString:(NSString **)dateString {
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"YYYY-MM-dd HH:mm";
    NSDate *date = [formate dateFromString:[NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d:%.2d",
                                            self.currentYear,
                                            self.currentMonth,
                                            self.currentDay,
                                            self.currentHour,
                                            self.currentMinite]];
    if ([date timeIntervalSinceDate:self.maximumDate]>0) {//大于最大时间
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
            
            NSDateComponents *components = [NSCalendar componetsFromDate:self.maximumDate];
            NSInteger monthIndex = [self monthIndxOfMonth:(int)components.month];
            NSInteger dayIndex = [self dayIndexOfDay:(int)components.day];
            NSInteger hourIndex = [self hourIndexOfHour:(int)components.hour];
            NSInteger miniteIndex = [self miniteIndexOfMinite:(int)components.minute];
            [self.delegate selectedRow:monthIndex inComponent:0];
            [self.delegate selectedRow:dayIndex inComponent:1];
            [self.delegate selectedRow:hourIndex inComponent:2];
            [self.delegate selectedRow:miniteIndex inComponent:3];
            
            *dateString = [NSString stringWithFormat:@"%.2d-%.2d %.2d:%.2d",
                           (int)components.month,
                           (int)components.day,
                           (int)components.hour,
                           (int)components.minute];
            return NO;
        }
    }else if ([date timeIntervalSinceDate:self.minimumDate]<0) {//小于最小时间
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
            NSDateComponents *components = [NSCalendar componetsFromDate:self.minimumDate];
            NSInteger monthIndex = [self monthIndxOfMonth:1];
            NSInteger dayIndex = [self dayIndexOfDay:1];
            NSInteger hourIndex = [self hourIndexOfHour:1];
            NSInteger miniteIndex = [self miniteIndexOfMinite:1];

            [self.delegate selectedRow:monthIndex inComponent:0];
            [self.delegate selectedRow:dayIndex inComponent:1];
            [self.delegate selectedRow:hourIndex inComponent:2];
            [self.delegate selectedRow:miniteIndex inComponent:3];
            return NO;
        }
        
    }
    return YES;
}


////months
//[self.picker selectRow:_monthIndex inComponent:0 animated:NO];
////days
//[self.picker selectRow:_dayIndex inComponent:1 animated:NO];
////hour
//[self.picker selectRow:_hourIndex inComponent:2 animated:NO];
////minite
//[self.picker selectRow:_minteIndex inComponent:3 animated:NO];
- (void)scrollToDefaultDate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
        [self.delegate selectedRow:self.monthIndex inComponent:0];
        [self.delegate selectedRow:self.dayIndex inComponent:1];
        [self.delegate selectedRow:self.hourIndex inComponent:2];
        [self.delegate selectedRow:self.minteIndex inComponent:3];
    }
}

- (NSString *)currentDateString {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%.2d-%.2d %.2d:%.2d",(int)components.month,(int)components.day,(int)components.hour,(int)components.minute];
}

@end
