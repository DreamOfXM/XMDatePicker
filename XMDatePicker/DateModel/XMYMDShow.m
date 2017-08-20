//
//  XMYMDShow.m
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/19.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//year、month、day

#import "XMYMDShow.h"

@implementation XMYMDShow

- (NSInteger)numberOfComponents {
    return 3;
}


- (NSInteger)numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//year
        return self.years.count;
    }else if (component == 1) {//month
        return self.months.count;
    }else if (component == 2) {//day
        return [self caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
    }
    return kDefaultComponentNum;
}

- (int)caculateDaysOfFebaryFromYear:(int)year {
    int temYear = year;
    if (temYear %4 == 0) {
        return 29;
    }
    return 28;
}

- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//year
        return self.years[row];
    }else if (component == 1) {//month
        return self.months[row];
    }else if (component == 2) {//day
        return [self caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
    }
    return kDefaultTitle;
}

- (NSString *)selectedTitleForRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {//year
        [self updateDateAcordingToYearAtRow:row inComponent:component+2];
    }else if (component == 1) {//month
        //更新日期
//        self.currentMonth = [self.months[row] intValue];
//        [pickerView reloadComponent:component+1];
//        NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
//        self.currentDay = [self.days[selectedRow] intValue];
        [self updateMonthAtRow:row Component:component+1];
    }else if (component == 2) {//day
        self.currentDay = [self.days[row] intValue];
    }
    NSString *dateString = [NSString stringWithFormat:@"%.4d-%.2d-%.2d",
                            self.currentYear,
                            self.currentMonth,
                            self.currentDay];
    
//    NSDate *date = [[NSDate alloc]init];
    NSString *tempStr = nil;
    BOOL isValid = [self p_isVaildOfSelectedTimeWithDateString:&tempStr];
    if (!isValid) {
        dateString = tempStr;
    }
    return dateString;
}

- (BOOL)p_isVaildOfSelectedTimeWithDateString:(NSString **)dateString {
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"yyyy:MM:dd";
    NSDate *date = [formate dateFromString:[NSString stringWithFormat:@"%.4d:%.2d:%.2d",
                                            self.currentYear,
                                            self.currentMonth,
                                            self.currentDay]];
    if ([date timeIntervalSinceDate:self.maximumDate]>0) {//大于最大时间
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
            
            NSDateComponents *components = [NSCalendar componetsFromDate:self.maximumDate];
            NSInteger yearIndex = [self yearIndexOfYear:(int)components.year];
            NSInteger monthIndex = [self monthIndxOfMonth:(int)components.month];
            NSInteger dayIndex = [self dayIndexOfDay:(int)components.day];
            [self.delegate selectedRow:yearIndex inComponent:0];
            [self.delegate selectedRow:monthIndex inComponent:1];
            [self.delegate selectedRow:dayIndex inComponent:2];
            *dateString = [NSString stringWithFormat:@"%.4d-%.2d-%.2d",
                           (int)components.year,
                           (int)components.month,
                           (int)components.day];
            return NO;
        }
    }else if ([date timeIntervalSinceDate:self.minimumDate]<0) {//小于最小时间
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
            NSDateComponents *components = [NSCalendar componetsFromDate:self.maximumDate];
            NSInteger yearIndex = [self yearIndexOfYear:(int)components.year];
            NSInteger monthIndex = [self monthIndxOfMonth:1];
            NSInteger dayIndex = [self dayIndexOfDay:1];
            
            [self.delegate selectedRow:yearIndex inComponent:0];
            [self.delegate selectedRow:monthIndex inComponent:1];
            [self.delegate selectedRow:dayIndex inComponent:2];
            return NO;
        }
    
    }
    return YES;
}

- (void)scrollToDefaultDate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
        [self.delegate selectedRow:self.yearIndex inComponent:0];
        [self.delegate selectedRow:self.monthIndex inComponent:1];
        [self.delegate selectedRow:self.dayIndex inComponent:2];
    }
}

- (NSString *)currentDateString {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%d-%.2d-%.2d",(int)components.year,(int)components.month,(int)components.day];
}

@end
