//
//  MPickerView.h
//  YLPickerView
//
//  Created by yiliu on 16/4/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol MPickerDelegate <NSObject>

//返回时间
- (void)mPickerTime:(NSString *)time;

@end


@interface MPickerView : UIView

@property (nonatomic, weak) id <MPickerDelegate> delegate;

/**
 *是否标记周末(默认不标记)
 */
@property (nonatomic,assign) BOOL isBJZM;

/**
 *每一列的文字颜色 UIColor类型
 */
@property (nonatomic,strong) NSArray *colorArry;

/**
 *每一列的背景颜色 UIColor类型
 */
@property (nonatomic,strong) NSArray *bkcolorArry;

/**
 *设置默认时间,注意格式YYYY-MM-dd HH:mm(不设置就默认当前时间)
 */
@property (nonatomic,strong) NSString *defaultDate;

@end
