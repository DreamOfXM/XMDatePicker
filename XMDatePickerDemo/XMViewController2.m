//
//  XMViewController2.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMViewController2.h"

@interface XMViewController2 ()

@end

@implementation XMViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"click me! static seperate line";
    //设置完日期类型后，要想显示日期单位，必须重新设置，否则不会显示
    self.datePicker.dateShowType = DateShowingTypeYMDH;
    self.datePicker.yearUnit = @"年";
    self.datePicker.dayUnit = @"日";
    
    self.datePicker.pickerViewType = PickerViewTypeStaticSperator;
    self.datePicker.seperateLineColor = [UIColor blueColor];
    
    self.datePicker.selectedTextFont = [UIFont systemFontOfSize:16];
    self.datePicker.selectedTextColor = [UIColor purpleColor];
    
    self.datePicker.otherTextFont = [UIFont systemFontOfSize:15];
    self.datePicker.otherTextColor = [UIColor blackColor];
    self.datePicker.componentWidth = 80;
    self.datePicker.rowHeight = 44;
    
//    UIPickerView

    
}

#pragma mark - Delegate
- (void)pickerView:(XMDatePicker *)pickerView didClickOkButtonWithDateString:(NSString *)dateString {
    self.dateLabel.text = dateString;
    NSLog(@"dateString == %@",dateString);
    
}
@end
