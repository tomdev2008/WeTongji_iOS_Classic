//
//  NewsOutlineTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "NewsOutlineTableViewController.h"
#import "NewsOutlineTableViewCell.h"
#import "NSString+Addition.h"
#import "WTClient.h"

@interface NewsOutlineTableViewController ()

@end

@implementation NewsOutlineTableViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureTableViewHeaderFooter];
    [self loadMoreData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UI methods

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    News *news = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate newsOutlineTableViewDidSelectNews:news];
}

#pragma mark -
#pragma mark CoreDataTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"NewsOutlineTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if([cell isMemberOfClass:[NewsOutlineTableViewCell class]]) {
        NewsOutlineTableViewCell *outlineCell = (NewsOutlineTableViewCell *)cell;
        News *news = [self.fetchedResultsController objectAtIndexPath:indexPath];
        outlineCell.titleLabel.text = news.title;
        outlineCell.timeLabel.text = [NSString stringWithFormat:@"发表于 %@", [NSString yearMonthDayConvertFromDate:news.create_at]];
        outlineCell.categoryLabel.text = news.category;
    }
}

- (void)configureRequest:(NSFetchRequest *)request {
    [request setEntity:[NSEntityDescription entityForName:@"News" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *hiddenPredicate = [NSPredicate predicateWithFormat:@"hidden == NO"];
    [request setPredicate:hiddenPredicate];
    NSSortDescriptor *sortByUpdate = [[NSSortDescriptor alloc] initWithKey:@"update_date" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:sortByUpdate, nil];
    [request setSortDescriptors:descriptors]; 
    request.fetchBatchSize = 20;
}

- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath {
    [super insertCellAtIndexPath:indexPath];
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark EGORefresh Method

- (void)refresh {
    self.nextPage = 0;    
    [self loadMoreData];
}

- (void)clearData {
    NSArray *activitiesArray = [News allNewsInManagedObjectContext:self.managedObjectContext];
    for(News *news in activitiesArray) {
        news.hidden = [NSNumber numberWithBool:YES];
    }

}

- (void)loadMoreData {
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            if(self.nextPage == 0)
                [self clearData];
            NSArray *array = [client.responseData objectForKey:@"News"];
            for(NSDictionary *newsDict in array) {
                News *news = [News insertNews:newsDict inManagedObjectContext:self.managedObjectContext];
                news.hidden = [NSNumber numberWithBool:NO];
            }
            
            self.nextPage = [[NSString stringWithFormat:@"%@", [client.responseData objectForKey:@"NextPager"]] intValue];
            [self performSelector:@selector(configureTableViewFooter) withObject:nil afterDelay:0.3f];
        }
        [self doneLoadingTableViewData];
    }];
    [client getNewsList:self.nextPage];
}

@end
