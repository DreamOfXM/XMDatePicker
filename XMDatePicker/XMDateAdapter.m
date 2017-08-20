//
//  XMDateAdapter.m
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/20.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//

#import "XMDateAdapter.h"
@implementation XMDateAdapter
- (XMDateShowingType *)dateShowFromDateShow:(DateShowingType)dateType {
    XMDateShowingType *dateShow = [[XMYMDHMShow alloc]init];
    if (dateType == DateShowingTypeYMDHM) {
        dateShow = [[XMYMDHMShow alloc]init];
    }else if (dateType == DateShowingTypeYMDHMS) {
        dateShow = [[XMYMDHMSShow alloc]init];
    }else if (dateType == DateShowingTypeYMDH) {
        dateShow = [[XMYMDHShow alloc]init];
    }else if (dateType == DateShowingTypeYMD) {
        dateShow = [[XMYMDShow alloc]init];
    }else if (dateType == DateShowingTypeMDHM) {
        dateShow = [[XMMDHMShow alloc]init];
    }else if (dateType == DateShowingTypeDHM) {
        dateShow = [[XMDHMShow alloc]init];
    }else {
        NSAssert(nil, @"没有这样的类型");
    }
    return dateShow;
}

@end
