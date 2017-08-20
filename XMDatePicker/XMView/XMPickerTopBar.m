//
//  XMPickerTopBar.m
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMPickerTopBar.h"
#import "UIView+XMFrame.h"
#import "UIButton+XMEvent.h"

@interface XMPickerTopBar ()
{
    UIButton *_cancelButton;
    UIButton *_okButton;
}

@end

@implementation XMPickerTopBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_commonInit];
        [self.layer addSublayer:[self lineOnePixel]];
    }
    return self;
}

- (void)p_commonInit {
    CGFloat margin = 15;
    CGFloat buttonWidth = 50;
    CGFloat buttonHeight = 40;
    _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(margin, (self.height - buttonHeight)/2, buttonWidth, buttonHeight)];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:_cancelButton];
    
    _okButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - _cancelButton.width - margin, _cancelButton.y, _cancelButton.width, _cancelButton.height)];
    [_okButton setTitle:@"确定" forState:UIControlStateNormal];
    [_okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:_okButton];
    
    [_cancelButton clickEvent:^(UIButton *sender) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(topBar:didClickedCancelButton:)]) {
            [self.delegate topBar:self didClickedCancelButton:sender];
        }
    }];
    
    [_okButton clickEvent:^(UIButton *sender) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(topBar:didClickedOkButton:)]) {
            [self.delegate topBar:self didClickedOkButton:sender];
        }
    }];

}

- (CAShapeLayer *)lineOnePixel {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.height - 0.5)];
    [path addLineToPoint:CGPointMake(self.width, self.height - 0.5)];
    lineLayer.lineWidth = 0.5f;
    lineLayer.lineCap = kCALineCapSquare;
    lineLayer.path = path.CGPath;
    //    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = [UIColor grayColor].CGColor;
    return lineLayer;
}

#pragma mark - Layzes
- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cancelButton.width + 15, 0, self.width - (_cancelButton.width + 15)*2, self.height)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.font = [UIFont systemFontOfSize:15];
    }
    return _dateLabel;
}




@end
