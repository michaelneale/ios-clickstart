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

- (void)testExample
{
    STAssertEquals(@"this", @"this", @"Everything is ok");
}

- (void)testHello
{
    CBViewController *cont = [CBViewController new];
    NSString *result = [cont hello:@"world" and:@"that is all"];
    STAssertEqualObjects(@"world", result, @"Hello to the world");

}

- (void) testHttpGet
{
    STAssertNotNil([CBNetworkClient httpGet:@"http://www.google.com"], @"We can reach google");
}

- (void) testJSON {
    
    NSString *responseString = @"{\"hello\":\"world\"}";
    NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    STAssertTrue([object isKindOfClass:[NSDictionary class]], @"We get a dictionary back");
    
    NSDictionary *fields = (NSDictionary *) object;
    STAssertEqualObjects(@"world", [fields valueForKey:@"hello"], @"Hello world JSON");
}

@end
