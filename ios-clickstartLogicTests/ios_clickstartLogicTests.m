//
//  ios_clickstartLogicTests.m
//  ios-clickstartLogicTests
//
//  Created by Michael Neale on 11/03/13.
//  Copyright (c) 2013 Michael Neale. All rights reserved.
//

#import "ios_clickstartLogicTests.h"
#import "CBViewController.h"
#import "CBNetworkClient.h"

@implementation ios_clickstartLogicTests

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


- (void)testOnAController
{
    CBViewController *cont = [CBViewController new];
    NSString *result = [cont hello:@"world" and:@"that is all"];
    STAssertEqualObjects(@"world", result, @"Hello to the world");
}

- (void) testHttpGet
{
    STAssertNil([CBNetworkClient httpGet:@"http://localhost:9876"], @"Nil for no service");
    STAssertNotNil([CBNetworkClient httpGet:@"http://www.google.com"], @"We can reach google");
}

- (void) testParsingJSON {
    NSDictionary *res = [CBNetworkClient parseJSON:@"{\"hello\":\"world\"}"];
    STAssertNotNil(res, @"we get a dictionary");
    STAssertEqualObjects(@"world", [res valueForKey:@"hello"], @"it should have this value");
    STAssertNil([CBNetworkClient parseJSON:@"garbage"], @"should be nil as not json");
    STAssertNil([CBNetworkClient parseJSON:nil], @"should handle nil");
}

- (void) testMakeUrl {
    STAssertEqualObjects(@"base/path", [CBNetworkClient makeURL:@"base" withPath:@"path"], @"Check path");
}

@end
