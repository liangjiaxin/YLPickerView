//
//  ViewController.m
//  YLPickerView
//
//  Created by yiliu on 16/4/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//


#define WIDE [[UIScreen mainScreen] bounds].size.width       //屏幕宽
#define HIGH [[UIScreen mainScreen] bounds].size.height      //屏幕高

#import "ViewController.h"
#import "MPickerView.h"

@interface ViewController ()<MPickerDelegate>

@property (nonatomic,strong) MPickerView *mpicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%f  %f",self.view.bounds.size.width,self.view.bounds.size.height);
    
    //开始生成 设备旋转 通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    //添加 设备旋转 通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewhandleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    
    UIColor *color = [UIColor whiteColor];
    UIColor *color1 = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1];
    
    
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
}

#pragma -mark MPickerDelegate
- (void)mPickerTime:(NSString *)time{
    NSLog(@"%@",time);
}

- (void)viewhandleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    NSInteger faceDirection = [UIApplication sharedApplication].statusBarOrientation;
    if (faceDirection == UIInterfaceOrientationPortraitUpsideDown || faceDirection==UIInterfaceOrientationPortrait) {
        
        _mpicker.frame = CGRectMake(0, 64, WIDE, 10);
        
    }else if (faceDirection==UIInterfaceOrientationLandscapeLeft || faceDirection ==UIInterfaceOrientationLandscapeRight){
        
        _mpicker.frame = CGRectMake(0, 24, WIDE, 10);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
