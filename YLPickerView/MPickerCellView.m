//
//  MPickerCellView.m
//  YLPickerView
//
//  Created by yiliu on 16/4/13.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MPickerCellView.h"
#import "MPickerCell.h"

@implementation MPickerCellView

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

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    _mTableView.frame = self.bounds;
    
}

//加载控件
- (void)viewDidLoad{
    
    _mTableView = [[UITableView alloc] initWithFrame:self.bounds];
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.showsHorizontalScrollIndicator = NO;
    _mTableView.showsVerticalScrollIndicator = NO;
    _mTableView.bounces = NO;
    [self addSubview:_mTableView];
    
    //设置tableview分割线长度(ios7/ios8)
    if ([_mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_mTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([_mTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_mTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}

//所有数据
- (void)setDataArry:(NSArray *)dataArry{
    _dataArry = dataArry;
    [_mTableView reloadData];
}

//设置默认选中
- (void)setDefaultSelect:(NSInteger)defaultSelect{
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:defaultSelect inSection:0];
    [_mTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//修改文字颜色
- (void)setTcolor:(UIColor *)tcolor{
    _tcolor = tcolor;
    [_mTableView reloadData];
}

#pragma -mark UITableViewDelegate
//设置分区的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

//设置每个分区的单元格数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArry.count+6;
}

//cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"MPickerCell";
    MPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:reuseIdetify owner:self options:nil] lastObject];
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    if(_tcolor){
        cell.contentLabel.textColor = _tcolor;
    }
    
    //如果是前三行或者最后3行则没有内容
    if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == _dataArry.count+3 || indexPath.row == _dataArry.count+4 || indexPath.row == _dataArry.count+5){
        cell.contentLabel.text = @"";
    }else{
        if(self.tag == 2 && [_dataArry[indexPath.row-3] isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = _dataArry[indexPath.row-3];
            cell.contentLabel.text = dict[@"day"];
            if([dict[@"isZM"] isEqual:@"1"]){
                cell.contentLabel.textColor = [UIColor redColor];
            }else{
                cell.contentLabel.textColor = _tcolor;
            }
        }else{
            cell.contentLabel.text = _dataArry[indexPath.row-3];
        }
    }
    
    return cell;
}

//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == _dataArry.count+3 || indexPath.row == _dataArry.count+4 || indexPath.row == _dataArry.count+5){
        return;
    }
    
    NSString *content;
    if(self.tag == 2 && [_dataArry[indexPath.row-3] isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = _dataArry[indexPath.row-3];
        content = dict[@"day"];
    }else{
        content = _dataArry[indexPath.row-3];
    }
    
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:indexPath.row-3 inSection:0];
    [_mTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.delegate choice:content viewTag:self.tag indexRow:indexPath.row-3];
}

//手指一直按着滑动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self updateScrollViewContentOffset:scrollView];
}

//手指松开滚动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateScrollViewContentOffset:scrollView];
}

//计算中间的cell，并返回值
- (void)updateScrollViewContentOffset:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    
    float m = (NSInteger)point.y % 30;
    
    if(m > 0 && m <= 15){
        
        scrollView.contentOffset = CGPointMake(point.x, point.y-m);
        
    }else if (m > 15 && m < 30){
        
        scrollView.contentOffset = CGPointMake(point.x, point.y+30-m);
        
    }
    
    CGPoint point1 = scrollView.contentOffset;
    NSInteger s = point1.y / 30;
    NSInteger f = s;
    
    NSString *content;
    if(self.tag == 2 && [_dataArry[f] isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = _dataArry[f];
        content = dict[@"day"];
    }else{
        content = _dataArry[f];
    }
    [self.delegate choice:content viewTag:self.tag indexRow:f];
}


@end
