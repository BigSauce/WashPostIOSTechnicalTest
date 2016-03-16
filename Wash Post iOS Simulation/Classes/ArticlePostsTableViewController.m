//
//  ArticlePostsTableViewController.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import "ArticlePostsTableViewController.h"
#import "ArticlePostCell.h"
#import "ArticlePostFetcher.h"
#import "ArticlePostViewController.h"

#define kSortByTitle 0
#define kSortOrderAscending 0

typedef NS_ENUM(NSInteger, SortMethod) {
    SortMethodByTitle = 0,
    SortMethodByDate
};


@interface ArticlePostsTableViewController ()

/// list of retrieved article posts for displaying in the table view
@property (strong, nonatomic) NSArray<ArticlePost *> *articlePosts;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sortBySegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortOrderSegmentedControl;

@property (assign, nonatomic) SortMethod sortMethod;
@property (assign, nonatomic) BOOL sortAscending;

@end

@implementation ArticlePostsTableViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self refreshSortFlags];
    
    [self loadArticlePostsFromApi];

}


#pragma mark - Imperatives

- (void)loadArticlePostsFromApi {
    
    [ArticlePostFetcher fetchArticlePostsWithSuccess:^(NSArray<ArticlePost *> *articlePosts) {
        
        self.articlePosts = [self sortedArticlePosts:articlePosts];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        
        // when the app fails to load article posts from the api, for the sake of this exercise,
        // we're going to permit the already-loaded articles to stay in the UI to prevent
        // a jarring user experience (e.g., "What?  They just disappeared?!  Ah come on.")
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error loading article posts" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)refreshSortFlags {
    
    self.sortMethod = (SortMethod) self.sortBySegmentedControl.selectedSegmentIndex;
    self.sortAscending = self.sortOrderSegmentedControl.selectedSegmentIndex == 0;
}

- (void)sortLoadedArticlePosts {
    
    [self refreshSortFlags];
    
    self.articlePosts = [self sortedArticlePosts:self.articlePosts];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Convenience

/**
 *  Returns an array of sorted article posts according to the sort flags set by the user.
 *
 *  @param articlePosts array of not-necessarily-sorted article posts
 *
 **/
- (NSArray *)sortedArticlePosts:(NSArray <ArticlePost *> *)articlePosts {
    
    if (!articlePosts || !articlePosts.count)
        return nil;
    
    
    NSString *sortKey = (self.sortMethod == SortMethodByTitle) ? @"title" : @"date";
    
    NSArray *sortedArray = [articlePosts sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:self.sortAscending] ]];
    
    return sortedArray;
}


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numRows = self.articlePosts ? self.articlePosts.count : 0;
    
    return numRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 129;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // we don't need a switch statement for multiple cell types as would be in a production app,
    // since in this simplified exercise, we only have one cell type.
    
    ArticlePostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ArticlePostCell"];
    
    ArticlePost *articlePost = self.articlePosts[indexPath.row];
    
    // Note:  alternatively, I could have had this view controller assign the titleLabel and dateLabel property
    //          on behalf of the cell, but I went ahead with this approach for this exercise.
    //          I do, however, realize the model dependency implications.  Willing to discuss that facet in an interview.
    
    // allow the cell to update itself accordingly.
    cell.articlePost = articlePost;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ArticlePostViewController *articlePostVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ArticlePostVC"];
    
    articlePostVC.articlePost = self.articlePosts[indexPath.row];
    
    [self.navigationController pushViewController:articlePostVC animated:YES];

}


#pragma mark - IBActions

- (IBAction)sortByValueChanged:(id)sender {
    
    [self sortLoadedArticlePosts];
}

- (IBAction)sortOrderValueChanged:(id)sender {
    
    [self sortLoadedArticlePosts];
}



@end
