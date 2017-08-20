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
        [self updateDateAcordingToYearAtRow:row inComponent:component];
    }else if (component == 1) {//month
        //更新日期
//        self.currentMonth = [self.months[row] intValue];
//        [pickerView reloadComponent:component+1];
//        NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
//        self.currentDay = [self.days[selectedRow] intValue];
        [self updateMonthAtRow:row Component:component];
    }else if (component == 2) {//day
        self.currentDay = [self.days[row] intValue];
    }
    NSString *dateString = [NSString stringWithFormat:@"%.4d-%.2d-%.2d",
                            self.currentYear,
                            self.currentMonth,
                            self.currentDay];
    return dateString;
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
