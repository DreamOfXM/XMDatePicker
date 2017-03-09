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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
