//
//  NewsItem.h
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *newsDescription;
@property (nonatomic, strong) NSString *imageHref;

- (id)initWithDictionary:(NSDictionary*)newsItem;

@end
