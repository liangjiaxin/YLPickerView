# YLPickerView
自定义的一个时间选择器,使用简单方便，支持xib，storyboard

//初始化＜/br＞
_mpicker = [[MPickerView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 10)];
_mpicker.delegate = self;
[self.view addSubview:_mpicker];

//每一列文字颜色＜/br＞
_mpicker.colorArry = @[color,color,color,color,color];

//每一列的背景颜色＜/br＞
_mpicker.bkcolorArry = @[color1,color1,color1,color2,color2];

//是否标记周末＜/br＞
_mpicker.isBJZM = YES;

//设置默认时间＜/br＞
_mpicker.defaultDate = @"2015-1-1 14:20";

![github](https://raw.github.com/liangjiaxin/YLPickerView/master/slimage/ww.png "github")

![github](https://raw.github.com/liangjiaxin/YLPickerView/master/slimage/qq.png "github")
