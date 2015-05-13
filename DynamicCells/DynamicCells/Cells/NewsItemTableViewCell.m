//
//  NewsItemTableViewCell.m
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import "NewsItemTableViewCell.h"


@interface NewsItemTableViewCell()

@property (nonatomic,strong) CAGradientLayer *gradient;

@end

@implementation NewsItemTableViewCell


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NewsItemTableViewCellIdentifier]) {
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
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, self.bounds.size.width-10, 55)];
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
        
        // Add all the views
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_descriptionLabel];
        
        // Setup constraints
        [self setupConstraints];
    }
    
    return self;
}

- (void)initializeViewWithFrame:(CGRect)frame
{
    
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
    // Title label left
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:5.0]];
    // Title label right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:-5.0]];
    
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
    // Description label right
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:-5.0]];
    // Description label bottom
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
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