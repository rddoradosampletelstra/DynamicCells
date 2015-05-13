//
//  NewsItem.m
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

- (id)initWithDictionary:(NSDictionary*)newsItem {
    if (self = [super init]) {
        _title = @"";
        _newsDescription = @"";
        _imageHref = @"";
        
        if (newsItem) {
            id title = [newsItem objectForKey:@"title"];
            id newsDescription = [newsItem objectForKey:@"description"];
            id imageHref = [newsItem objectForKey:@"imageHref"];
            
            if (![title isKindOfClass:[NSNull class]]) {
                _title = [newsItem objectForKey:@"title"];
            }
            if (![newsDescription isKindOfClass:[NSNull class]]) {
                _newsDescription = [newsItem objectForKey:@"description"];
            }
            if (![imageHref isKindOfClass:[NSNull class]]) {
                _imageHref = [newsItem objectForKey:@"imageHref"];
            }
        }
        
        // Check for null
        if (!_title) _title = @"";
        if (!_newsDescription) _newsDescription = @"";
        if (!_imageHref) _imageHref = @"";
    }
    return self;
}

@end
