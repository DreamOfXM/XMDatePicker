//
//  XMDateShowingType.h
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/19.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSCalendar+Component.h"

#define kDefaultComponentNum 5
#define kDefaultTitle @"~……~"

@protocol XMDateShowingTypeDataSource <NSObject>
@required

- (NSInteger)selectedRowInComponent:(NSInteger)component;

@end


@protocol XMDateShowingTypeDelegate <NSObject>
@required
- (void)selectedRow:(NSInteger)row inComponent:(NSInteger)component;

- (void)scrollToMaxYear;
- (void)scrollToMinDay;

@end

@interface XMDateShowingType : NSObject

@property (nonatomic, assign)id<XMDateShowingTypeDataSource> dataSource;
@property (nonatomic, assign)id<XMDateShowingTypeDelegate> delegate;
//
@property (nonatomic, assign,readonly)NSInteger numberOfComponents;

@property(nonatomic, strong,readonly)NSMutableArray *years;
@property(nonatomic, strong,readonly)NSMutableArray *months;
@property(nonatomic, strong,readonly)NSMutableArray *days;
@property(nonatomic, strong,readonly)NSMutableArray *hours;
@property(nonatomic, strong,readonly)NSMutableArray *minites;
@property (nonatomic, strong,readonly)NSMutableArray *seconds;

@property(nonatomic, assign)int currentYear;
@property(nonatomic, assign)int currentMonth;
@property(nonatomic, assign)int currentDay;
@property(nonatomic, assign)int currentHour;
@property(nonatomic, assign)int currentMinite;
@property (nonatomic, assign)int currentSecond;

@property (nonatomic, assign,readonly)NSInteger yearIndex;
@property (nonatomic, assign,readonly)NSInteger monthIndex;
@property (nonatomic, assign,readonly)NSInteger dayIndex;
@property (nonatomic, assign,readonly)NSInteger hourIndex;
@property (nonatomic, assign,readonly)NSInteger minteIndex;
@property (nonatomic, assign,readonly)NSInteger secondIndex;

@property(nonatomic, copy,readonly)NSString *yearUnit;
@property(nonatomic, copy,readonly)NSString *monthUnit;
@property(nonatomic, copy,readonly)NSString *dayUnit;
@property(nonatomic, copy,readonly)NSString *hourUnit;
@property(nonatomic, copy,readonly)NSString *miniteUnit;
@property(nonatomic, copy,readonly)NSString *secondUnit;


/** start time.It is 1970 default if is not setted*/
@property(nonatomic, assign)int fromYear;

/** end time*/
@property(nonatomic, assign)int toYear;

//最大时间
@property (nullable, nonatomic, strong) NSDate *maximumDate;

//最小时间
@property (nullable, nonatomic, strong) NSDate *minimumDate;



- (void)setYearUnit:(NSString *)yearUnit;
- (void)setMonthUnit:(NSString *)monthUnit;
- (void)setDayUnit:(NSString *)dayUnit;
- (void)setHourUnit:(NSString *)hourUnit;
- (void)setMiniteUnit:(NSString *)miniteUnit;
- (void)setSecondUnit:(NSString *)secondUnit;

- (NSInteger)numberOfRowsInComponent:(NSInteger)component;
- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component;

- (NSString *)selectedTitleForRow:(NSInteger)row inComponent:(NSInteger)component;

- (NSMutableArray *)caculateDaysFromMonth:(int)month year:(int)year;
- (int)caculateDaysOfFebaryFromYear:(int)year;


- (void)updateDateAcordingToYearAtRow:(NSInteger)row inComponent:(NSInteger)component;

- (void)updateMonthAtRow:(NSInteger)row Component:(NSInteger)component;

//- (void)scrollToRow:(NSInteger)row inComponent:(NSInteger)component;
- (void)scrollToDefaultDate;

- (NSString *)currentDateString;


- (NSInteger)yearIndexOfYear:(int)year;
- (NSInteger)monthIndxOfMonth:(int)month;
- (NSInteger)dayIndexOfDay:(int)day;
- (NSInteger)hourIndexOfHour:(int)hour;
- (NSInteger)miniteIndexOfMinite:(int)minite;




@end
