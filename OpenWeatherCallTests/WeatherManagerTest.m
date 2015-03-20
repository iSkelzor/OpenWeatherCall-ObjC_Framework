//
//  OpenWeatherCallTests.m
//  OpenWeatherCallTests
//
//  Created by Arbeit on 06.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "OWWeatherManager.h"

@interface WeatherManagerTest : XCTestCase

@end

@implementation WeatherManagerTest

{
    OWWeather* TestWeather;
    OWWeatherManager* TestWeatherManager;
}

-(void)tearDown
{
    TestWeather = nil;
    TestWeatherManager = nil;
}

-(void)testInit
{
    TestWeatherManager = [[OWWeatherManager alloc] init];
    XCTAssertNotNil(TestWeatherManager);
}

-(void)testAcutalWeatherWithoutWeatherID
{
    TestWeatherManager = [[OWWeatherManager alloc] init];
    
    NSError* error;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getCLLocationObject]
                                                          AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 2);
    XCTAssertNil(TestWeather);
}

-(void)testInitialisation
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    XCTAssertNotNil(TestWeatherManager);
    
    NSError* error;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getCLLocationObject]
                                                          AndError:&error];
    //incomplete
    XCTAssertNotNil(TestWeather);
    XCTAssertNil(error);
}

-(void)testGetActualWeather
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    NSError* error;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getCLLocationObject]
                                                          AndError:&error];
    
    
    //
    XCTAssertNotNil(TestWeather);
    XCTAssertNil(error);
}

-(void)testLastWeatherCheck
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    NSError* error2;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getCLLocationObject]
                                                          AndError:&error2];
    
    long unixTime = [[NSDate date] timeIntervalSince1970];
    XCTAssertEqualWithAccuracy(unixTime, TestWeatherManager.LastWeatherCheck, 10);
    
    OWWeather* TestWeatherSecound;
    NSError* error;
    TestWeatherSecound = [TestWeatherManager getActualWeatherWithLocation:[self getCLLocationObject]
                                                          AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 3);
    XCTAssertEqualObjects(TestWeather, TestWeatherSecound);
}

//Tests for historic weather

-(CLLocation*)getCLLocationObject
{
    return [[CLLocation alloc] initWithLatitude:51.34 longitude:12.37];
}

@end