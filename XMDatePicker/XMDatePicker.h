//
//  XMDatePicker.h
//  XMDatePicker
//
//  Created by guoran on 2017/3/6.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    PickerViewTypeLongSperator = 1,//Default
    PickerViewTypeDynamicSperator,
    PickerViewTypeStaticSperator
} PickerViewType;

typedef NS_ENUM(NSInteger,DateShowingType) {
    DateShowingTypeYMDHM = 1,//year、month、day、hour and minite
    DateShowingTypeYMDHMS,//year、month、day、hour and minite、second
    DateShowingTypeYMDH, //year、month、day and hour
    DateShowingTypeYMD,  //year、month、day
    DateShowingTypeMDHM, //month、day、hour and minite
    DateShowingTypeDHM   //day、hour and minite
};

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
@property(nonatomic, assign)int fromYear;

/** end time*/
@property(nonatomic, assign)int toYear;

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

- (void)showPickerView;
@end
