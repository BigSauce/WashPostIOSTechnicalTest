//
//  ArticlePostViewController.h
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlePost.h"

@interface ArticlePostViewController : UIViewController

/// article post to display
@property (strong, nonatomic) ArticlePost *articlePost;

@end
