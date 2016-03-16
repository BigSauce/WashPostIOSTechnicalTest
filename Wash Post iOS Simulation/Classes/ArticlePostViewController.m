//
//  ArticlePostViewController.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import "ArticlePostViewController.h"

@interface ArticlePostViewController ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ArticlePostViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self refreshUI];
}

- (void)setArticlePost:(ArticlePost *)articlePost {
    
    _articlePost = articlePost;
    
    [self refreshUI];

}

- (void)refreshUI {
    
    self.titleLabel.text = self.articlePost.title;
    self.contentLabel.attributedText = self.articlePost.content;
    self.dateLabel.text = [self.articlePost stringRepresentationForDate];
    
    self.navigationItem.title = self.articlePost.title;
}

@end
