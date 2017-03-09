//
//  ViewController.m
//  XMDatePicker
//
//  Created by guoran on 2017/3/6.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMViewController1.h"


@interface XMViewController1 ()

@property(nonatomic, copy)void(^block)();

@end

@implementation XMViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"click me!";
    
    //time formate
    self.datePicker.dateShowType = DateShowingTypeYMDHM;

    //seperate line type
    self.datePicker.pickerViewType = PickerViewTypeDynamicSperator;
    //seperate line color
    self.datePicker.seperateLineColor = [UIColor redColor];
    self.datePicker.selectedTextFont = [UIFont systemFontOfSize:17];
    self.datePicker.selectedTextColor = [UIColor blueColor];
    
    self.datePicker.otherTextFont = [UIFont systemFontOfSize:15];
    self.datePicker.otherTextColor = [UIColor grayColor];
    
    self.datePicker.selectedLabelColor = [UIColor yellowColor];
    
    self.datePicker.otherLabelColor = [UIColor blueColor];
    
}

//#pragma mark - Delegates
//- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString {
//    NSLog(@"dateString ======== %@",dateString);
//}
//
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.datePicker showPickerView];
//    
//}
//
//#pragma mark - Layzes
//- (XMDatePicker *)datePicker {
//    if (!_datePicker) {
//        _datePicker = [[XMDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.height)];
//        _datePicker.delegate = self;
//        _datePicker.selectedTextFont = [UIFont systemFontOfSize:15];
//        _datePicker.selectedTextColor = [UIColor blackColor];
////        _datePicker.sperateLineColor = [UIColor yellowColor];
////        _datePicker.selectedLabelColor = [UIColor grayColor];
//        _datePicker.componentWidth = 70;
//        _datePicker.rowHeight = 30;
//        _datePicker.yearUnit = @"年";
//        _datePicker.monthUnit = @"月";
//        _datePicker.dayUnit = @"日";
//        _datePicker.hourUnit = @"时";
//        _datePicker.miniteUnit = @"分";
//        _datePicker.dateLabel.hidden = YES;
//        _datePicker.pickerViewType = PickerViewTypeStaticSperator;
//        _datePicker.dateShowType = DateShowingTypeMDHM;
////        _datePicker.dateShowType = DateShowingTypeYMDHM;
//        _datePicker.defaultType = YES;
//    }
//    return _datePicker;
//}


@end
