//
//  MPickerCell.m
//  YLPickerView
//
//  Created by yiliu on 16/4/14.
//  Copyright © 2016年 mushoom. All rights reserved.
//

#import "MPickerCell.h"

@implementation MPickerCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:16];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
