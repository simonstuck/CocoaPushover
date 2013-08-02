//
//  CocoaPushoverTests.m
//  CocoaPushoverTests
//
//  Created by Simon Stückemann on 01/08/2013.
//  Copyright (c) 2013 Simon Stückemann. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CocoaPushover.h"

@interface CocoaPushoverTests : XCTestCase

@end

@implementation CocoaPushoverTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];

    [options setValue:@">>>>>YOURTOKEN<<<<<" forKey:@"token"];
    [options setValue:@">>>>>YOURUSER<<<<<<" forKey:@"user"];
    [options setValue:@"Hello World!" forKey:@"message"];
    
    NSError *err;
    XCTAssertTrue([CocoaPushover sendSynchronousNotification:options error:&err]);
}

@end
