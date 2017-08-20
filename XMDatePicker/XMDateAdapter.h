//
//  XMDateAdapter.h
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/20.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMYMDHShow.h"//年、月、日、时
#import "XMYMDHMShow.h"//年、月、日、时、分
#import "XMYMDHMSShow.h"//年、月、日、时、分、秒
#import "XMYMDShow.h"//年、月、日
#import "XMMDHMShow.h"//月、日、时、分
#import "XMDHMShow.h"//日、时、分
#import "XMDateEnum.h"

@interface XMDateAdapter : NSObject

- (XMDateShowingType *)dateShowFromDateShow:(DateShowingType)dateShow;

@end
