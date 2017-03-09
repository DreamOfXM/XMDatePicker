# XMDatePicker
This is a datePicker which you can custom set(这个时间选择器你可以自由定义).
## 1 For example

#### 1.1 You can set datepicker's label color 

`self.datePicker.selectedLabelColor = [UIColor yellowColor];`

`self.datePicker.otherLabelColor = [UIColor blueColor];`

#### 1.2 You can set datePicker's text
```
self.datePicker.selectedTextFont = [UIFont systemFontOfSize:17];
self.datePicker.selectedTextColor = [UIColor blueColor];

self.datePicker.otherTextFont = [UIFont systemFontOfSize:15];
self.datePicker.otherTextColor = [UIColor grayColor];
```
#### 1.3 You can set seperate line color
```
self.datePicker.seperateLineColor = [UIColor redColor];
```
#### 1.4 You can select datePicker seperate line type. There are three types by default.   

//Default
```
self.datePicker.pickerViewType = PickerViewTypeLongSperator;
```
//Dynamic seperate line
```
self.datePicker.pickerViewType = PickerViewTypeDynamicSperator;
```
//Static seperate line
```
self.datePicker.pickerViewType = PickerViewTypeStaticSperator;
```
#### 1.5 Date show type.There are five types by default. 

//yyyy-MM-dd HH:mm
```
 self.datePicker.dateShowType = DateShowingTypeYMDHM;
 ```
 //yyyy-MM-dd HH
 
 ```
 self.datePicker.dateShowType = DateShowingTypeYMDH;
 ```
 //yyyy-MM-dd
 
 ```
 self.datePicker.dateShowType = DateShowingTypeYMD;
 ```
 //MM-dd HH:mm
 
 ```
 self.datePicker.dateShowType = DateShowingTypeMDHM;
 ```
 
 //dd HH:mm
 
 ```
 self.datePicker.dateShowType = DateShowingTypeDHM;
 ```
 
#### 1.6 You are free to set row height and component width of the datePicker
```
 self.datePicker.componentWidth = 70;
 self.datePicker.rowHeight = 30;
```
#### 1.7 You can set date unit
```
 self.datePicker.yearUnit = @"年";
 self.datePicker.monthUnit = @"月";
 self.datePicker.dayUnit = @"日";
 self.datePicker.hourUnit = @"时";
 self.datePicker.miniteUnit = @"分";
```
#### picture 1
![image](https://github.com/DreamOfXM/XMDatePicker/blob/f03c779a3ef0ea15b8ca22abcddc3b329d45397d/gif/1.gif)
#### picture 2
![image](https://github.com/DreamOfXM/XMDatePicker/blob/97b6164c396f46d8541df2d612ef052984a275d5/gif/2.gif)
##2 usage 
###2.1 cocoaPods
`pod XMDatePicker`
###2.2 Manual import 
####1 Drag all files in the `XMDatePicker` folder to your progect 

####2 improt the main file  `#import "XMDatePicker.h"`
There are two protocol methods Which are `- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString` and `- (void)pickerView:(XMDatePicker *)pickerView didClickOkButtonWithDateString:(NSString *)dateString`.If you need not click the confirmation button transmit date strings, you can implement the first method, otherwise the second.
