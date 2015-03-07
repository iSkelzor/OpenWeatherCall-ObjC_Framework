//
//  OWWeatherManager.m
//  OpenWeatherCall
//
//  Created by Arbeit on 06.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import "OWWeatherManager.h"

@implementation OWWeatherManager
{
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
        NSString* userInfoString = [NSString stringWithFormat:@"The OpenWeatherID is not accessible or incorrect - you can check you ID at openweather.com"];
        NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                             forKey:@"userInfo"];
        
        *error = [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                           code:1
                                       userInfo:userInfo];
        return nil;
    }
    
    Weather* MyWeather;
    
    return MyWeather;
}

@end
