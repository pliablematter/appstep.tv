//
//  stopwatchTests.m
//  stopwatchTests
//
//  Created by Doug Burns on 11/2/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface stopwatchTests : XCTestCase

@end

@implementation stopwatchTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    // This should log Goodbye
    if(1==2)
    {
        NSLog(@"Hello");
    }
    else
    {
        NSLog(@"Goodbye");
    }
    
    // Variables
    int temperature = 32;
    NSString *units = @"celsius";
    NSLog(@"The current temperature is %d degrees %@", temperature, units);
    
    // Calling functions
    [self logTemperature: 72 withUnits:@"fahrenheit"];
    [self logTemperature: 32 withUnits:@"celsius"];
    [self logTemperature: 0 withUnits:@"fahrenheit"];
}

- (void)logTemperature:(int)temperature withUnits:(NSString*)units
{
    NSLog(@"The current temperature is %d degrees %@", temperature, units);
}

@end
