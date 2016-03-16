//
//  ArticlePost.h
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+SLAdditions.h"

@interface ArticlePost : NSObject


/// unique identifier for the article post
@property (strong, nonatomic) NSNumber *postId;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *excerpt;
@property (strong, nonatomic) NSDate *date;

/// Returns an ArticlePost instance from a json dictionary.
+ (ArticlePost *)articlePostFromJson:(NSDictionary *)jsonDict;

/**
 *  Returns an initialized ArticlePost from a valid json string
 *  or nil if json is invalid.
 **/
- (instancetype)initWithJsonString:(NSString *)jsonString;

/**
 * Returns an initialized ArticlePost from a valid json dictionary
 *  or nil if json is invalid.
 *
 * @param dictionary - json dictionary from which to initialize
 **/
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


/// Returns string representation of date property or empty string if date property is nil.
- (NSString *)stringRepresentationForDate;

@end
