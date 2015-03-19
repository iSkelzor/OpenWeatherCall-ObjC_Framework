//
//  Weather.m
//  OpenWeatherCall
//
//  Created by Arbeit on 06.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import "OWWeather.h"

@implementation OWWeather

-(instancetype)initWithTemperature:(double)temperature
                       description:(NSString*)description
                     unixTimestamp:(long)unixTimestamp
                       AndLocation:(CLLocation*)location
{
    self = [super init];
    if (self != nil) {
        _temperature = temperature;
        _weatherDescription = description;
        _unixTimestamp = unixTimestamp;
        _location = location;
    }
    
    return self;
}

-(instancetype)initWithTemperature:(double)temperature
                       description:(NSString*)description
                       AndLocation:(CLLocation*)location
{
    self = [super init];
    if (self != nil) {
        _temperature = temperature;
        _weatherDescription = description;
        _location = location;
        
        _unixTimestamp = [[NSDate date] timeIntervalSince1970];
    }
    
    return self;
}

@end
