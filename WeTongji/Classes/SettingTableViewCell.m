//
//  SettingTableViewCell.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-24.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell

@synthesize itemTitleLabel = _itemTitleLabel;
@synthesize itemSwitch = _itemSwitch;

- (void)awakeFromNib {
    self.itemTitleLabel.text = @"";
    
    UIView *tempView = [[UIView alloc] init];
    [self setBackgroundView:tempView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
