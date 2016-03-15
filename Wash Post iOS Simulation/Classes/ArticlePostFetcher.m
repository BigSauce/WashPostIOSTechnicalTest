//
//  ArticlePostFetcher.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import "ArticlePostFetcher.h"
#import "AFNetworking.h"

// for the sake of this exercise, we're hard coding the API endpoint
#define kApiEndpoint @"http://www.washingtonpost.com/wp-srv/simulation/simulation_test.json"


@implementation ArticlePostFetcher

+ (void)fetchArticlePostsWithSuccess:(void (^)(NSArray<ArticlePost *> *))success failure:(void (^)(NSError *))failure {
    
    NSError *requestError;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:kApiEndpoint parameters:nil error:&requestError];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *responseDict) {
        
        NSArray *parsedArticlePosts = [self parsedArticlesFromSuccessResponseDictionary:responseDict];
        
        // for this exercise, consider no parsed article posts a success as long
        // as that is what the api (internal and external) allowed.
        if (success)
            success(parsedArticlePosts);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (failure)
            failure(error);
    }];
    
    
    [requestOperation start];
}

+ (NSArray *)parsedArticlesFromSuccessResponseDictionary:(NSDictionary *)responseDict {
    
    // nothing to parse if json is invalid--return nil
    if (![NSJSONSerialization isValidJSONObject:responseDict])
        return nil;
    
    // array of dictionary representations of article posts
    NSArray<NSDictionary *> *articlePostDicts = (NSArray<NSDictionary *> *) responseDict[@"posts"];
    
    NSMutableArray *parsedArticlePosts = [NSMutableArray array];
    ArticlePost *articlePost;
    
    // parse the article post dictionaries
    for (NSDictionary *articlePostDict in articlePostDicts) {
        
        articlePost = [ArticlePost articlePostFromJson:articlePostDict];
        
        if (articlePost)
        {
            [parsedArticlePosts addObject:articlePost];
        }
    }
    
    return parsedArticlePosts;
}

@end
