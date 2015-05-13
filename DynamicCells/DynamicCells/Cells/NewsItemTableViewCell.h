//
//  NewsItemTableViewCell.h
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *NewsItemTableViewCellIdentifier = @"NewsItemTableViewCell";

@interface NewsItemTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;

- (id)initWithFrame:(CGRect)frame;

@end