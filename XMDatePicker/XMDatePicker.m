//
//  XMDatePicker.m
//  XMDatePicker
//
//  Created by guoran on 2017/3/6.
//  Copyright © 2017年 hanna. All rights reserved.
//

#import "XMDatePicker.h"
#import <objc/runtime.h>
#import "UIView+XMFrame.h"
#import "XMPickerTopBar.h"
#import "XMDateAdapter.h"

@interface XMDatePicker()<UIPickerViewDelegate,UIPickerViewDataSource,XMPickerTopBarDelegate,XMDateShowingTypeDataSource,XMDateShowingTypeDelegate>

@property(nonatomic, strong)UIPickerView *picker;

@property(nonatomic, strong)UIView *maskView;

@property(nonatomic, strong)UIView *pickerBackgroundView;
@property(nonatomic, strong)XMPickerTopBar *topBar;

@property(nonatomic, copy)NSString *dateString;

@property (nonatomic, strong)XMDateShowingType *dateShow;
@property (nonatomic, strong)XMDateAdapter *dateAdapter;

@end

@implementation XMDatePicker
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1 添加pikerView
        [self p_commonInit];
        [self addSubview:self.maskView];
        [self p_addPickerBackgroundView];
    }
    return self;
}

- (void)showPickerView {
    [self p_scrollToDefaultLocation];
    self.dateLabel.text =  [self p_setDefaultText];
    if (![self.pickerBackgroundView superview]) {
        [self addSubview:self.pickerBackgroundView];
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.alpha = 0.5f;
        self.pickerBackgroundView.y = self.height - self.pickerBackgroundView.height;
    }];
}

- (void)dismissPickerView {
    if ([self.pickerBackgroundView superview]) {
        [UIView animateWithDuration:0.5 animations:^{
            self.pickerBackgroundView.y = self.height;
            self.maskView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.pickerBackgroundView removeFromSuperview];
            
            if ([self superview]) {
                [self removeFromSuperview];
            }
        }];
    }
}


#pragma mark - Delegates && DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return [self numberOfComponents];
    return self.dateShow.numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger number = [self.dateShow numberOfRowsInComponent:component];
    return number;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

//    NSLog(@"%@",pickerView.subviews[0].subviews[0].subviews[2].subviews[0]);
//    NSLog(@"row ======= %ld component ======= %ld",row,component);
//    NSLog(@" pickerView.subviews ====== %@", pickerView.subviews);
    if (![pickerView.delegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
        [self p_setSelectedRowTitleLabelOfComponent:component];
    }
    
    NSString *title = [self.dateShow titleForRow:row forComponent:component];
    return title;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *dateString = [self.dateShow selectedTitleForRow:row inComponent:component];
    self.dateLabel.text = dateString;
    self.dateString = dateString;
    //return date string
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectedDateString:)]) {
        [self.delegate pickerView:self didSelectedDateString:dateString];
    }
}

//set component width
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat width = self.componentWidth?self.componentWidth:60;
    return width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.rowHeight?self.rowHeight:50;
}


//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    NSLog(@"view subviews ======== %@",view.subviews);
//    UILabel *rowLabel = (UILabel *)view;
//    if (!rowLabel) {
//        rowLabel = [[UILabel alloc]init];
//        rowLabel.adjustsFontSizeToFitWidth = YES;
//        rowLabel.textAlignment = NSTextAlignmentCenter;
//        rowLabel.backgroundColor = [UIColor clearColor];
//        rowLabel.font = [UIFont systemFontOfSize:16];
//    }
//    rowLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//    return rowLabel;
//}


#pragma mark - XMDateShowingTypeDataSource
- (NSInteger)selectedRowInComponent:(NSInteger)component {
    [self.picker reloadComponent:component];
    NSInteger selectedRow = [self.picker selectedRowInComponent:component];
    return selectedRow;
}

#pragma mark -  XMDateShowingTypeDelegate
- (void)selectedRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.picker selectRow:row inComponent:component animated:YES];
}

#pragma mark -  XMPickerTopBarDelegate
- (void)topBar:(XMPickerTopBar *)topBar didClickedCancelButton:(UIButton *)sender {
    [self dismissPickerView];
}


- (void)topBar:(XMPickerTopBar *)topBar didClickedOkButton:(UIButton *)sender {
    if (![self.delegate respondsToSelector:@selector(pickerView:didClickOkButtonWithDateString:)]) {
        [self dismissPickerView];
    }else {
        [self.delegate pickerView:self didClickOkButtonWithDateString:self.dateString];
    }
}

#pragma mark - Views
- (void)p_addPickerBackgroundView {
    [self addSubview:self.pickerBackgroundView];
}

#pragma mark - HandleEvents
- (void)p_tapMask:(UITapGestureRecognizer *)tap {
    [self dismissPickerView];
}

#pragma mark - Events
- (void)p_commonInit {
    self.dateAdapter = [[XMDateAdapter alloc]init];
    self.pickerViewType = PickerViewTypeStaticSperator;
    self.dateShowType = DateShowingTypeYMDHM;
    self.seperateLineColor = [UIColor redColor];
    self.topMargin = 40;

//    self.bottomMargin = 20;
}


- (void)p_scrollToDefaultLocation {
    [self.dateShow scrollToDefaultDate];
}

- (void)p_setSelectedRowTitleLabelOfComponent:(NSInteger)component {
    if (self.pickerViewType != PickerViewTypeLongSperator) {
        self.picker.subviews[1].hidden = YES;
        self.picker.subviews[2].hidden = YES;
    }
   
     CGFloat textWidth = 0;
    NSString *labelTex = @"xxxx";
    if (self.dateShowType !=DateShowingTypeDHM && self.dateShowType != DateShowingTypeMDHM) {
        if (self.yearUnit) {
            labelTex = @"xxxx年";
        }
    }else {
        if (self.monthUnit || self.dayUnit || self.hourUnit || self.miniteUnit) {
            labelTex = @"xx月";
        }else {
            labelTex = @"xx";
        }
    }
   
    UIFont *font = nil;
    font = self.otherTextFont? self.otherTextFont:[UIFont systemFontOfSize:16];
    textWidth = [self p_widthOfText:labelTex font:font];
    CGFloat sepepatorWidth = (textWidth<self.seperatorWidth) ? self.seperatorWidth : textWidth;
    int pickerTableViewNum = (int)self.picker.subviews[0].subviews[component].subviews.count;

    for (int index = 0; index<pickerTableViewNum; index++) {
        UIView *tableView = self.picker.subviews[0].subviews[component].subviews[index].subviews[0];
//        NSLog(@"sub ========== %@",self.picker.subviews[0].subviews[component].subviews[1].subviews[0]);
        unsigned int count = 0;
        Ivar *array = class_copyIvarList([tableView class], &count);
        for (int i = 0; i<count; i++) {
            Ivar property = array[i];
            const char *string = ivar_getName(property);
            NSString *name = [[NSString alloc]initWithUTF8String:string];
            if (![name isEqualToString:@"_referencingCells"]) continue;
    
            NSMutableArray * cells = object_getIvar(tableView, property);
            int count = (int)cells.count;
            if(!count) continue;
            
            UIColor *textColor = nil;
            UIColor *labelBackgroundColor = nil;
            for (int i = 0; i< count; i++) {
                if (index !=pickerTableViewNum -1) {
                    font = self.otherTextFont? self.otherTextFont:[UIFont systemFontOfSize:16];
                    textColor = self.otherTextColor ? self.otherTextColor : [UIColor grayColor];
                    labelBackgroundColor = self.otherLabelColor ?self.otherLabelColor : [UIColor clearColor];
                }else{
                    font = self.selectedTextFont ? self.selectedTextFont : [UIFont systemFontOfSize:16];
                    textColor = self.selectedTextColor ? self.selectedTextColor : [UIColor blackColor];
                    labelBackgroundColor = self.selectedLabelColor ? self.selectedLabelColor : [UIColor clearColor];
                
                }
//                UIFont *font = self.showTextFont?self.showTextFont:[UIFont systemFontOfSize:20];
                UILabel *textLabel = [cells[i] subviews][1];
                textLabel.textColor = textColor;
                textLabel.font = font;
                textLabel.backgroundColor = labelBackgroundColor;
//                [cells[i] subviews][0].backgroundColor = [UIColor yellowColor];
//                NSLog(@"textLabelSubviews ======== %@",textLabel.subviews);
//                NSLog(@"textLabel frame ====== %@",NSStringFromCGRect([textLabel frame]));
                
                if (index != pickerTableViewNum - 1)
                    continue;
                
                if (textLabel.subviews.count>=1)
                    continue;
                
                //dynamic seperator
                if (self.pickerViewType == PickerViewTypeDynamicSperator) {
                    UIView *line = [[UIView alloc]initWithFrame:CGRectMake((textLabel.frame.size.width - sepepatorWidth)/2, textLabel.frame.size.height - 1, sepepatorWidth, 1)];
                    line.backgroundColor = self.seperateLineColor;
                    [textLabel addSubview:line];
                }
            }

        }
    }
    
    //static sperator
    if (self.pickerViewType != PickerViewTypeStaticSperator) return;
    CGFloat spacing = 4.75f;
//    NSInteger numberOfComponent = [self numberOfComponents];
    NSInteger numberOfComponent = self.dateShow.numberOfComponents;
    CGFloat margin = (self.width - self.componentWidth * numberOfComponent - (numberOfComponent - 1)*spacing)/2;
    CGFloat textLabelOffSet = 9.0f;
    CGFloat textOffSet = (self.componentWidth - textLabelOffSet - sepepatorWidth)/2;
    UIView *view =  self.picker.subviews[0].subviews[component].subviews[2];
    
    if (view.subviews.count>=3) {
    }else{
        CGFloat x = (spacing+self.componentWidth)*component + margin + textLabelOffSet+textOffSet;
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(x, view.height - 1, sepepatorWidth, 1)];
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(x, 0, sepepatorWidth, 1)];
        lineView1.backgroundColor = [UIColor blueColor];
        lineView2.backgroundColor = [UIColor blueColor];
        [view addSubview:lineView1];
        [view addSubview:lineView2];
    }

   
}


- (CGFloat)p_widthOfText:(NSString *)text font:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    return width;
}

- (NSString *)p_setDefaultText {
    return [self.dateShow currentDateString];
}

#pragma mark - SetMethods
- (void)setDateShowType:(DateShowingType)dateShowType {
    self.dateShow = [self.dateAdapter dateShowFromDateShow:dateShowType];
    self.dateShow.delegate = self;
    self.dateShow.dataSource = self;
}

- (void)setFromYear:(int)fromYear {
    [self.dateShow setFromYear:fromYear];
}

- (void)setToYear:(int)toYear {
    [self.dateShow setToYear:toYear];
}


- (void)setYearUnit:(NSString *)yearUnit {
    _yearUnit = yearUnit;
    [self.dateShow setYearUnit:yearUnit];
    
}

- (void)setMonthUnit:(NSString *)monthUnit {
    _monthUnit = monthUnit;
    [self.dateShow setMonthUnit:monthUnit];
}

- (void)setDayUnit:(NSString *)dayUnit {
    [self.dateShow setDayUnit:dayUnit];
}

- (void)setHourUnit:(NSString *)hourUnit {
    _hourUnit = hourUnit;
    [self.dateShow setHourUnit:hourUnit];
}

- (void)setMiniteUnit:(NSString *)miniteUnit {
    _miniteUnit = miniteUnit;
    [self.dateShow setMiniteUnit:miniteUnit];
}

- (void)setDateLabel:(UILabel *)dateLabel {
    self.topBar.dateLabel = dateLabel;
}


- (void)setMaximumDate:(NSDate *)maximumDate {
    [self.dateShow setMaximumDate:maximumDate];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    [self.dateShow setMinimumDate:minimumDate];
}



#pragma mark - Layzes

- (UILabel *)dateLabel {
    return self.topBar.dateLabel;
}
- (UIView *)pickerBackgroundView {
    if (!_pickerBackgroundView) {
        CGFloat viewH = 300;
        CGFloat viewW = self.width;
        CGFloat viewX = 0;
        CGFloat viewY = self.height;
        CGRect frame = CGRectMake(viewX, viewY, viewW, viewH);
        _pickerBackgroundView = [[UIView alloc]initWithFrame:frame];
        [_pickerBackgroundView addSubview:self.topBar];
        
        [_pickerBackgroundView addSubview:self.dateLabel];
        
        _pickerBackgroundView.backgroundColor = [UIColor whiteColor];
              
        [_pickerBackgroundView addSubview:self.picker];
    }
    return _pickerBackgroundView;
}

- (XMPickerTopBar *)topBar {
    if (!_topBar) {
        _topBar = [[XMPickerTopBar alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
        _topBar.delegate = self;
    }
    return _topBar;
}


- (UIPickerView *)picker {
    if (!_picker) {
        CGFloat pickerH = self.pickerBackgroundView.height - self.topBar.height;
        CGFloat pickerW = self.pickerBackgroundView.width;
        CGFloat pickerY = 30;
        CGFloat pickerX = 0;
        CGRect frame = CGRectMake(pickerX, pickerY, pickerW, pickerH);
        _picker = [[UIPickerView alloc]initWithFrame:frame];
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}



- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.5f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(p_tapMask:)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

@end
