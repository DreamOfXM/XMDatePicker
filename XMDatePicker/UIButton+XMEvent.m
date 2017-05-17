//
//  UIButton+XMEvent.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/8.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "UIButton+XMEvent.h"
#import <objc/runtime.h>

@implementation UIButton (XMEvent)

static char *key = "buttonKey";

- (void)clickEvent:(ClickBlock)eventBlock {
    objc_setAssociatedObject(self,key,eventBlock, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(p_clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)p_clickButton:(UIButton *)sender {
    ClickBlock eventBlock = objc_getAssociatedObject(self, key);
    NSLog(@"type ======== %@",objc_getAssociatedObject(self, key));
    eventBlock(self);
}

@end
