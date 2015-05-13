//
//  News.h
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SourceURL @"https://dl.dropboxusercontent.com/u/746330/facts.json"

@interface News : NSObject

@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSString *newsMainTitle;
@property (nonatomic, assign) id delegate;
@property (nonatomic, readonly, assign) NSInteger resultCode;

- (id)initWithDelegate:(id)self;
- (void)refresh;
@end

@protocol NewsDelegate
- (void)newsDidUpdate:(id)sender;
@end

