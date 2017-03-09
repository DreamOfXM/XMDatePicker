//
//  XMViewController3.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMViewController3.h"

@interface XMViewController3 ()

@end

@implementation XMViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
        self.titleLabel.text = @"click me! Default seperate line type";
    
    self.datePicker.dateShowType = DateShowingTypeYMD;
    self.datePicker.pickerViewType = PickerViewTypeLongSperator;
    self.datePicker.seperateLineColor = [UIColor blueColor];
    
    self.datePicker.selectedTextFont = [UIFont systemFontOfSize:16];
    self.datePicker.selectedTextColor = [UIColor purpleColor];
    
    self.datePicker.otherTextFont = [UIFont systemFontOfSize:15];
    self.datePicker.otherTextColor = [UIColor blackColor];
    self.datePicker.componentWidth = 80;
    self.datePicker.rowHeight = 44;

}

@end
