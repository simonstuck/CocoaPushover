//
//  CocoaPushover.h
//  CocoaPushover
//
//  Created by Simon Stückemann on 01/08/2013.
//  Copyright (c) 2013 Simon Stückemann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CocoaPushover : NSObject

/*
 * Sends a synchronous request to the pushover servers
 *
 * Returns true iff the request succeeded 
 *
 * Specify the arguments in the options parameter; 
 * "token", "user", "message" are required parameters
 */
+ (BOOL)sendSynchronousNotification:(NSDictionary *)options error:(NSError *__autoreleasing *)err;

@end
