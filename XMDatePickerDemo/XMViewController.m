//
//  XMViewController.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMViewController.h"

#import "UIView+XMFrame.h"

@interface XMViewController ()<XMDatePickerDelegate>


@end

@implementation XMViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.dateLabel];
}

#pragma mark - Delegates
- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString {
    NSLog(@"dateString ======== %@",dateString);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.datePicker showPickerView];
    
}

#pragma mark - Layzes
- (XMDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[XMDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.height)];
        _datePicker.delegate = self;
        _datePicker.selectedTextFont = [UIFont systemFontOfSize:15];
        _datePicker.selectedTextColor = [UIColor blackColor];
        //        _datePicker.sperateLineColor = [UIColor yellowColor];
        //        _datePicker.selectedLabelColor = [UIColor grayColor];
        _datePicker.componentWidth = 70;
        _datePicker.rowHeight = 30;
//        _datePicker.yearUnit = @"年";
        _datePicker.monthUnit = @"月";
        _datePicker.dayUnit = @"日";
        _datePicker.hourUnit = @"时";
        _datePicker.miniteUnit = @"分";
//        _datePicker.dateLabel.hidden = YES;
//        _datePicker.pickerViewType = PickerViewTypeStaticSperator;
//        _datePicker.dateShowType = DateShowingTypeMDHM;
        //        _datePicker.dateShowType = DateShowingTypeYMDHM;
//        _datePicker.defaultType = YES;
    }
    return _datePicker;
}



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.height/2 - 40, self.view.width, 80)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:30];
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.height/2 - 100, self.view.width, 50)];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _dateLabel.numberOfLines = 0;
        _dateLabel.font = [UIFont systemFontOfSize:28];
    }
    return _dateLabel;
    
}




@end
