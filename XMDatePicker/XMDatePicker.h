//
//  XMDatePicker.h
//  XMDatePicker
//
//  Created by guoran on 2017/3/6.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMDateEnum.h"
typedef enum{
    PickerViewTypeLongSperator = 1,//Default
    PickerViewTypeDynamicSperator,
    PickerViewTypeStaticSperator
} PickerViewType;



@class XMDatePicker;
@protocol XMDatePickerDelegate <NSObject>
@optional

//- (NSInteger)numberOfComponentsInPickerView:(XMDatePicker *)pickerView;
//- (NSString *)dateStringFromPickerView:(XMDatePicker *)pickerView;
- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString;
- (void)pickerView:(XMDatePicker *)pickerView didClickOkButtonWithDateString:(NSString *)dateString;
//- (void)picker:(XMDatePicker *)picker 

@end

@interface XMDatePicker : UIView

/***/
@property(nonatomic, strong)UILabel *dateLabel;

@property(nonatomic, assign)BOOL defaultType;

@property(nonatomic, assign)PickerViewType pickerViewType;

@property(nonatomic, assign)DateShowingType dateShowType;

/**hide the top static sperate line*/
@property(nonatomic, assign)BOOL hideTopStaticSperateLine;
/**hide the bottom static sperate line*/
@property(nonatomic, assign)BOOL hideBottomStaticSperateLine;

/** sperate line color 分割线颜色*/
@property(nonatomic, strong)UIColor *seperateLineColor;

@property(nonatomic, assign)CGFloat seperatorWidth;

/** start time.It is 1970 default if is not setted*/
@property(nonatomic, assign)int fromYear __attribute__((deprecated("请用maximumDate替换,否则程序可能会崩溃")));

/** end time*/
@property(nonatomic, assign)int toYear __attribute__((deprecated("请用minimumDate替换，否则程序可能会崩溃")));

@property(nonatomic, weak)id<XMDatePickerDelegate>delegate;
@property(nonatomic, assign)CGFloat componentWidth;
@property(nonatomic, assign)CGFloat rowHeight;

@property(nonatomic, strong)UIFont *selectedTextFont;
@property(nonatomic, strong)UIColor *selectedTextColor;
@property(nonatomic, strong)UIColor *selectedLabelColor;

@property(nonatomic, strong)UIFont *otherTextFont;
@property(nonatomic, strong)UIColor *otherTextColor;
@property(nonatomic, strong)UIColor *otherLabelColor;

/*** Time unit (单位)*/
@property(nonatomic, copy)NSString *yearUnit;
@property(nonatomic, copy)NSString *monthUnit;
@property(nonatomic, copy)NSString *dayUnit;
@property(nonatomic, copy)NSString *hourUnit;
@property(nonatomic, copy)NSString *miniteUnit;
@property(nonatomic, copy)NSString *secondUnit;

@property(nonatomic, assign)CGFloat topMargin;
@property(nonatomic, assign)CGFloat bottomMargin;

/** 最大时间*/
@property (nullable, nonatomic, strong) NSDate *maximumDate;

/** 最小时间*/
@property (nullable, nonatomic, strong) NSDate *minimumDate;

- (void)showPickerView;
@end
