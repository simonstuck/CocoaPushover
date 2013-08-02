//
//  CocoaPushover.m
//  CocoaPushover
//
//  Created by Simon Stückemann on 01/08/2013.
//  Copyright (c) 2013 Simon Stückemann. All rights reserved.
//

#import "CocoaPushover.h"

// Extending NSDictionary to encode the options dictionary into a x-www-formurlencoded format
@interface NSDictionary (WebFormify)

- (NSString *)formPostParameterString;

@end

@implementation NSDictionary (WebFormify)


/*
 * URL to Pushover API
 */
NSString * const kPushoverAPIURL = @"https://api.pushover.net/1/messages.json";

// Create a x-www-formurlencoded string from the dictionary
- (NSString *)formPostParameterString
{
    NSMutableString *formPostParams = [NSMutableString string];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *encodedValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)(obj), NULL, CFSTR("=/:"), kCFStringEncodingUTF8));
        
        [formPostParams appendString:[NSString stringWithFormat:@"%@=%@&", key, encodedValue]];
    }];
    [formPostParams deleteCharactersInRange:NSMakeRange([formPostParams length] - 1, 1)];
    return formPostParams;
}

@end


@implementation CocoaPushover


/*
 * Sends a synchronous request to the pushover servers
 *
 * Returns true iff the request succeeded
 *
 * Specify the arguments in the options parameter;
 * "token", "user", "message" are required parameters
 */
+ (BOOL)sendSynchronousNotification:(NSDictionary *)options error:(NSError *__autoreleasing *)err
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kPushoverAPIURL]];
    
    [request setHTTPMethod:@"POST"];

    NSString *formParams = [options formPostParameterString];
    [request setHTTPBody:[formParams dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
 
    NSHTTPURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:err];
    if (*err)
        return NO;
    
    return [self checkResponse:response apiResponse:responseData error:err];
}


/*
 * Checks the server response for errors and populates the error variable if necessary
 */
+ (BOOL)checkResponse:(NSHTTPURLResponse *)response apiResponse:(NSData *)responseData error:(NSError *__autoreleasing *)err
{
    NSDictionary *apiResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:err];
    if (*err)
        return NO;
    
    if (([response statusCode] != 200) || ![(NSNumber *)[apiResponse valueForKey:@"status"] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        *err = [NSError errorWithDomain:@"com.simonstuck.CocoaPusher" code:1001 userInfo:apiResponse];
        return NO;
    }
    
    return YES;
}

@end
