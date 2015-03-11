//
//  OWCityIDManager.m
//  OpenWeatherCall
//
//  Created by Arbeit on 08.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import "OWCityIDManager.h"

@implementation OWCityIDManager

{
    NSString* openWeatherID;
    NSNumber* cityID;
}

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID
{
    self = [super init];
    if (self != nil) {
        openWeatherID = OpenWeatherID;
    }
    
    return self;
}

-(NSNumber*)getCityIDWithLocation:(CLLocation*)location AndError:(NSError**)error
{
    if (openWeatherID == nil) {
        *error = [self getOWError1];
        return nil;
    }
    
    if (location == nil) {
        if (cityID == nil) {
            *error = [self getOWError11];
            return nil;
        } else {
            
        }
    }
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

-(NSError*)getOWError11
{
    NSString* userInfoString = [NSString stringWithFormat:@"There is no old cityID, you have to set a location for get a new one."];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:11
                                  userInfo:userInfo];
}

@end
