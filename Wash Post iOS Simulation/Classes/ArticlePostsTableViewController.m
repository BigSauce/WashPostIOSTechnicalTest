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


@interface ArticlePostsTableViewController ()

/// list of retrieved article posts for displaying in the table view
@property (strong, nonatomic) NSArray<ArticlePost *> *articlePosts;

@end

@implementation ArticlePostsTableViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadArticlePostsFromApi];
}


#pragma mark - Imperatives

- (void)loadArticlePostsFromApi {
    
    [ArticlePostFetcher fetchArticlePostsWithSuccess:^(NSArray<ArticlePost *> *articlePosts) {
        
        self.articlePosts = articlePosts;
        
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


#pragma mark - UITableViewDataSource/Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numRows = self.articlePosts ? self.articlePosts.count : 0;
    
    return numRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
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


@end
