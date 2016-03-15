//
//  ArticlePostParsingTests.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArticlePost.h"

@interface ArticlePostParsingTests : XCTestCase

@end

@implementation ArticlePostParsingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testArticlePostInitWithDictionary {
    
    NSDictionary *dictRepresentation = @{
                                         @"id": @"80437",
                                         @"title": @"Matt Drudge and Hillary Clinton: A History",
                                         @"content": @"An inverse relationship seems to exist between the length of time since...",
                                         @"excerpt": @"excerpt offering a preview of the article post",
                                         @"date": @"2014-02-12 20:29:36"
                                         };
    
    ArticlePost *articlePost = [ArticlePost articlePostFromJson:dictRepresentation];
    
    XCTAssertNotNil(articlePost);
    XCTAssertNotNil(articlePost.postId);
    XCTAssertNotNil(articlePost.title);
    XCTAssertNotNil(articlePost.content);
    XCTAssertNotNil(articlePost.excerpt);
    XCTAssertNotNil(articlePost.date);
}

@end
