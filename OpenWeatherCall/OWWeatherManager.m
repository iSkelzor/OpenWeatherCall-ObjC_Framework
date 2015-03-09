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
    NSString* openWeatherID;
}

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID
{
    self = [super init];
    if (self != nil) {
        openWeatherID = OpenWeatherID;
    }
    
    return self;
}

-(Weather*)getActualWeatherWithLocation:(CLLocation*)Location AndError:(NSError**)error
{
    if (openWeatherID == nil) {
        *error = [self getOWError1];
        return nil;
    }
    
    Weather* MyWeather;
    
    return MyWeather;
}

-(NSError*)getOWError1
{
    NSString* userInfoString = [NSString stringWithFormat:@"The OpenWeatherID is not accessible or incorrect - you can check your ID at openweather.com"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                        code:1
                                    userInfo:userInfo];
}

@end
