//
//  MPickerView.m
//  YLPickerView
//
//  Created by yiliu on 16/4/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MPickerView.h"
#import "MPickerCellView.h"
#import "CalculationTime.h"

typedef NS_ENUM(NSInteger, MTimeType) {
    MGregorianCalendar,
    MLunarCalendar
};

@interface MPickerView ()<MPickerCellDelegate>

@property (nonatomic,strong) UIButton *calendarTypeBtn;
@property (nonatomic,strong) UIButton *determineBtn;
@property (nonatomic,strong) UILabel  *timeLabel;

@property (nonatomic,strong) MPickerCellView *picker0;
@property (nonatomic,strong) MPickerCellView *picker1;
@property (nonatomic,strong) MPickerCellView *picker2;
@property (nonatomic,strong) MPickerCellView *picker3;
@property (nonatomic,strong) MPickerCellView *picker4;

@property (nonatomic,strong) UILabel  *mhLabel0;
@property (nonatomic,strong) UILabel  *mhLabel1;
@property (nonatomic,strong) UILabel  *mhLabel2;
@property (nonatomic,strong) UILabel  *mhLabel3;
@property (nonatomic,strong) UILabel  *mhLabel4;
@property (nonatomic,strong) UILabel  *mhLabel5;
@property (nonatomic,strong) UILabel  *mhLabel6;

@property (nonatomic,strong) UILabel *masklabel;

@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSString *month;
@property (nonatomic,strong) NSString *day;
@property (nonatomic,strong) NSString *hh;
@property (nonatomic,strong) NSString *mm;
@property (nonatomic,strong) NSString *week;

@property (nonatomic,assign) MTimeType timeType;

@end

@implementation MPickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewDidLoad];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self viewDidLoad];
    }
    return self;
}

//设置位置
- (void)setFrame:(CGRect)frame{
    
    [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 265)];
    
    float wid = (self.bounds.size.width - 60) / 5;
    
    _calendarTypeBtn.frame = CGRectMake(10, 10, wid, 35);
    _determineBtn.frame = CGRectMake(self.bounds.size.width-10-wid, 10, wid, 35);
    _timeLabel.frame = CGRectMake(20+wid, 10, self.bounds.size.width-40-2*wid, 35);
    
    _picker0.frame = CGRectMake(10, 55, wid, 210);
    _picker1.frame = CGRectMake(wid+20, 55, wid, 210);
    _picker2.frame = CGRectMake(2*(wid+10)+10, 55, wid, 210);
    _picker3.frame = CGRectMake(3*(wid+10)+10, 55, wid+5, 210);
    _picker4.frame = CGRectMake(4*(wid+10)+10-5, 55, wid+5, 210);
    
    _mhLabel0.frame = CGRectMake(4*(wid+10), 55, 10, 30);
    _mhLabel1.frame = CGRectMake(4*(wid+10), 55+30, 10, 30);
    _mhLabel2.frame = CGRectMake(4*(wid+10), 55+30*2, 10, 30);
    _mhLabel3.frame = CGRectMake(4*(wid+10), 55+30*3, 10, 30);
    _mhLabel4.frame = CGRectMake(4*(wid+10), 55+30*4, 10, 30);
    _mhLabel5.frame = CGRectMake(4*(wid+10), 55+30*5, 10, 30);
    _mhLabel6.frame = CGRectMake(4*(wid+10), 55+30*6, 10, 30);
    
    _masklabel.frame = CGRectMake(10, 145, self.bounds.size.width-20, 30);
    
}

//设置每一列的文字颜色
- (void)setColorArry:(NSArray *)colorArry{
    _colorArry = colorArry;
    _picker0.tcolor = colorArry[0];
    _picker1.tcolor = colorArry[1];
    _picker2.tcolor = colorArry[2];
    _picker3.tcolor = colorArry[3];
    _picker4.tcolor = colorArry[4];
}

//设置每一列的背景颜色
- (void)setBkcolorArry:(NSArray *)bkcolorArry{
    _bkcolorArry = bkcolorArry;
    _picker0.mTableView.backgroundColor = bkcolorArry[0];
    _picker1.mTableView.backgroundColor = bkcolorArry[1];
    _picker2.mTableView.backgroundColor = bkcolorArry[2];
    _picker3.mTableView.backgroundColor = bkcolorArry[3];
    _picker4.mTableView.backgroundColor = bkcolorArry[4];
}

//加载控件
- (void)viewDidLoad{
    
    float wid = (self.bounds.size.width - 60) / 5;
    
    //选择日历类型按钮
    _calendarTypeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, wid, 35)];
    [_calendarTypeBtn addTarget:self action:@selector(calendarType:) forControlEvents:UIControlEventTouchUpInside];
    _calendarTypeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_calendarTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_calendarTypeBtn setTitle:@"阳历" forState:UIControlStateNormal];
    [_calendarTypeBtn setBackgroundColor:[UIColor colorWithRed:90.0/255.0 green:186.0/255.0 blue:255.0/255.0 alpha:1]];
    [self addSubview:_calendarTypeBtn];
    
    //确定按钮
    _determineBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-10-wid, 10, wid, 35)];
    [_determineBtn addTarget:self action:@selector(determine:) forControlEvents:UIControlEventTouchUpInside];
    _determineBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_determineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_determineBtn setBackgroundColor:[UIColor colorWithRed:218.0/255.0 green:59.0/255.0 blue:62.0/255.0 alpha:1]];
    [self addSubview:_determineBtn];
    
    //中间显示时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20+wid, 10, self.bounds.size.width-40-2*wid, 35)];
    _timeLabel.font = [UIFont systemFontOfSize:16];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
    _timeLabel.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1];
    [self addSubview:_timeLabel];
    
    //日历
    _picker0 = [[MPickerCellView alloc] initWithFrame:CGRectMake(10, 55, wid, 210)];
    _picker1 = [[MPickerCellView alloc] initWithFrame:CGRectMake(wid+20, 55, wid, 210)];
    _picker2 = [[MPickerCellView alloc] initWithFrame:CGRectMake(2*(wid+10)+10, 55, wid, 210)];
    _picker3 = [[MPickerCellView alloc] initWithFrame:CGRectMake(3*(wid+10)+10, 55, wid+5, 210)];
    _picker4 = [[MPickerCellView alloc] initWithFrame:CGRectMake(4*(wid+10)+10-5, 55, wid+5, 210)];
    
    _picker0.mTableView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    _picker1.mTableView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    _picker2.mTableView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    _picker3.mTableView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    _picker4.mTableView.backgroundColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1];
    
    _picker0.delegate = self;
    _picker1.delegate = self;
    _picker2.delegate = self;
    _picker3.delegate = self;
    _picker4.delegate = self;
    
    _picker0.tag = 0;
    _picker1.tag = 1;
    _picker2.tag = 2;
    _picker3.tag = 3;
    _picker4.tag = 4;
    
    [self addSubview:_picker0];
    [self addSubview:_picker1];
    [self addSubview:_picker2];
    [self addSubview:_picker3];
    [self addSubview:_picker4];
    
    _mhLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55, 10, 30)];
    _mhLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55+30, 10, 30)];
    _mhLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55+30*2, 10, 30)];
    _mhLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55+30*3, 10, 30)];
    _mhLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55+30*4, 10, 30)];
    _mhLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55+30*5, 10, 30)];
    _mhLabel6 = [[UILabel alloc] initWithFrame:CGRectMake(4*(wid+10), 55+30*6, 10, 30)];
    
    _mhLabel0.textAlignment = NSTextAlignmentCenter;
    _mhLabel1.textAlignment = NSTextAlignmentCenter;
    _mhLabel2.textAlignment = NSTextAlignmentCenter;
    _mhLabel3.textAlignment = NSTextAlignmentCenter;
    _mhLabel4.textAlignment = NSTextAlignmentCenter;
    _mhLabel5.textAlignment = NSTextAlignmentCenter;
    _mhLabel6.textAlignment = NSTextAlignmentCenter;
    
    _mhLabel0.textColor = [UIColor whiteColor];
    _mhLabel1.textColor = [UIColor whiteColor];
    _mhLabel2.textColor = [UIColor whiteColor];
    _mhLabel3.textColor = [UIColor whiteColor];
    _mhLabel4.textColor = [UIColor whiteColor];
    _mhLabel5.textColor = [UIColor whiteColor];
    _mhLabel6.textColor = [UIColor whiteColor];
    
    _mhLabel0.text = @":";
    _mhLabel1.text = @":";
    _mhLabel2.text = @":";
    _mhLabel3.text = @":";
    _mhLabel4.text = @":";
    _mhLabel5.text = @":";
    _mhLabel6.text = @":";
    
    [self addSubview:_mhLabel0];
    [self addSubview:_mhLabel1];
    [self addSubview:_mhLabel2];
    [self addSubview:_mhLabel3];
    [self addSubview:_mhLabel4];
    [self addSubview:_mhLabel5];
    [self addSubview:_mhLabel6];
    
    //中间遮罩
    _masklabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 145, self.bounds.size.width-20, 30)];
    _masklabel.backgroundColor = [UIColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:0.7];
    [self addSubview:_masklabel];
    
    [self AddData];
}

//初始化数据
- (void)AddData{
    
    NSDictionary *dictTime = [CalculationTime calculationNowTime];
    _year = dictTime[@"year"];
    _month = dictTime[@"month"];
    _day = dictTime[@"day"];
    _hh = dictTime[@"hh"];
    _mm = dictTime[@"mm"];
    
    _week = [CalculationTime ObtainWeek:_day andMonth:_month andYear:_year];
    
    //设置年、月、日、时、分
    _picker0.dataArry = [CalculationTime calculationYear];
    _picker1.dataArry = [CalculationTime calculationMonth];
    _picker2.dataArry = [CalculationTime calculationDay:_year andMonth:_month];
    _picker3.dataArry = [CalculationTime calculationHH];
    _picker4.dataArry = [CalculationTime calculationMM];
    _timeLabel.text = [NSString stringWithFormat:@"%@-%@-%@ %@ %@:%@",_year,_month,_day,_week,_hh,_mm];
    
    //今年在数组里的下标
    NSInteger yearIndex = [_year integerValue] - 1900;
    //本月在数组里的下标
    NSInteger monthIndex = [_month integerValue] - 1;
    //今天在数组里的下标
    NSInteger dayIndex = [_day integerValue] - 1;
    //当时在数组里的下标
    NSInteger hhIndex = [_hh integerValue] - 1;
    //当分在数组里的下标
    NSInteger mmIndex = [_mm integerValue];
    
    _picker0.defaultSelect = yearIndex;
    _picker1.defaultSelect = monthIndex;
    _picker2.defaultSelect = dayIndex;
    _picker3.defaultSelect = hhIndex;
    _picker4.defaultSelect = mmIndex;
    
}

//是否标记周末
- (void)setIsBJZM:(BOOL)isBJZM{
    _isBJZM= isBJZM;
    if(_isBJZM){
        _picker2.dataArry = [CalculationTime calculationDay2:_year andMonth:_month];
    }else{
        _picker2.dataArry = [CalculationTime calculationDay:_year andMonth:_month];
    }
}

//选中的内容和列
- (void)choice:(NSString *)content viewTag:(NSInteger)tag indexRow:(NSInteger)row{
    
    if(tag == 0){
        
        _year = content;
        if([_month isEqual:@"2"]){
            if(_isBJZM){
                _picker2.dataArry = [CalculationTime calculationDay2:_year andMonth:_month];
            }else{
                _picker2.dataArry = [CalculationTime calculationDay:_year andMonth:_month];
            }
            if(_picker2.dataArry.count < [_day integerValue]){
                _day = [NSString stringWithFormat:@"%tu",_picker2.dataArry.count];
            }
        }
        
    }else if(tag == 1){
        
        _month = content;
        if(_isBJZM){
            _picker2.dataArry = [CalculationTime calculationDay2:_year andMonth:_month];
        }else{
            _picker2.dataArry = [CalculationTime calculationDay:_year andMonth:_month];
        }
        if(_picker2.dataArry.count < [_day integerValue]){
            _day = [NSString stringWithFormat:@"%tu",_picker2.dataArry.count];
        }
        
    }else if(tag == 2){
        
        _day = content;
        
    }else if(tag == 3){
        
        _hh = content;
        
    }else if(tag == 4){
        
        _mm = content;
        
    }
    
    [self getTime];
}

- (void)getTime{
    
    _week = [CalculationTime ObtainWeek:_day andMonth:_month andYear:_year];
    
    if(_timeType == MGregorianCalendar){
        _timeLabel.text = [NSString stringWithFormat:@"%@-%@-%@ %@ %@:%@",_year,_month,_day,_week,_hh,_mm];
    }else{
        NSString *time = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",_year,_month,_day,_hh,_mm];
        NSString *lunarTime = [CalculationTime getChineseCalendarWithDate:time];
        _timeLabel.text = [NSString stringWithFormat:@"%@ %@ %@:%@",lunarTime,_week,_hh,_mm];
    }
    
}

//选择日历类型
- (void)calendarType:(UIButton *)btn{
    if(_timeType == MGregorianCalendar){
        _timeType = MLunarCalendar;
        [btn setTitle:@"农历" forState:UIControlStateNormal];
    }else{
        _timeType = MGregorianCalendar;
        [btn setTitle:@"阳历" forState:UIControlStateNormal];
    }
    [self getTime];
}

//确定
- (void)determine:(UIButton *)btn{
    [self.delegate mPickerTime:_timeLabel.text];
}

@end
