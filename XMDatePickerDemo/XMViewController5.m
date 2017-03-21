//
//  XMViewController5.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMViewController5.h"

@interface XMViewController5 ()

@end

@implementation XMViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"click me!";
    //dd HH:mm:ss
//    self.datePicker.dateShowType = DateShowingTypeDHM;//DateShowingTypeYMDHMS
    
    //yyy-MM-dd HH:mm:ss
    self.datePicker.componentWidth = 50;
    self.datePicker.dateShowType = DateShowingTypeYMDHMS;
}

@end
