//
//  NewsTableViewController.m
//  DynamicCells
//
//  Created by Ronaldo II Dorado on 13/5/15.
//  Copyright (c) 2015 Ronaldo II Dorado. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsTableViewController.h"
#import "News.h"
#import "NewsItem.h"
#import "NewsItemTableViewCell.h"
#import "NewsItemImageTableViewCell.h"
#import "ImageDownloader.h"

#define kRowHeight 100.0f
#define kRowHeightMinimum 115.0f

@interface NewsTableViewController ()<NewsDelegate>

@property (nonatomic, strong) News *news;
@property (nonatomic, strong) UIColor *colorNavBar;
@property (nonatomic, strong) UIColor *colorNavBarText;
@property (nonatomic, strong) UIColor *colorNewsTitle;
@property (nonatomic, strong) UIColor *colorNewsDescription;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Define the custom colors
    [self defineColors];
    
    // Set table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIRefreshControl *aRefreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = aRefreshControl;
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView setHidden:YES];
    [self.navigationController.navigationBar setHidden:NO];
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // Set Navbar and Title
    self.navigationController.navigationBar.barTintColor = self.colorNavBar;
    self.navigationController.navigationBar.tintColor = self.colorNavBarText;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : self.colorNavBarText}];
    self.title = @"Loading...";
    
    // News allocate and refresh
    self.news = [[News alloc] initWithDelegate:self];
    [self.news refresh];
    
    self.tableView.estimatedRowHeight=100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.tableView reloadData];
}

#pragma mark - Table View Delegate Methods
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return kRowHeightMinimum;
    
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self heightForNewsItemImageTableViewCellAtIndexPath:indexPath];
    }
    else {
        return [self heightForNewsItemTableViewCellAtIndexPath:indexPath];
    }
}

#pragma mark - Private Methods
- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    BOOL returnValue = NO;
    
    if (row<self.news.newsArray.count) {
        
        NSDictionary *newsItemDictionary = [self.news.newsArray objectAtIndex:row];
        if (newsItemDictionary)
        {
            NewsItem *newsItem = [[NewsItem alloc] initWithDictionary:newsItemDictionary];
            NSString *imageUrl = newsItem.imageHref?newsItem.imageHref:@"";
            if (imageUrl && imageUrl.length > 0 ) {
                returnValue = YES;
            }
            
        }
    }
    
    return returnValue;
    
}

-(NewsItemImageTableViewCell *)createNewsItemImageCellAtIndexPath:(NSIndexPath *)indexPath
{
    NewsItemImageTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NewsItemImageTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[NewsItemImageTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kRowHeightMinimum)];
    }
    
    [self setNewsItemImageCell:cell AtIndexPath:indexPath];
    
    return cell;
    
}

-(NewsItemTableViewCell *)createNewsItemCellAtIndexPath:(NSIndexPath *)indexPath
{
    NewsItemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NewsItemTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[NewsItemTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kRowHeightMinimum)];
    }
    
    [self setNewsItemCell:cell AtIndexPath:indexPath];
    
    return cell;
    
}

- (void)setNewsItemImageCell:(NewsItemImageTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath
{
    
    // Create table cell
    NSInteger row = indexPath.row;
    
    cell.userInteractionEnabled = NO;
    
    if (row<self.news.newsArray.count) {
        
        NSDictionary *newsItemDictionary = [self.news.newsArray objectAtIndex:row];
        if (newsItemDictionary)
        {
            NewsItem *newsItem = [[NewsItem alloc] initWithDictionary:newsItemDictionary];
            if (!newsItem) {
                cell.titleLabel.text = @"";
                cell.descriptionLabel.text = @"";
            }
            // Set Title
            cell.titleLabel.text = newsItem.title?newsItem.title:@"";
            // Set Description
            cell.descriptionLabel.text =  newsItem.newsDescription?newsItem.newsDescription:@"";
            
            // Set Image View
            NSString *imageUrl = newsItem.imageHref?newsItem.imageHref:@"";
            cell.rightImageView.image = nil;
            //cell.rightImageView.image = [UIImage imageNamed:@"placeHolder"];
            ImageDownloader *imageDownloader = [[ImageDownloader alloc] init];
            [imageDownloader downloadImageUrl:imageUrl forTableView:self.tableView forCellIndexPath:indexPath];
            
            // Set colors
            cell.titleLabel.textColor = self.colorNewsTitle;
            cell.descriptionLabel.textColor = self.colorNewsDescription;
        }
        else {
            cell.titleLabel.text = @"";
            cell.descriptionLabel.text = @"";
            
        }
    }
}

- (CGFloat)heightForNewsItemImageTableViewCellAtIndexPath:(NSIndexPath *)indexPath {
    static NewsItemImageTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self createNewsItemImageCellAtIndexPath:indexPath];
    });
    
    CGRect frame = sizingCell.frame;
    frame.size.width = self.tableView.frame.size.width;
    sizingCell.frame = frame;
    [sizingCell layoutIfNeeded];
    
    [self setNewsItemImageCell:sizingCell AtIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)heightForNewsItemTableViewCellAtIndexPath:(NSIndexPath *)indexPath {
    static NewsItemTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self createNewsItemCellAtIndexPath:indexPath];
    });
    
    CGRect frame = sizingCell.frame;
    frame.size.width = self.tableView.frame.size.width;
    sizingCell.frame = frame;
    [sizingCell layoutIfNeeded];
    
    [self setNewsItemCell:sizingCell AtIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    [sizingCell needsUpdateConstraints];
    
    CGSize size = [sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

- (void)setNewsItemCell:(NewsItemTableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    
    // Create table cell
    NSInteger row = indexPath.row;
    
    cell.userInteractionEnabled = NO;
    
    if (row<self.news.newsArray.count) {
        
        NSDictionary *newsItemDictionary = [self.news.newsArray objectAtIndex:row];
        if (newsItemDictionary)
        {
            NewsItem *newsItem = [[NewsItem alloc] initWithDictionary:newsItemDictionary];
            if (!newsItem) {
                cell.titleLabel.text = @"";
                cell.descriptionLabel.text = @"";
            }
            // Set Title
            cell.titleLabel.text = newsItem.title?newsItem.title:@"";
            // Set Description
            cell.descriptionLabel.text =  newsItem.newsDescription?newsItem.newsDescription:@"";
            
            // Set colors
            cell.titleLabel.textColor = self.colorNewsTitle;
            cell.descriptionLabel.textColor = self.colorNewsDescription;
        }
        else {
            cell.titleLabel.text = @"";
            cell.descriptionLabel.text = @"";
            
        }
    }
}

- (void)defineColors
{
    self.colorNavBar = [UIColor colorWithRed:237.0/255.0f green:135.0/255.0f blue:33.0/255.0f alpha:255.0/255.0f];
    self.colorNavBarText = [UIColor colorWithRed:177.0/255.0f green:35.0/255.0f blue:55.0/255.0f alpha:255.0/255.0f];
    self.colorNewsTitle = [UIColor colorWithRed:83.0/255.0f green:63.0/255.0f blue:191.0/255.0f alpha:255.0/255.0f];
    self.colorNewsDescription = [UIColor colorWithRed:100.0/255.0f green:100.0/255.0f blue:100.0/255.0f alpha:255.0/255.0f];
}


#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.news.newsArray && self.news.newsArray.count>0) {
        return  self.news.newsArray.count;
    }
    else {
        return 0;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self hasImageAtIndexPath:indexPath]) {
        return ([self createNewsItemImageCellAtIndexPath:indexPath]);
    }
    else {
        return ([self createNewsItemCellAtIndexPath:indexPath]);
    }
    
}

#pragma mark - News Delegate Method
- (void)newsDidUpdate:(id)sender {
    
    // End Refreshing
    [self.refreshControl endRefreshing];
    
    [self.tableView setHidden:NO];
    [self.tableView reloadData];
    
    self.title = self.news.newsMainTitle;
    
    if ([sender resultCode] != 200) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to connect to server." message:@"Please try again at a later time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - Refresh Control Delegate Method
-(void)refresh:(id)sender {
    
    // Refresh News
    [self.news refresh];
    
}

@end