//
//  XMDHMShow.m
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/19.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//day、hour and minite

#import "XMDHMShow.h"

@implementation XMDHMShow
- (NSInteger)numberOfComponents {
    return 3;
}

- (NSInteger)numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//days
        return [self caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
    }else if (component == 1) {//hours
        return self.hours.count;
    }else if (component == 2) {//mintes
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
    if (component == 0) {//days
        return [self caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
    }else if (component == 1) {//hours
        return self.hours[row];
    }else if (component == 2) {//mintes
        return self.minites[row];
    }
    return kDefaultTitle;
}

- (NSString *)selectedTitleForRow:(NSInteger)row inComponent:(NSInteger)component {
    [super selectedTitleForRow:row inComponent:component];
    if (component == 0) {//days
        self.currentDay = [self.days[row] intValue];
    }else if (component == 1) {//hours
        self.currentHour = [self.hours[row] intValue];
    }else if (component == 2) {//mintes
        self.currentMinite = [self.minites[row] intValue];
    }
    NSString *dateString = [NSString stringWithFormat:@"%.2d %.2d:%.2d",
                            self.currentDay,
                            self.currentHour,
                            self.currentMinite];

    return dateString;
}

//[self.picker selectRow:_dayIndex inComponent:0 animated:NO];
//[self.picker selectRow:_hourIndex inComponent:1 animated:NO];
//[self.picker selectRow:_minteIndex inComponent:2 animated:NO];
- (void)scrollToDefaultDate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:inComponent:)]) {
        [self.delegate selectedRow:self.dayIndex inComponent:0];
        [self.delegate selectedRow:self.hourIndex inComponent:1];
        [self.delegate selectedRow:self.minteIndex inComponent:2];
    }
}

- (NSString *)currentDateString {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%.2d %.2d:%.2d",(int)components.day,(int)components.hour,(int)components.minute];
}

@end
