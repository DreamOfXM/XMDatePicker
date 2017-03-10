//
//  XMDatePicker.m
//  XMDatePicker
//
//  Created by guoran on 2017/3/6.
//  Copyright © 2017年 hanna. All rights reserved.
//
/**
 * 每月的天数是最特殊的，俗话说 1 3 5 7 8 10 12(腊)， 31天总不差
 *  4 6 9 11，都是30天
 *  2月最特殊，分为闰年和平年，所谓闰年大家百度即可，闰年的2月份是29天，平年28天 相信只要有小学文凭的都知道，怎么算就不多说了
 */

#define MonthsOfEachYear 12 //每年12个月
#define HoursOfEachDay 24 //每天24小时
#define MinitesOfEachHour 60 //每小时60分

#define IsThirtyOneDays(month) \
(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)

#define IsThirtyDays(month) (month == 4 || month == 6 ||month == 9 || month == 11)

#import "XMDatePicker.h"
#import <objc/runtime.h>
#import "UIView+XMFrame.h"
#import "XMPickerTopBar.h"
@interface XMDatePicker()<UIPickerViewDelegate,UIPickerViewDataSource,XMPickerTopBarDelegate>
{
    NSInteger _yearIndex;
    NSInteger _monthIndex;
    NSInteger _dayIndex;
    NSInteger _hourIndex;
    NSInteger _minteIndex;
}
//@property(nonatomic, strong)UIViewController *controller;

@property(nonatomic, strong)UIPickerView *picker;

@property(nonatomic, strong)UIView *maskView;

@property(nonatomic, strong)UIView *pickerBackgroundView;
@property(nonatomic, strong)XMPickerTopBar *topBar;


@property(nonatomic, strong)NSMutableArray *years;
@property(nonatomic, strong)NSMutableArray *months;
@property(nonatomic, strong)NSMutableArray *days;
@property(nonatomic, strong)NSMutableArray *hours;
@property(nonatomic, strong)NSMutableArray *minites;

@property(nonatomic, assign)int currentYear;
@property(nonatomic, assign)int currentMonth;
@property(nonatomic, assign)int currentDay;
@property(nonatomic, assign)int currentHour;
@property(nonatomic, assign)int currentMinite;

@property(nonatomic, copy)NSString *dateString;

@end

@implementation XMDatePicker
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1 添加pikerView
        [self p_commonInit];
        [self addSubview:self.maskView];
        [self p_addPickerBackgroundView];

    }
    return self;
}

- (void)showPickerView {
    [self p_scrollToDefaultLocation];
    self.dateLabel.text =  [self p_setDefaultText];
    if (![self.pickerBackgroundView superview]) {
        [self addSubview:self.pickerBackgroundView];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.alpha = 0.5f;
        self.pickerBackgroundView.y = self.height - self.pickerBackgroundView.height;
    }];
}

- (void)dismissPickerView {
   
    if ([self.pickerBackgroundView superview]) {
        [UIView animateWithDuration:0.5 animations:^{
            self.pickerBackgroundView.y = self.height;
            self.maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.pickerBackgroundView removeFromSuperview];
            
            if ([self superview]) {
                [self removeFromSuperview];
            }
        }];
    }
  
}


#pragma mark - Delegates && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [self numberOfComponents];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    //1 show all colums(展示 年、月、日、时、分)
    if (self.dateShowType == DateShowingTypeYMDHM) {
        if (component == 0) {//year
            return self.years.count;
        }else if (component == 1) {//month
            return self.months.count;
        }else if (component == 2) {//day
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
        }else if (component == 3) {//hour
            return self.hours.count;
        }else if (component == 4) {//minite
            return self.minites.count;
        }
        
        //2 show year-month-day hour
    }else if (self.dateShowType == DateShowingTypeYMDH) {
        if (component == 0) {//year
            return self.years.count;
        }else if (component == 1) {//month
            return self.months.count;
        }else if (component == 2) {//day
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
        }else if (component == 3) {//hour
            return self.hours.count;
        }
        //3 show year-month-day
    }else if (self.dateShowType == DateShowingTypeYMD) {
        if (component == 0) {//year
            return self.years.count;
        }else if (component == 1) {//month
            return self.months.count;
        }else if (component == 2) {//day
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
        }
        
        //4 show month-day Hour:minite
    }else if (self.dateShowType == DateShowingTypeMDHM) {
        if (component == 0) {//months
            return self.months.count;
        }else if (component == 1) {//days
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
        }else if (component == 2) {
            return self.hours.count;
        }else if (component == 3) {
            return self.minites.count;
        }
        //5 show day Hour : minite
    }else if (self.dateShowType == DateShowingTypeDHM) {
        if (component == 0) {//days
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear].count;
        }else if (component == 1) {//hours
            return self.hours.count;
        }else if (component == 2) {//mintes
            return self.minites.count;
        }
    }
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

//    NSLog(@"%@",pickerView.subviews[0].subviews[0].subviews[2].subviews[0]);
//    NSLog(@"row ======= %ld component ======= %ld",row,component);
//    NSLog(@" pickerView.subviews ====== %@", pickerView.subviews);
    if (![pickerView.delegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
        [self p_setSelectedRowTitleLabelOfComponent:component];
    }
    
    //1 show all colums(展示 年、月、日、时、分)
    if (self.dateShowType == DateShowingTypeYMDHM) {
        if (component == 0) {//year
            return self.years[row];
        }else if (component == 1) {//month
            return self.months[row];
        }else if (component == 2) {//day
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
        }else if (component == 3) {//hour
            return self.hours[row];
        }else if (component == 4) {//minite
            return self.minites[row];
        }

    //2 show year-month-day hour
    }else if (self.dateShowType == DateShowingTypeYMDH) {
        if (component == 0) {//year
            return self.years[row];
        }else if (component == 1) {//month
            return self.months[row];
        }else if (component == 2) {//day
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
        }else if (component == 3) {//hour
            return self.hours[row];
        }
       //3 show year-month-day
    }else if (self.dateShowType == DateShowingTypeYMD) {
        if (component == 0) {//year
            return self.years[row];
        }else if (component == 1) {//month
            return self.months[row];
        }else if (component == 2) {//day
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
        }
    
        //4 show month-day Hour:minite
    }else if (self.dateShowType == DateShowingTypeMDHM) {
        if (component == 0) {//months
            return self.months[row];
        }else if (component == 1) {//days
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
        }else if (component == 2) {
            return self.hours[row];
        }else if (component == 3) {
            return self.minites[row];
        }
    //5 show day Hour : minite
    }else if (self.dateShowType == DateShowingTypeDHM) {
        if (component == 0) {//days
            return [self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear][row];
        }else if (component == 1) {//hours
            return self.hours[row];
        }else if (component == 2) {//mintes
            return self.minites[row];
        }
    }
    
    return @"123";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSLog(@"didSelectRow ======= %ld component ======= %ld",row,component);
    NSString *dateString = @"";
    //1 show all colums(展示 年、月、日、时、分)
    if (self.dateShowType == DateShowingTypeYMDHM) {
        if (component == 0) {//year
            [self p_updateDateAcordingToYearAtRow:row inComponent:component];
        }else if (component == 1) {//month
            //更新日期
            self.currentMonth = [self.months[row] intValue];
            [pickerView reloadComponent:component+1];
            NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
            self.currentDay = [self.days[selectedRow] intValue];
        }else if (component == 2) {//day
             self.currentDay = [self.days[row] intValue];
        }else if (component == 3) {//hour
             self.currentHour = [self.hours[row] intValue];
        }else if (component == 4) {//minite
             self.currentMinite = [self.minites[row] intValue];
        }
        dateString = [NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d:%.2d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour,self.currentMinite];
        //2 show year-month-day hour
    }else if (self.dateShowType == DateShowingTypeYMDH) {
        if (component == 0) {//year
            //更新日期
         [self p_updateDateAcordingToYearAtRow:row inComponent:component];
        }else if (component == 1) {//month
            //更新日期
            self.currentMonth = [self.months[row] intValue];
            [pickerView reloadComponent:component+1];
            NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
            self.currentDay = [self.days[selectedRow] intValue];
        }else if (component == 2) {//day
             self.currentDay = [self.days[row] intValue];
        }else if (component == 3) {//hour
            self.currentHour = [self.hours[row] intValue];
        }
        dateString = [NSString stringWithFormat:@"%.4d-%.2d-%.2d %.2d",self.currentYear,self.currentMonth,self.currentDay,self.currentHour];
        //3 show year-month-day
    }else if (self.dateShowType == DateShowingTypeYMD) {
        if (component == 0) {//year
         [self p_updateDateAcordingToYearAtRow:row inComponent:component];
        }else if (component == 1) {//month
            //更新日期
            self.currentMonth = [self.months[row] intValue];
            [pickerView reloadComponent:component+1];
            NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
            self.currentDay = [self.days[selectedRow] intValue];
        }else if (component == 2) {//day
            self.currentDay = [self.days[row] intValue];
        }
        dateString = [NSString stringWithFormat:@"%.4d-%.2d-%.2d",self.currentYear,self.currentMonth,self.currentDay];
        
    //4 show month-day Hour:minite
    }else if (self.dateShowType == DateShowingTypeMDHM) {
        if (component == 0) {//months
            //更新日期
            self.currentMonth = [self.months[row] intValue];
            [pickerView reloadComponent:component+1];
            NSInteger selectedRow = [pickerView selectedRowInComponent:component+1];
            self.currentDay = [self.days[selectedRow] intValue];

        }else if (component == 1) {//days
             self.currentDay = [self.days[row] intValue];
        }else if (component == 2) {
            self.currentHour = [self.hours[row] intValue];
        }else if (component == 3) {
            self.currentMinite = [self.minites[row] intValue];
        }
        dateString = [NSString stringWithFormat:@"%.2d-%.2d %.2d:%.2d",self.currentMonth,self.currentDay,self.currentHour,self.currentMinite];
        //5 show day Hour : minite
    }else if (self.dateShowType == DateShowingTypeDHM) {
        if (component == 0) {//days
            self.currentDay = [self.days[row] intValue];
        }else if (component == 1) {//hours
            self.currentHour = [self.hours[row] intValue];
        }else if (component == 2) {//mintes
             self.currentMinite = [self.minites[row] intValue];
        }
        dateString = [NSString stringWithFormat:@"%.2d %.2d:%.2d",self.currentDay,self.currentHour,self.currentMinite];
    }

    self.dateLabel.text = dateString;
    self.dateString = dateString;
    //return date string
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectedDateString:)]) {
        [self.delegate pickerView:self didSelectedDateString:dateString];
    }
}

//set component width
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = self.componentWidth?self.componentWidth:60;
    return width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.rowHeight?self.rowHeight:50;
}


//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    NSLog(@"view subviews ======== %@",view.subviews);
//    UILabel *rowLabel = (UILabel *)view;
//    if (!rowLabel) {
//        rowLabel = [[UILabel alloc]init];
//        rowLabel.adjustsFontSizeToFitWidth = YES;
//        rowLabel.textAlignment = NSTextAlignmentCenter;
//        rowLabel.backgroundColor = [UIColor clearColor];
//        rowLabel.font = [UIFont systemFontOfSize:16];
//    }
//    rowLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//    return rowLabel;
//}


#pragma mark -  XMPickerTopBarDelegate
- (void)topBar:(XMPickerTopBar *)topBar didClickedCancelButton:(UIButton *)sender {
    [self dismissPickerView];
}


- (void)topBar:(XMPickerTopBar *)topBar didClickedOkButton:(UIButton *)sender {
    if (![self.delegate respondsToSelector:@selector(pickerView:didClickOkButtonWithDateString:)]) {
        [self dismissPickerView];
    }else {
        [self.delegate pickerView:self didClickOkButtonWithDateString:self.dateString];
    }
}

#pragma mark - Views

- (void)p_addPickerBackgroundView {
    [self addSubview:self.pickerBackgroundView];
}

#pragma mark - HandleEvents
- (void)p_tapMask:(UITapGestureRecognizer *)tap {
    [self dismissPickerView];
}

#pragma mark - Events
- (void)p_commonInit {
    self.pickerViewType = PickerViewTypeStaticSperator;
    self.dateShowType = DateShowingTypeYMDHM;
    self.seperateLineColor = [UIColor redColor];
    //default 1970 to 2050
     _years = [[NSMutableArray alloc]init];
    for (int i = 1970; i<= 2050; i++) {
        [_years addObject:[NSString stringWithFormat:@"%.4d%@",i,self.yearUnit?self.yearUnit:@""]];
    }
    
        self.topMargin = 40;
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    self.currentYear = (int)components.year;
    self.currentMonth = (int)components.month;
    self.currentDay =  (int)components.day;
    self.currentHour = (int)components.hour;
    self.currentMinite = (int)components.minute;
//    self.bottomMargin = 20;
}


- (void)p_scrollToDefaultLocation {
    
    [self p_initDateData];
    
    
    //1 show all colums(展示 年、月、日、时、分)
    if (self.dateShowType == DateShowingTypeYMDHM) {
        [self.picker selectRow:_yearIndex inComponent:0 animated:NO];
        [self.picker selectRow:_monthIndex inComponent:1 animated:NO];
        [self.picker selectRow:_dayIndex inComponent:2 animated:NO];
        [self.picker selectRow:_hourIndex inComponent:3 animated:NO];
        [self.picker selectRow:_minteIndex inComponent:4 animated:NO];
        //2 show year-month-day hour
    }else if (self.dateShowType == DateShowingTypeYMDH) {
        [self.picker selectRow:_yearIndex inComponent:0 animated:NO];
        [self.picker selectRow:_monthIndex inComponent:1 animated:NO];
        [self.picker selectRow:_dayIndex inComponent:2 animated:NO];
        [self.picker selectRow:_hourIndex inComponent:3 animated:NO];
        //3 show year-month-day
    }else if (self.dateShowType == DateShowingTypeYMD) {
        [self.picker selectRow:_yearIndex inComponent:0 animated:NO];
        [self.picker selectRow:_monthIndex inComponent:1 animated:NO];
        [self.picker selectRow:_dayIndex inComponent:2 animated:NO];
        
        //4 show month-day Hour:minite
    }else if (self.dateShowType == DateShowingTypeMDHM) {
        //months
        [self.picker selectRow:_monthIndex inComponent:0 animated:NO];
        //days
        [self.picker selectRow:_dayIndex inComponent:1 animated:NO];
        //hour
        [self.picker selectRow:_hourIndex inComponent:2 animated:NO];
        //minite
        [self.picker selectRow:_minteIndex inComponent:3 animated:NO];
        //5 show day Hour : minite
    }else if (self.dateShowType == DateShowingTypeDHM) {
        [self.picker selectRow:_dayIndex inComponent:0 animated:NO];
        [self.picker selectRow:_hourIndex inComponent:1 animated:NO];
        [self.picker selectRow:_minteIndex inComponent:2 animated:NO];
    }
}

- (void)p_initDateData {
    _yearIndex = [self.years indexOfObject:[NSString stringWithFormat:@"%.4d%@",self.currentYear,self.yearUnit?self.yearUnit:@""]];
    _monthIndex = [self.months indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentMonth,self.monthUnit?self.monthUnit:@""]];
    _dayIndex = [[self p_caculateDaysFromMonth:self.currentMonth year:self.currentYear] indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentDay,self.dayUnit?self.dayUnit:@""]];
    _hourIndex = [self.hours indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentHour,self.hourUnit?self.hourUnit:@""]];
    _minteIndex = [self.minites indexOfObject:[NSString stringWithFormat:@"%.2d%@",self.currentMinite,self.miniteUnit?self.miniteUnit:@""]];
    
}


- (NSMutableArray *)p_getCommonArray:(NSMutableArray *)array elementCount:(int)count uint:(NSString *)unit{
    if (array.count) {
        [array removeAllObjects];
    }
    for (int i = 1; i<=count; i++) {
        [array addObject:[NSString stringWithFormat:@"%.2d%@",i,unit?unit:@""]];
    }
    return array;
}


- (NSMutableArray *)p_caculateDaysFromMonth:(int)month year:(int)year {
    _days = [[NSMutableArray alloc]init];
    if (_days && _days.count) {
        [_days removeAllObjects];
    }
    
    int days = 31;
//    NSLog(@"%d",DaysOfEveryMonth(month));
    if ([self daysOfEveryMonth:month]>=30) {
        days = [self daysOfEveryMonth:month];
    }else {
        days = [self p_caculateDaysOfFebaryFromYear:year];
    }
    
    for (int i = 1; i<= days; i++) {
        [_days addObject:[NSString stringWithFormat:@"%.2d%@",i,self.dayUnit?self.dayUnit:@""]];
    }
    
    return _days;
}


- (int)p_caculateDaysOfFebaryFromYear:(int)year {
    int temYear = year;
    if (self.dateShowType != DateShowingTypeMDHM && self.dateShowType != DateShowingTypeDHM) {
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *component = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
        temYear = (int)component.year;
    }
    if (temYear %4 == 0) {
        return 29;
    }
    return 28;
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

- (void)p_setSelectedRowTitleLabelOfComponent:(NSInteger)component {
    
    if (self.pickerViewType != PickerViewTypeLongSperator) {
        self.picker.subviews[1].hidden = YES;
        self.picker.subviews[2].hidden = YES;
    }
   

     CGFloat textWidth = 0;
    NSString *labelTex = @"xxxx";
    if (self.dateShowType !=DateShowingTypeDHM && self.dateShowType != DateShowingTypeMDHM) {
        if (self.yearUnit) {
            labelTex = @"xxxx年";
        }
    }else {
        if (self.monthUnit || self.dayUnit || self.hourUnit || self.miniteUnit) {
            labelTex = @"xx月";
        }else {
            labelTex = @"xx";
        }
    }
   
    UIFont *font = nil;
    font = self.otherTextFont? self.otherTextFont:[UIFont systemFontOfSize:16];
    textWidth = [self p_widthOfText:labelTex font:font];
    
    int pickerTableViewNum = (int)self.picker.subviews[0].subviews[component].subviews.count;
    
    for (int index = 0; index<pickerTableViewNum; index++) {
        UIView *tableView = self.picker.subviews[0].subviews[component].subviews[index].subviews[0];
//        NSLog(@"sub ========== %@",self.picker.subviews[0].subviews[component].subviews[1].subviews[0]);
        unsigned int count = 0;
        Ivar *array = class_copyIvarList([tableView class], &count);
        for (int i = 0; i<count; i++) {
            Ivar property = array[i];
            const char *string = ivar_getName(property);
            NSString *name = [[NSString alloc]initWithUTF8String:string];
            if (![name isEqualToString:@"_referencingCells"]) continue;
    
            NSMutableArray * cells = object_getIvar(tableView, property);
            int count = (int)cells.count;
            if(!count) continue;
            
            UIColor *textColor = nil;
            UIColor *labelBackgroundColor = nil;
            for (int i = 0; i< count; i++) {
                if (index !=pickerTableViewNum -1) {
                    font = self.otherTextFont? self.otherTextFont:[UIFont systemFontOfSize:16];
                    textColor = self.otherTextColor ? self.otherTextColor : [UIColor grayColor];
                    labelBackgroundColor = self.otherLabelColor ?self.otherLabelColor : [UIColor clearColor];
                }else{
                    font = self.selectedTextFont ? self.selectedTextFont : [UIFont systemFontOfSize:16];
                    textColor = self.selectedTextColor ? self.selectedTextColor : [UIColor blackColor];
                    labelBackgroundColor = self.selectedLabelColor ? self.selectedLabelColor : [UIColor clearColor];
                
                }
//                UIFont *font = self.showTextFont?self.showTextFont:[UIFont systemFontOfSize:20];
                UILabel *textLabel = [cells[i] subviews][1];
                textLabel.textColor = textColor;
                textLabel.font = font;
                textLabel.backgroundColor = labelBackgroundColor;
//                [cells[i] subviews][0].backgroundColor = [UIColor yellowColor];
//                NSLog(@"textLabelSubviews ======== %@",textLabel.subviews);
//                NSLog(@"textLabel frame ====== %@",NSStringFromCGRect([textLabel frame]));
                
                if (index != pickerTableViewNum - 1)
                    continue;
                
                if (textLabel.subviews.count>=1)
                    continue;
                
                //dynamic seperator
                if (self.pickerViewType == PickerViewTypeDynamicSperator) {
                    UIView *line = [[UIView alloc]initWithFrame:CGRectMake((textLabel.frame.size.width - textWidth)/2, textLabel.frame.size.height - 1, textWidth, 1)];
                    line.backgroundColor = self.seperateLineColor;
                    [textLabel addSubview:line];
                }
            }

        }
    }
    
    //static sperator
    if (self.pickerViewType != PickerViewTypeStaticSperator) return;
    CGFloat spacing = 4.75f;
    NSInteger numberOfComponent = [self numberOfComponents];
    CGFloat margin = (self.width - self.componentWidth * numberOfComponent - (numberOfComponent - 1)*spacing)/2;
    CGFloat textLabelOffSet = 9.0f;
    CGFloat textOffSet = (self.componentWidth - textLabelOffSet - textWidth)/2;
    UIView *view =  self.picker.subviews[0].subviews[component].subviews[2];
    
    if (view.subviews.count>=3) {
    }else{
        CGFloat x = (spacing+self.componentWidth)*component + margin + textLabelOffSet+textOffSet;
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(x, view.height - 1, textWidth, 1)];
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(x, 0, textWidth, 1)];
        lineView1.backgroundColor = [UIColor blueColor];
        lineView2.backgroundColor = [UIColor blueColor];
        [view addSubview:lineView1];
        [view addSubview:lineView2];
    }

   
}

- (NSInteger)numberOfComponents {
    if (self.dateShowType == DateShowingTypeYMDH || self.dateShowType == DateShowingTypeMDHM) {
        return 4;
    }else if (self.dateShowType == DateShowingTypeYMD || self.dateShowType == DateShowingTypeDHM) {
        return 3;
    }else if (self.dateShowType == DateShowingTypeYMDHM) {
        return 5;
    }
    return 5;
}

- (void)p_updateDateAcordingToYearAtRow:(NSInteger)row inComponent:(NSInteger)component {
    //更新日期
    self.currentYear = [self.years[row] intValue];
    [self.picker reloadComponent:component+2];
    NSInteger selectedRow = [self.picker selectedRowInComponent:component+2];
    self.currentDay = [self.days[selectedRow] intValue];
}


- (CGFloat)p_widthOfText:(NSString *)text font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    return width;
}

- (NSString *)p_setDefaultText {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
//    NSCalendarUnit unit
    if (self.dateShowType == DateShowingTypeYMDHM) {
        return [NSString stringWithFormat:@"%d-%.2d-%.2d %.2d:%.2d",(int)components.year,(int)components.month,(int)components.day,(int)(int)components.hour,(int)components.minute];
    }else if (self.dateShowType == DateShowingTypeYMDH) {
        return [NSString stringWithFormat:@"%d-%.2d-%.2d %.2d",(int)components.year,(int)components.month,(int)components.day,(int)components.hour];
    }else if(self.dateShowType == DateShowingTypeYMD) {
          return [NSString stringWithFormat:@"%d-%.2d-%.2d",(int)components.year,(int)components.month,(int)components.day];
    }else if (self.dateShowType == DateShowingTypeMDHM) {
        return [NSString stringWithFormat:@"%.2d-%.2d %.2d:%.2d",(int)components.month,(int)components.day,(int)components.hour,(int)components.minute];
    }else if (self.dateShowType == DateShowingTypeDHM) {
        return [NSString stringWithFormat:@"%.2d %.2d:%.2d",(int)components.day,(int)components.hour,(int)components.minute];
    }
    return @"";
}

#pragma mark - SetMethods
- (void)setFromYear:(int)fromYear {
    _fromYear = fromYear;
    [self.years removeAllObjects];

    if (self.toYear) {
        for (int i = fromYear; i<= self.toYear; i++) {
            [_years addObject:[NSString stringWithFormat:@"%.4d",i]];
        }
    }
}

- (void)setToYear:(int)toYear {
    _toYear = toYear;
    [self.years removeAllObjects];
    if (self.fromYear) {
        for (int i = self.fromYear; i<= toYear; i++) {
            [_years addObject:[NSString stringWithFormat:@"%.4d",i]];
        }
    }else {
        for (int i = 1970; i<= toYear; i++) {
            [_years addObject:[NSString stringWithFormat:@".4%d",i]];
        }
    }
}


- (void)setYearUnit:(NSString *)yearUnit {
    _yearUnit = yearUnit;
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
    [self months];
}

- (void)setHourUnit:(NSString *)hourUnit {
    _hourUnit = hourUnit;
    [self hours];
}

- (void)setMiniteUnit:(NSString *)miniteUnit {
    _miniteUnit = miniteUnit;
    [self minites];
}

- (void)setDateLabel:(UILabel *)dateLabel {
    self.topBar.dateLabel = dateLabel;
}

- (UILabel *)dateLabel {
    return self.topBar.dateLabel;
}


#pragma mark - Layzes
- (UIView *)pickerBackgroundView {
    if (!_pickerBackgroundView) {
        CGFloat viewH = 300;
        CGFloat viewW = self.width;
        CGFloat viewX = 0;
        CGFloat viewY = self.height;
        CGRect frame = CGRectMake(viewX, viewY, viewW, viewH);
        _pickerBackgroundView = [[UIView alloc]initWithFrame:frame];
        [_pickerBackgroundView addSubview:self.topBar];
        
        [_pickerBackgroundView addSubview:self.dateLabel];
        
        _pickerBackgroundView.backgroundColor = [UIColor whiteColor];
              
        [_pickerBackgroundView addSubview:self.picker];
    }
    return _pickerBackgroundView;
}

- (XMPickerTopBar *)topBar {
    if (!_topBar) {
        _topBar = [[XMPickerTopBar alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
        _topBar.delegate = self;
    }
    return _topBar;
}


- (UIPickerView *)picker {
    if (!_picker) {
        CGFloat pickerH = self.pickerBackgroundView.height - self.topBar.height;
        CGFloat pickerW = self.pickerBackgroundView.width;
        CGFloat pickerY = 30;
        CGFloat pickerX = 0;
        CGRect frame = CGRectMake(pickerX, pickerY, pickerW, pickerH);
        _picker = [[UIPickerView alloc]initWithFrame:frame];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}



- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_tapMask:)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (NSMutableArray *)months {
    if (!_months) {
        _months = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_months elementCount:MonthsOfEachYear uint:self.monthUnit];
}

- (NSMutableArray *)hours {
    if (!_hours) {
        _hours = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_hours elementCount:HoursOfEachDay uint:self.hourUnit];
}

- (NSMutableArray *)minites {
    if (!_minites) {
        _minites = [[NSMutableArray alloc]init];
    }
    return [self p_getCommonArray:_minites elementCount:MinitesOfEachHour uint:self.miniteUnit];
}



@end
