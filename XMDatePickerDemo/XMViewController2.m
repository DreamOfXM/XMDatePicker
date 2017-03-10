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
    
    self.datePicker.dateShowType = DateShowingTypeYMDH;
    self.datePicker.pickerViewType = PickerViewTypeStaticSperator;
    self.datePicker.seperateLineColor = [UIColor blueColor];
    
    self.datePicker.selectedTextFont = [UIFont systemFontOfSize:16];
    self.datePicker.selectedTextColor = [UIColor purpleColor];
    
    self.datePicker.otherTextFont = [UIFont systemFontOfSize:15];
    self.datePicker.otherTextColor = [UIColor blackColor];
    self.datePicker.componentWidth = 80;
    self.datePicker.rowHeight = 44;
    
}

#pragma mark - Delegate
- (void)pickerView:(XMDatePicker *)pickerView didClickOkButtonWithDateString:(NSString *)dateString {
    self.dateLabel.text = dateString;
    
}
@end
