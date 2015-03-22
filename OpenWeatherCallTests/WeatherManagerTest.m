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

#import "OWWeatherManager.h"

@interface WeatherManagerTest : XCTestCase

@end

@implementation WeatherManagerTest

{
    OWWeather* TestWeather;
    OWWeatherManager* TestWeatherManager;
    NSArray* historicWeatherArray;
}

-(void)tearDown
{
    TestWeather = nil;
    TestWeatherManager = nil;
    historicWeatherArray = nil;
}

-(void)testInit
{
    TestWeatherManager = [[OWWeatherManager alloc] init];
    XCTAssertNotNil(TestWeatherManager);
}

//-----------------------------------------------------------------------------------------------
#pragma mark Actual Weather tests
//-----------------------------------------------------------------------------------------------

-(void)testAcutalWeatherWithoutWeatherID
{
    TestWeatherManager = [[OWWeatherManager alloc] init];
    
    NSError* error;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getExampleCLLocationObject]
                                                          AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 2);
    XCTAssertNil(TestWeather);
}

-(void)testInitialisation
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    XCTAssertNotNil(TestWeatherManager);
    
    NSError* error;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getExampleCLLocationObject]
                                                          AndError:&error];
    //incomplete
    XCTAssertNotNil(TestWeather);
    XCTAssertNil(error);
}

-(void)testGetActualWeather
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    NSError* error;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getExampleCLLocationObject]
                                                          AndError:&error];
    
    XCTAssertNotNil(TestWeather);
    XCTAssertTrue((TestWeather.temperature > -50) && (TestWeather.temperature < 80));
    
    XCTAssertNil(error);
}

-(void)testLastWeatherCheck
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    NSError* error2;
    TestWeather = [TestWeatherManager getActualWeatherWithLocation:[self getExampleCLLocationObject]
                                                          AndError:&error2];
    
    long unixTime = [[NSDate date] timeIntervalSince1970];
    XCTAssertEqualWithAccuracy(unixTime, TestWeatherManager.LastWeatherCheck, 10);
    
    OWWeather* TestWeatherSecound;
    NSError* error;
    TestWeatherSecound = [TestWeatherManager getActualWeatherWithLocation:[self getExampleCLLocationObject]
                                                          AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 3);
    XCTAssertEqualObjects(TestWeather, TestWeatherSecound);
}

//-----------------------------------------------------------------------------------------------
#pragma mark Historic Weather tests
//-----------------------------------------------------------------------------------------------

-(void)testHistoricWeatherWithoutWeatherID
{
    TestWeatherManager = [[OWWeatherManager alloc] init];
    
    NSError* error;
    historicWeatherArray = [TestWeatherManager
                            getHistoricWeatherWithLocation:[self getExampleCLLocationObject]
                            Unixstarttime:100000000
                            Unixendtime:100010000
                            AndError:&error];
    
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 2);
    XCTAssertNil(historicWeatherArray);
}

-(void)testGetHistoricWeather
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    long time = [[NSDate date] timeIntervalSince1970];
    NSError* error;
    historicWeatherArray = [TestWeatherManager
                            getHistoricWeatherWithLocation:[self getExampleCLLocationObject]
                            Unixstarttime:(time - 50000)
                            Unixendtime:(time - 30000)
                            AndError:&error];
    
    if (([historicWeatherArray count] > 0)) {
        OWWeather *exampleWeather = [historicWeatherArray objectAtIndex:0];
        XCTAssertNotNil(exampleWeather);
        XCTAssertTrue((exampleWeather.temperature > -50) && (exampleWeather.temperature < 80));
        XCTAssertNil(error);
    } else {
        XCTAssertNil(historicWeatherArray);
        XCTAssertNotNil(error);
        XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
        XCTAssertEqual(error.code, 4);
    }
}

-(void)testUnhistoricWeatherTime
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    long time = [[NSDate date] timeIntervalSince1970];
    NSError* error;
    historicWeatherArray = [TestWeatherManager
                            getHistoricWeatherWithLocation:[self getExampleCLLocationObject]
                            Unixstarttime:(time - 10000)
                            Unixendtime:(time + 1000)
                            AndError:&error];
    
    XCTAssertNil(historicWeatherArray);
    XCTAssertNotNil(error);
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 6);
}

-(void)testStarttimeLaterEndtime
{
    TestWeatherManager = [[OWWeatherManager alloc]
                          initWithOpenWeatherID:[self getExampleOpenWeatherID]];
    
    NSError* error;
    historicWeatherArray = [TestWeatherManager
                            getHistoricWeatherWithLocation:[self getExampleCLLocationObject]
                            Unixstarttime:(100010000)
                            Unixendtime:(100000000)
                            AndError:&error];
    
    XCTAssertNil(historicWeatherArray);
    XCTAssertNotNil(error);
    XCTAssertTrue([error.domain isEqualToString:@"OWGettingWeatherError"]);
    XCTAssertEqual(error.code, 5);
}

//-----------------------------------------------------------------------------------------------
#pragma mark test supporting methods
//-----------------------------------------------------------------------------------------------

-(CLLocation*)getExampleCLLocationObject
{
    return [[CLLocation alloc] initWithLatitude:51.0 longitude:0.0];
}

-(NSString*)getExampleOpenWeatherID
{
    return @"";
}

@end