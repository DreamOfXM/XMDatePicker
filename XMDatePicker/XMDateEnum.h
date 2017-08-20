//
//  XMDateEnum.h
//  XMDatePickerDemo
//
//  Created by hanna on 2017/8/20.
//  Copyright © 2017年 guo xiaoming. All rights reserved.
//

#ifndef XMDateEnum_h
#define XMDateEnum_h
typedef NS_ENUM(NSInteger,DateShowingType) {
    DateShowingTypeYMDHM = 1,//year、month、day、hour and minite
    DateShowingTypeYMDHMS,//year、month、day、hour and minite、second
    DateShowingTypeYMDH, //year、month、day and hour
    DateShowingTypeYMD,  //year、month、day
    DateShowingTypeMDHM, //month、day、hour and minite
    DateShowingTypeDHM   //day、hour and minite
};

#endif /* XMDateEnum_h */
