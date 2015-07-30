//
//  MyTableViewCell.m
//  RACTest
//
//  Created by tangbo on 15/7/30.
//  Copyright (c) 2015年 tangbo. All rights reserved.
//

#import "MyTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _nameLabel = [UILabel new];
    _nameLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_nameLabel];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
