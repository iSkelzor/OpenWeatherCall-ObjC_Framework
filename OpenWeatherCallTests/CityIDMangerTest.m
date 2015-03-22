/*
 <OpenWeatherCall-Framework for getting the free weather data from openweather.com>
 Copyright (C) <2015>  <Andreas Braatz>
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

//--------------------------------------------------------------
//Before testing - eventually set an OpenWeatherID! (see bottom)
//--------------------------------------------------------------

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
                         initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    XCTAssertNotNil(TestCityIDManager);
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:[self getExampleCLLocationObject]
                                             AndError:&error];
    
    XCTAssertNotNil(cityID);
    XCTAssertNil(error);
}

-(void)testStandardGetCityID
{
    TestCityIDManager = [[OWCityIDManager alloc]
                         initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:[self getExampleCLLocationObject]
                                             AndError:&error];
    
    XCTAssertNotNil(cityID);
    XCTAssertNil(error);
}

-(void)testGetCityIDWithoutLocationButOldCityID
{
    TestCityIDManager = [[OWCityIDManager alloc]
                         initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:[self getExampleCLLocationObject]
                                             AndError:&error];
    
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
                         initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    NSNumber* cityID;
    NSError* error;
    cityID = [TestCityIDManager getCityIDWithLocation:nil AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 11);
    XCTAssertNil(cityID);
}

-(NSString*)getExampleOpenWeatherID
{
    return @"";
}

-(CLLocation*)getExampleCLLocationObject
{
    return [[CLLocation alloc] initWithLatitude:51.0  longitude:0.0];
}

@end
