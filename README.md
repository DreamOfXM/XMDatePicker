# XMDatePicker
This is a datePicker which you can set as what you want(这个时间选择器你可以自由定义).
## 1 How to use
#### 1.1 You can set datepicker's label color 

```objc
self.datePicker.selectedLabelColor = [UIColor yellowColor];

self.datePicker.otherLabelColor = [UIColor blueColor];
```
#### 1.2 You can set datePicker's text
```objc
self.datePicker.selectedTextFont = [UIFont systemFontOfSize:17];
self.datePicker.selectedTextColor = [UIColor blueColor];

self.datePicker.otherTextFont = [UIFont systemFontOfSize:15];
self.datePicker.otherTextColor = [UIColor grayColor];
```
#### 1.3 You can set separator's color and width 
```objc
// color
self.datePicker.seperateLineColor = [UIColor redColor];
//width
self.datePicker.seperatorWidth = 60;
```
#### 1.4 You can select datePicker separator's type. There are three types by default.   

//Default
```objc
self.datePicker.pickerViewType = PickerViewTypeLongSperator;
```
//Dynamic seperate line
```objc
self.datePicker.pickerViewType = PickerViewTypeDynamicSperator;
```
//Static seperate line
```objc
self.datePicker.pickerViewType = PickerViewTypeStaticSperator;
```
#### 1.5 Date show type.There are five types by default. 

//yyyy-MM-dd HH:mm
```objc
 self.datePicker.dateShowType = DateShowingTypeYMDHM;
 ```
 //yyyy-MM-dd HH:mm:ss
```objc
 self.datePicker.dateShowType = DateShowingTypeYMDHMS;
 ```
 //yyyy-MM-dd HH
 
 ```objc
 self.datePicker.dateShowType = DateShowingTypeYMDH;
 ```
 //yyyy-MM-dd
 
 ```objc
 self.datePicker.dateShowType = DateShowingTypeYMD;
 ```
 //MM-dd HH:mm
 
 ```objc
 self.datePicker.dateShowType = DateShowingTypeMDHM;
 ```
 
 //dd HH:mm
 
 ```objc
 self.datePicker.dateShowType = DateShowingTypeDHM;
 ```
 
#### 1.6 You are free to set row height and component width of the datePicker
```objc
 self.datePicker.componentWidth = 70;
 self.datePicker.rowHeight = 30;
```
#### 1.7 You can set date unit
```objc
 self.datePicker.yearUnit = @"年";
 self.datePicker.monthUnit = @"月";
 self.datePicker.dayUnit = @"日";
 self.datePicker.hourUnit = @"时";
 self.datePicker.miniteUnit = @"分";
 self.datePicker.secondUnit = @"秒"
```

#### picture 1
![image](https://github.com/DreamOfXM/XMDatePicker/blob/master/gif/1.gif)
#### picture 2
![image](https://github.com/DreamOfXM/XMDatePicker/blob/master/gif/2.gif)
#### picture 3
![image](https://github.com/DreamOfXM/XMDatePicker/blob/master/gif/3.gif)

#### usage 
### 2.1 cocoaPods
`pod XMDatePicker`
### 2.2 Manual import

#### 1 Drag all files in the `XMDatePicker` folder to your progect 

#### 2 improt the main file  `#import "XMDatePicker.h"`
#### 3 Method excute 
###### 3.1 Excute `- (void)showPickerView` 
(调用方法`- (void)showPickerView`展示pickerView) 

##### 3.2 Implement protocol method 
There are two protocol methods Which are `- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString` and `- (void)pickerView:(XMDatePicker *)pickerView didClickOkButtonWithDateString:(NSString *)dateString`.

If you need not click the confirmation button transmit date strings, you can implement the first method, otherwise the second.
***
有两个代理方法，分别是`- (void)pickerView:(XMDatePicker *)pickerView didSelectedDateString:(NSString *)dateString`和`- (void)pickerView:(XMDatePicker *)pickerView didClickOkButtonWithDateString:(NSString *)dateString`，如果你不需要点击“确认”按钮去最终确定所选择的日期，而是滑动转轮的同时更新日期，那么你可以实现第一个代理方法，否则就实现第二个代理方法

##  3 Issue
If you find a bug, please tell me.My E-mail address is 1179102890@qq.com. If you have a good idea ,you can discuss with me. 

最后，我在[《XMDatePicker的写作思路》](http://www.jianshu.com/p/58a902853479)中简要讲了一下处理分割线的问题，有什么问题希望大家批评指正！
***
