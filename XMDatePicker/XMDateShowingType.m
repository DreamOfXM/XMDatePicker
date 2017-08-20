//
//  XMDateShowingType.m
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/19.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//
/**
 * 每月的天数是最特殊的，俗话说 1 3 5 7 8 10 12(腊)， 31天总不差
 *  4 6 9 11，都是30天
 *  2月最特殊，分为闰年和平年，所谓闰年大家百度即可，闰年的2月份是29天，平年28天 相信只要有小学文凭的都知道，怎么算就不多说了
 */

#define MonthsOfEachYear 12 //每年12个月
#define HoursOfEachDay 24 //每天24小时
#define MinitesOfEachHour 60 //每小时60分
#define SecondsOfEachMinite 60//每小时60秒

#define IsThirtyOneDays(month) \
(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)

#define IsThirtyDays(month) (month == 4 || month == 6 ||month == 9 || month == 11)

#import "XMDateShowingType.h"
#import "XMDateEnum.h"

@interface XMDateShowingType()
@property(nonatomic, strong)NSMutableArray *years;
@property(nonatomic, strong)NSMutableArray *months;
@property(nonatomic, strong)NSMutableArray *days;
@property(nonatomic, strong)NSMutableArray *hours;
@property(nonatomic, strong)NSMutableArray *minites;
@property (nonatomic, strong)NSMutableArray *seconds;


@property(nonatomic, copy)NSString *yearUnit;
@property(nonatomic, copy)NSString *monthUnit;
@property(nonatomic, copy)NSString *dayUnit;
@property(nonatomic, copy)NSString *hourUnit;
@property(nonatomic, copy)NSString *miniteUnit;
@property(nonatomic, copy)NSString *secondUnit;

@property (nonatomic, assign)NSInteger yearIndex;
@property (nonatomic, assign)NSInteger monthIndex;
@property (nonatomic, assign)NSInteger dayIndex;
@property (nonatomic, assign)NSInteger hourIndex;
@property (nonatomic, assign)NSInteger minteIndex;
@property (nonatomic, assign)NSInteger secondIndex;


@end

@implementation XMDateShowingType

- (instancetype)init {
    if (self = [super init]) {
        _years = [[NSMutableArray alloc]init];
        for (int i = 1970; i<= 2050; i++) {
            [_years addObject:[NSString stringWithFormat:@"%.4d%@",i,self.yearUnit?self.yearUnit:@""]];
        }
        
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
        _currentYear = (int)components.year;
        _currentMonth = (int)components.month;
        _currentDay =  (int)components.day;
        _currentHour = (int)components.hour;
        _currentMinite = (int)components.minute;
        
        _yearIndex = [self.years indexOfObject:[NSString stringWithFormat:@"%.4d%@",self.currentYear,self.yearUnit?self.yearUnit:@""]];
        _monthIndex = [self.months indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentMonth,self.monthUnit?self.monthUnit:@""]];
        _dayIndex = [[self caculateDaysFromMonth:self.currentMonth year:self.currentYear] indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentDay,self.dayUnit?self.dayUnit:@""]];
        _hourIndex = [self.hours indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentHour,self.hourUnit?self.hourUnit:@""]];
        _minteIndex = [self.minites indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentMinite,self.miniteUnit?self.miniteUnit:@""]];
        _secondIndex = [self.seconds indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentSecond,self.secondUnit?self.secondUnit:@""]];
    }
    return self;
}


- (NSMutableArray *)p_getCommonArray:(NSMutableArray *)array elementCount:(int)count uint:(NSString *)unit{
    if (array.count) {
        [array removeAllObjects];
    }
    if (count == 12) {//月
        for (int i = 1; i<=count; i++) {
            [array addObject:[NSString stringWithFormat:@"%.2d%@",i,unit?unit:@""]];
        }
    }else {
        for (int i = 0; i<=count; i++) {
            [array addObject:[NSString stringWithFormat:@"%.2d%@",i,unit?unit:@""]];
        }
    }
    return array;
}


- (NSMutableArray *)caculateDaysFromMonth:(int)month year:(int)year {
    _days = [[NSMutableArray alloc]init];
    if (_days && _days.count) {
        [_days removeAllObjects];
    }
    
    int days = 31;
    //    NSLog(@"%d",DaysOfEveryMonth(month));
    if ([self daysOfEveryMonth:month]>=30) {
        days = [self daysOfEveryMonth:month];
    }else {
        days = [self caculateDaysOfFebaryFromYear:year];
    }
    
    for (int i = 1; i<= days; i++) {
        [_days addObject:[NSString stringWithFormat:@"%.2d%@",i,self.dayUnit?self.dayUnit:@""]];
    }
    
    return _days;
}

- (int)caculateDaysOfFebaryFromYear:(int)year {
    return 0;
}

- (int)daysOfEveryMonth:(int)month {
    int days = 0;
    if (IsThirtyOneDays(month)) {
        days = 31;
    }else if (IsThirtyDays(month)) {
        days = 30;
    }
    return days;
}

- (void)updateDateAcordingToYearAtRow:(NSInteger)row inComponent:(NSInteger)component {
    //更新日期
    self.currentYear = [self.years[row] intValue];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(selectedRowInComponent:)]) {
        NSInteger selectedRow = [self.dataSource selectedRowInComponent:component];
        self.currentDay = [self.days[selectedRow] intValue];
    }
}

- (void)updateMonthAtRow:(NSInteger)row Component:(NSInteger)component {
    self.currentMonth = [self.months[row] intValue];
//    [pickerView reloadComponent:component+1];
//    NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(selectedRowInComponent:)]) {
        NSInteger selectedRow = [self.dataSource selectedRowInComponent:component];
         self.currentDay = [self.days[selectedRow] intValue];
       }
}

#pragma mark - SetMethods
- (void)setYearUnit:(NSString *)yearUnit {
    NSInteger count = self.years.count;
    NSMutableArray *temArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<count; i++) {
        NSString *yearStr = self.years[i];
        NSString *appendStr = yearUnit?yearUnit:@"";
        yearStr = [yearStr stringByAppendingString:appendStr];
        [temArray addObject:yearStr];
    }
    
    self.years = temArray;
}

- (void)setMonthUnit:(NSString *)monthUnit {
    _monthUnit = monthUnit;
}

- (void)setDayUnit:(NSString *)dayUnit {
    _dayUnit = dayUnit;
}

- (void)setHourUnit:(NSString *)hourUnit {
    _hourUnit = hourUnit;
}

- (void)setMiniteUnit:(NSString *)miniteUnit {
    _miniteUnit = miniteUnit;
}

- (void)setSecondUnit:(NSString *)secondUnit {
    _secondUnit = secondUnit;
}

#pragma mark - Layzes
- (NSMutableArray *)months {
    if (!_months) {
        _months = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_months
                     elementCount:MonthsOfEachYear
                             uint:self.monthUnit];
}

- (NSMutableArray *)hours {
    if (!_hours) {
        _hours = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_hours
                     elementCount:HoursOfEachDay
                             uint:self.hourUnit];
}

- (NSMutableArray *)minites {
    if (!_minites) {
        _minites = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_minites
                     elementCount:MinitesOfEachHour
                             uint:self.miniteUnit];
}

- (NSMutableArray *)seconds {
    if (!_seconds) {
        _seconds = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_seconds
                     elementCount:SecondsOfEachMinite
                             uint:self.secondUnit];
}


@end
