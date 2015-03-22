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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "OWWeather.h"

@interface WeatherTest : XCTestCase

@end

@implementation WeatherTest
{
    OWWeather* TestWeather;
}

-(void)tearDown
{
    TestWeather = nil;
}

-(void)testInit
{
    TestWeather = [[OWWeather alloc] init];
    XCTAssertNotNil(TestWeather);
}

-(void)testFullInitialisation
{
    CLLocation* TestLocation = [self getCLLocationObject];
    
    TestWeather = [[OWWeather alloc] initWithTemperature:10
                                           description:@"rain"
                                         unixTimestamp:123456789
                                           AndLocation:TestLocation
                   ];
    
    XCTAssertNotNil(TestWeather);
    XCTAssertEqual(10, TestWeather.temperature);
    XCTAssertEqualObjects(@"rain", TestWeather.weatherDescription);
    XCTAssertEqual(123456789, TestWeather.unixTimestamp);
    XCTAssertEqualObjects(TestLocation, TestWeather.location);
}

-(void)testInitialisationWithoutUnixtime
{
    CLLocation* TestLocation = [self getCLLocationObject];
    
    TestWeather = [[OWWeather alloc] initWithTemperature:10
                                           description:@"rain"
                                           AndLocation:TestLocation
                   ];
    
    long unixTime = [[NSDate date] timeIntervalSince1970];
    XCTAssertEqualWithAccuracy(unixTime, TestWeather.unixTimestamp, 10);
    
    XCTAssertEqual(10, TestWeather.temperature);
    XCTAssertEqualObjects(@"rain", TestWeather.weatherDescription);
    XCTAssertEqualObjects(TestLocation, TestWeather.location);
}

-(void)testAttributePersistency
{
    NSString* TestDescription = [NSString stringWithFormat:@"DescTest"];
    CLLocation* TestLocation = [self getCLLocationObject];
    
    TestWeather = [[OWWeather alloc] initWithTemperature:10
                                           description:TestDescription
                                         unixTimestamp:123456789
                                           AndLocation:TestLocation
                   ];
    
    NSString* TestDescriptionNew = TestDescription;
    CLLocation* TestLocationNew = TestLocation;
    
    TestDescription = nil;
    TestLocation = nil;
    
    XCTAssertEqualObjects(TestWeather.weatherDescription, TestDescriptionNew);
    XCTAssertEqualObjects(TestWeather.location, TestLocationNew);
}
                                
-(CLLocation*)getCLLocationObject
{
    return [[CLLocation alloc] initWithLatitude:51.34 longitude:12.37];
}

@end
