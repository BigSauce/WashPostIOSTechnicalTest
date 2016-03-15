//
//  ArticlePostCell.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import "ArticlePostCell.h"

@implementation ArticlePostCell


- (void)setArticlePost:(ArticlePost *)articlePost {
    
    // accept value as new even if not new (did this on purpose)
    
    _articlePost = articlePost;
    
    // will invoke layoutSubviews at the appropriate time (prevents redrawing potentially countlessly)
    [self setNeedsDisplay];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];

    self.titleLabel.text = self.articlePost ? self.articlePost.title : @"";
    self.dateLabel.text = self.articlePost ? [self.articlePost stringRepresentationForDate] : @"";
}

@end
