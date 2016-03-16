//
//  ArticlePost.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import "ArticlePost.h"

@implementation ArticlePost


+ (ArticlePost *)articlePostFromJson:(NSDictionary *)jsonDict {
    
    
    // if invalid json dictionary is provided, return nil
    if (![NSJSONSerialization isValidJSONObject:jsonDict])
        return nil;
    
    // json appears to be valid.
    // Create and configure an ArticlePost.
    
    ArticlePost *post = [[ArticlePost alloc] initWithDictionary:jsonDict];


    
    return post;
}

/**
 * We're going to assume for the sake of this exercise that the Product Owner
 * has specified that it is OK for articles to be returned from the API with
 * partial (incomplete) data, meaning some fields could be missing or empty.
 *
 * @param dictionary - json dictionary from which to initialize
**/
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    
    // if invalid json dictionary is provided, return nil
    if (![NSJSONSerialization isValidJSONObject:dictionary])
        return nil;
    
    self = [super init];

    if (self)
    {
        // a bit of pre-configuring prior to assignment of properties
        
        NSString *dateString = (NSString *) dictionary[@"date"];
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        self.postId = (NSNumber *) dictionary[@"id"];
        self.title = (NSString *) dictionary[@"title"];
        self.content = (NSString *) dictionary[@"content"];
        self.excerpt = (NSString *) dictionary[@"excerpt"];
        self.date = [dateFormatter dateFromString:dateString];
        
    }
    
    return self;
    
}

- (instancetype)initWithJsonString:(NSString *)jsonString {
    
    
    NSDictionary *jsonDict = [NSDictionary dictionaryFromJsonString:jsonString];
    
    if (!jsonDict || !jsonDict.count)
    {
        NSLog(@"Unable to parse nil/empty json: %@", jsonString);
        return nil;
    }
    
    return [self initWithDictionary:jsonDict];
}

/// Returns string representation of date property or empty string if date property is nil.
- (NSString *)stringRepresentationForDate {
    
    if (!self.date)
        return @"";
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    NSString *dateString = [dateFormatter stringFromDate:self.date];
    
    return dateString;
}

@end
