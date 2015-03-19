//
//  OWErrors.m
//  OpenWeatherCall
//
//  Created by Arbeit on 19.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import "OWErrors.h"

@implementation OWErrors

+(NSError*)getOWError1ForNoWeatherID
{
    NSString* userInfoString = [NSString stringWithFormat:@"The OpenWeatherID is not accessible or incorrect - you can check your ID at openweather.com"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:1
                                  userInfo:userInfo];
}

+(NSError*)getOWError2ForIncompleteInitialisation;
{
    NSString* userInfoString = [NSString stringWithFormat:@"The Initialisation of this object was incomplete - you should reinitialise it."];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:2
                                  userInfo:userInfo];
}

+(NSError*)getOWError3ForToEarlyActualisation
{
    NSString* userInfoString = [NSString stringWithFormat:@"to reduce openweather-call actualisation is only possible after 10 minutes"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:3
                                  userInfo:userInfo];
}

+(NSError*)getOWError4ForUnsuccessfulDataRead
{
    NSString* userInfoString = [NSString stringWithFormat:@"the OpenWeather data are couldn't read"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:4
                                  userInfo:userInfo];
}

+(NSError*)getOWError11ForNoCityID
{
    NSString* userInfoString = [NSString stringWithFormat:@"There is no old cityID, you have to set a location for get a new one."];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:11
                                  userInfo:userInfo];
}

+(NSError*)getOWError12ForWrongOWCityID
{
    NSString* userInfoString = [NSString stringWithFormat:@"OpenWeather sends a not validate CityID"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:12
                                  userInfo:userInfo];
}

@end
