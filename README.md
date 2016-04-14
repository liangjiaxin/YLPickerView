# YLPickerView
自定义的一个时间选择器,使用简单方便，支持xib，storyboard

//初始化

_mpicker = [[MPickerView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 10)];
_mpicker.delegate = self;
[self.view addSubview:_mpicker];

//每一列文字颜色

_mpicker.colorArry = @[color,color,color,color,color];

//每一列的背景颜色

_mpicker.bkcolorArry = @[color1,color1,color1,color2,color2];

//是否标记周末

_mpicker.isBJZM = YES;

![github](https://raw.github.com/liangjiaxin/YLPickerView/master/slimage/ee.png "github")

![github](https://raw.github.com/liangjiaxin/YLPickerView/master/slimage/oo.png "github")
