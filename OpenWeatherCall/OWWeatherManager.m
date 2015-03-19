//
//  OWWeatherManager.m
//  OpenWeatherCall
//
//  Created by Arbeit on 06.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import "OWWeatherManager.h"
#import "OWCityIDManager.h"

@implementation OWWeatherManager
{
    OWCityIDManager* cityIDManager;
}

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID
{
    self = [super init];
    if (self != nil) {
        cityIDManager = [[OWCityIDManager alloc] initWithOpenWeatherID:OpenWeatherID];
    }
    
    return self;
}

-(Weather*)getActualWeatherWithLocation:(CLLocation*)Location AndError:(NSError**)error
{
    Weather* MyWeather;
    
    return MyWeather;
}

@end
