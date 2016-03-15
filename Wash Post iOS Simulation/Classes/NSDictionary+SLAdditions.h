//
//  NSDictionary+SLAdditions.h
//  Wash Post iOS Simulation
//
//  Created by Alejandro Vargas on 3/15/16.
//  Copyright © 2016 Alex Vargas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SLAdditions)

/*
    Returns dictionary from json string.
    If jsonString is invalid JSON, then nil is returned.
 
    @param jsonString string representation of a json object
 */
+ (instancetype)dictionaryFromJsonString:(NSString *)jsonString;

@end
