
//
//  NewsItemImageTableViewCell.m
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import "NewsItemImageTableViewCell.h"

@interface NewsItemImageTableViewCell()

@property (nonatomic,strong) CAGradientLayer *gradient;
@property (nonatomic,strong) UIView *spaceFiller;
@property (nonatomic,strong) UIView *gradientBackground;

@end


@implementation NewsItemImageTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NewsItemImageTableViewCellIdentifier]) {
        // Initialization code
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.frame = frame;
        
        // Setup title label
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width-10, 20)];
        _titleLabel.numberOfLines = 0;
        _descriptionLabel.contentMode = UIViewContentModeTop;
        _titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Setup description label
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, self.bounds.size.width-10-120, 55)];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.contentMode = UIViewContentModeTop;
        _descriptionLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:13];
        _descriptionLabel.backgroundColor = [UIColor clearColor];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.textColor = [UIColor blackColor];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Setup gradient background
        _gradient = [CAGradientLayer layer];
        _gradient.frame = self.bounds;
        UIColor *colorGradientUpper = [UIColor colorWithRed:250.0/255.0f green:250.0/255.0f blue:250.0/255.0f alpha:255.0/255.0f];
        UIColor *colorGradientLower = [UIColor colorWithRed:209.0/255.0f green:209.0/255.0f blue:209.0/255.0f alpha:255.0/255.0f];
        _gradient.colors = [NSArray arrayWithObjects:(id)[colorGradientUpper CGColor], (id)[colorGradientLower CGColor], nil];
        [self.contentView.layer insertSublayer:_gradient atIndex:0];
        
        // Setup Right image view
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-5-120, 25, 120, 90)];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightImageView.clipsToBounds = YES;
        _rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Setup description label filler
        _spaceFiller = [[UIView alloc] initWithFrame:CGRectMake(5, 80, self.bounds.size.width-10-120, 5)];
        _spaceFiller.backgroundColor = [UIColor greenColor];
        _spaceFiller.translatesAutoresizingMaskIntoConstraints = NO;
        
        // Add all the views
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_descriptionLabel];
        [self.contentView addSubview:_rightImageView];
        [self.contentView addSubview:_spaceFiller];
        
        // Setup constraints
        [self setupConstraints];
        
    }
    
    return self;
}

- (void)setupConstraints
{
    // Title label top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:5.0]];
    
    // Title label height
    [_titleLabel addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:20.0]];
    
    // Title label left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:5.0]];
    
    // Description label top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_titleLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0.0]];
    // Description label left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:5.0]];
    // Spacefiller top
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_spaceFiller
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_descriptionLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:0.0]];
    // Spacefiller left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_spaceFiller
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:5.0]];
    // Spacefiller bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_spaceFiller
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-5.0]];
    // Right image view height
    [_rightImageView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:90.0]];
    // Right image view width
    [_rightImageView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                attribute:NSLayoutAttributeWidth
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.0
                                                                 constant:120.0]];
    // Right image view vertical alignment
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0.0]];
    // Right image view left to title label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_titleLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:5.0]];
    // Right image view left to description label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_descriptionLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:5.0]];
    // Right image view left to space filler
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:_spaceFiller
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:5.0]];
    // Right image view bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationLessThanOrEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-5.0]];
    // Right image view right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_rightImageView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:-5.0]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.frame);
    self.descriptionLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.descriptionLabel.frame);
    _gradient.frame = self.bounds;
}

@end