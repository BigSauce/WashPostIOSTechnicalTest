//
//  ArticlePostFetcher.h
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticlePost.h"


/// ArticlePostFetcher is responsible for retrieving article posts from the Washington Post API.
@interface ArticlePostFetcher : NSObject

/**
 *  Retrieves article posts from the Washington Post API and returns an array of parsed ArticlePost* objects.
 *
 *  @param success block invoked upon successful retrieval and parsing of article posts (optional)
 *  @param failure block invoked upon failure to retrieve article posts
 **/
+ (void)fetchArticlePostsWithSuccess:(void (^)(NSArray<ArticlePost *> *articlePosts))success failure:(void (^)(NSError *error))failure;

@end
