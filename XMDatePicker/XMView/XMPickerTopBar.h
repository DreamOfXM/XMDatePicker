//
//  XMPickerTopBar.h
//  XMDatePicker
//
//  Created by guo ran on 17/3/9.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMPickerTopBar;
@protocol XMPickerTopBarDelegate <NSObject>
@optional

- (void)topBar:(XMPickerTopBar *)topBar didClickedCancelButton:(UIButton *)sender;
- (void)topBar:(XMPickerTopBar *)topBar didClickedOkButton:(UIButton *)sender;

@end
@interface XMPickerTopBar : UIView

/***/
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, weak)id<XMPickerTopBarDelegate>delegate;

@end
