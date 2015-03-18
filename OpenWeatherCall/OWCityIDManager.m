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
    NSNumber* cityIDLongitude;
    NSNumber* cityIDLatitude;
    NSMutableArray* safedCityIDs;
}

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID
{
    self = [super init];
    if (self != nil) {
        openWeatherID = OpenWeatherID;
        //load CityIDs
    }
    
    return self;
}

-(NSNumber*)getCityIDWithLocation:(CLLocation*)location AndError:(NSError**)error
{
    if (openWeatherID == nil) {
        *error = [self getOWError1ForNoWeatherID];
        return nil;
    }
    
    if (location == nil) {
        if (cityID == nil) {
            *error = [self getOWError11ForNoCityID];
            return nil;
        } else {
            return cityID;
        }
    } else if (cityID != nil) {
        if ([self calculateVectorDistanceWithLatitude:cityIDLatitude
                                         AndLongitude:cityIDLongitude
                                          AndLocation:location]
            < 0.1) {
            return cityID;
        }
    }
    
    [self getNewCityIDWithLocation:location AndError:error];
    
    if (error) {
        return cityID;
    } else {
        return nil;
    }
}

-(void)getNewCityIDWithLocation:(CLLocation*)location AndError:(NSError**)error
{
    NSString *urlString = [NSString stringWithFormat:
                           @"http://api.openweathermap.org/data/2.5/find?lat=%f&lon=%f&cnt=%i%@",
                           location.coordinate.latitude,
                           location.coordinate.longitude, 1, openWeatherID];
    NSURL *weatherURL = [NSURL URLWithString: urlString];
    
    //HTTP-Request - conscious in sync
    NSData* data = [NSData dataWithContentsOfURL:weatherURL];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:error];
    
    if (error) {
        if (![self dataAreValidateWithDict:json]) {
            *error = [self getOWError12ForWrongOWCityID];
        } else {
            cityID = [[NSNumber alloc] initWithDouble:
                      [[[[json objectForKey:@"list"] objectAtIndex:0]
                        objectForKey:@"id"] doubleValue]];
            cityIDLongitude = [cityIDLongitude initWithDouble:location.coordinate.longitude];
            cityIDLatitude = [cityIDLatitude initWithDouble:location.coordinate.latitude];
        }
    }
}

-(bool)dataAreValidateWithDict:(NSDictionary*)json
{
    @try {
        if ([[[[json objectForKey:@"list"] objectAtIndex:0] objectForKey:@"id"] doubleValue] == 0 ||
            [[[json objectForKey:@"list"] objectAtIndex:0] objectForKey:@"id"] == nil) {
            return false;
        } else {
            return true;
        }
    }
    @catch (NSException *exception) {
        return false;
    }
}

-(double)calculateVectorDistanceWithLatitude:(NSNumber* )Latitude
                                AndLongitude:(NSNumber* )Longitude
                                 AndLocation:(CLLocation* )Location
{
    return sqrt(((Location.coordinate.latitude - [Latitude doubleValue]) *
                 (Location.coordinate.latitude - [Latitude doubleValue])) +
                ((Location.coordinate.longitude - [Longitude doubleValue]) *
                 (Location.coordinate.longitude - [Longitude doubleValue])));
}

//-----------------------------------------------------------------------------------------------
#pragma mark NSErrors
//-----------------------------------------------------------------------------------------------

-(NSError*)getOWError1ForNoWeatherID
{
    NSString* userInfoString = [NSString stringWithFormat:@"The OpenWeatherID is not accessible or incorrect - you can check your ID at openweather.com"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:1
                                  userInfo:userInfo];
}

-(NSError*)getOWError11ForNoCityID
{
    NSString* userInfoString = [NSString stringWithFormat:@"There is no old cityID, you have to set a location for get a new one."];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:11
                                  userInfo:userInfo];
}

-(NSError*)getOWError12ForWrongOWCityID
{
    NSString* userInfoString = [NSString stringWithFormat:@"OpenWeather sends a not validate CityID"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:12
                                  userInfo:userInfo];
}

@end
