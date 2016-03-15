//
//  NSDictionary+SLAdditions.m
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import "NSDictionary+SLAdditions.h"

@implementation NSDictionary (SLAdditions)

+ (instancetype)dictionaryFromJsonString:(NSString *)jsonString {
    
    NSError *jsonError;
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&jsonError];
    
    jsonDict = [NSJSONSerialization isValidJSONObject:jsonDict] ? jsonDict : nil;
    
    return jsonDict;
}

@end
