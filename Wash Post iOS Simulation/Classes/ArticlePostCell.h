//
//  ArticlePostCell.h
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlePost.h"

/// Displays an article post from the Washington Post in a table view cell.
/// Only displays the title and date of the article.
@interface ArticlePostCell : UITableViewCell

/// Upon setting this property, the cell's UI will be updated automatically
@property (strong, nonatomic) ArticlePost *articlePost;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
