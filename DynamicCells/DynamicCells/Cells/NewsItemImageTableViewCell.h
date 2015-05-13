//
//  NewsItemImageTableViewCell.h
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import "NewsItemTableViewCell.h"

static NSString *NewsItemImageTableViewCellIdentifier = @"NewsItemImageTableViewCell";

@interface NewsItemImageTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UIImageView *rightImageView;

- (id)initWithFrame:(CGRect)frame;

@end
