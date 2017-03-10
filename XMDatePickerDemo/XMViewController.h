//
//  XMViewController.h
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMDatePicker.h"
@interface XMViewController : UIViewController
@property(nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)XMDatePicker *datePicker;
@property(nonatomic, strong)UILabel *dateLabel;
@end
