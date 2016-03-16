//
//  ArticlePostFetcherTests.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArticlePostFetcher.h"

@interface ArticlePostFetcherTests : XCTestCase

/// no article post fetcher property needed, since the fetching methods are static
/// and do not depend upon an instance of the ArticlePostFetcher class.

@end

@implementation ArticlePostFetcherTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/// Tests that fetching article posts from valid URL returns non-nil, non-empty array
/// of ArticlePost instances.
- (void)testFetchReturnsParsedArticlePosts {

    [ArticlePostFetcher fetchArticlePostsWithSuccess:^(NSArray *articlePosts) {
        XCTAssertNotNil(articlePosts);
        XCTAssertTrue(articlePosts.count > 0);
        
        for (NSObject *object in articlePosts) {
            
            // insufficient time in technical test to create meaningful message -- sorry!
            XCTAssertTrue([object isKindOfClass:[ArticlePost class]], @"Expected ArticlePost object in articlePosts array--got something else");
        }
        
    } failure:^(NSError *error) {
        XCTFail();
    }];
}

/// Reasonable timeframe is subjective, and this test case is probably oversimplified
/// (doesn't account for slow network connectivity or disconnectivity),
/// but hopefully the point is illustrated nonetheless.
- (void)testFetchAndParseReturnsSuccessInReasonableTimeframe {

    XCTestExpectation *reasonableTimeframeExpectation = [self expectationWithDescription:@"fetch and parse in reasonable timeframe"];
    
    [ArticlePostFetcher fetchArticlePostsWithSuccess:^(NSArray<ArticlePost *> *articlePosts) {
    
        
        [reasonableTimeframeExpectation fulfill];
        
    } failure:^(NSError *error) {
        XCTFail();
    }];
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

@end
