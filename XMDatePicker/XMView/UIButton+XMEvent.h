//
//  UIButton+XMEvent.h
//  XMDatePicker
//
//  Created by guo ran on 17/3/8.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(UIButton *sender);

@interface UIButton (XMEvent)

- (void)clickEvent:(ClickBlock)eventBlock;
@end
