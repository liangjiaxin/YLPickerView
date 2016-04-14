//
//  MPickerCellView.h
//  YLPickerView
//
//  Created by yiliu on 16/4/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPickerCellDelegate <NSObject>

- (void)choice:(NSString *)content viewTag:(NSInteger)tag indexRow:(NSInteger)row;

@end



@interface MPickerCellView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) id <MPickerCellDelegate> delegate;

@property (nonatomic,strong) UITableView *mTableView;

/**
 *所有数据
 */
@property (nonatomic,strong) NSArray *dataArry;

/**
 *默认选中
 */
@property (nonatomic,assign) NSInteger defaultSelect;

/**
 *文字颜色
 */
@property (nonatomic,assign) UIColor *tcolor;

@end
