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
    
    //time formate 此时会重新创建一个新的日期模型，那么原来的日期模型的设置就需要重新设置，如时间单位“年”、@“月”、@“日”
    self.datePicker.dateShowType = DateShowingTypeYMDHM;
    self.datePicker.maximumDate = [NSDate date];
    NSString *time = @"2015-11-02";
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formate dateFromString:time];
    self.datePicker.minimumDate = date;

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
    
    self.datePicker.yearUnit = @"年";
    self.datePicker.monthUnit = @"月";
    
    //custom seperator width
    self.datePicker.seperatorWidth = 60;
    
}

#pragma mark
- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString {
    self.dateLabel.text = dateString;
    NSLog(@"dateString == %@",dateString);
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
