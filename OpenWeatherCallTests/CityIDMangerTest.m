//
//  CityIDMangerTest.m
//  OpenWeatherCall
//
//  Created by Arbeit on 09.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OWCityIDManager.h"

@interface CityIDMangerTest : XCTestCase

{
    OWCityIDManager* TestCityIDManager;
}

@end

@implementation CityIDMangerTest

-(void)tearDown
{
    TestCityIDManager = nil;
}

-(void)testInit
{
    TestCityIDManager = [[OWCityIDManager alloc] init];
    XCTAssertNotNil(TestCityIDManager);
}

-(void)testGetCityIDWithoutWeatherID
{
    TestCityIDManager = [[OWCityIDManager alloc] init];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:nil AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 1);
    XCTAssertNil(cityID);
}

-(void)testInitialisation
{
    TestCityIDManager = [[OWCityIDManager alloc]
                         initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    XCTAssertNotNil(TestCityIDManager);
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:[self getCLLocationObject] AndError:&error];
    
    XCTAssertNotNil(cityID);
    XCTAssertNil(error);
}

-(void)testStandardGetCityID
{
    TestCityIDManager = [[OWCityIDManager alloc]
                         initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:[self getCLLocationObject] AndError:&error];
    
    NSLog(@"%@", error);
    
    XCTAssertNotNil(cityID);
    XCTAssertNil(error);
}

-(void)testGetCityIDWithoutLocationButOldCityID
{
    TestCityIDManager = [[OWCityIDManager alloc]
                         initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:[self getCLLocationObject] AndError:&error];
    
    XCTAssertNotNil(cityID);
    XCTAssertNil(error);
    
    NSNumber* newCityID;
    newCityID = [TestCityIDManager getCityIDWithLocation:nil AndError:&error];
    
    XCTAssertEqualObjects(cityID, newCityID);
    XCTAssertNil(error);
}

-(void)testGetCityIDWithoutLocationAndWithoutOldCityID
{
    TestCityIDManager = [[OWCityIDManager alloc]
                         initWithOpenWeatherID:@"66510fffd7680c052f065d3444fa4759"];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:nil AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 11);
    XCTAssertNil(cityID);
}

-(CLLocation*)getCLLocationObject
{
    return [[CLLocation alloc] initWithLatitude:51.34 longitude:12.37];
}

@end
