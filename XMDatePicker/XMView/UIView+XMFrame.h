//
//  UIView+XMFrame.h
//  XMDatePicker
//
//  Created by guo ran on 17/3/8.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMFrame)
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)width;
- (CGFloat)height;
@end
