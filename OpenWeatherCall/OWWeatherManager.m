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
    long lastWeatherCheck;
    NSString* openWeatherID;
}

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID
{
    self = [super init];
    if (self != nil) {
        cityIDManager = [[OWCityIDManager alloc] initWithOpenWeatherID:OpenWeatherID];
        openWeatherID = OpenWeatherID;
    }
    
    return self;
}

-(OWWeather*)getActualWeatherWithLocation:(CLLocation*)location AndError:(NSError**)error
{
    if ((cityIDManager == nil) || (openWeatherID == nil)) {
        *error = [OWErrors getOWError2ForIncompleteInitialisation];
        return nil;
    }
    
    long time = [[NSDate date] timeIntervalSince1970];
    
    if ((time - lastWeatherCheck) < 600) {
        *error = [OWErrors getOWError3ForToEarlyActualisation];
        return nil;
    }
    
    NSNumber* cityID = [cityIDManager getCityIDWithLocation:location AndError:error];
    
    NSString *urlString =
    [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?id=%@&APPID=%@",
     cityID, openWeatherID];
    NSURL *weatherURL = [NSURL URLWithString: urlString];
    
    //HTTP-Request - conscious in sync
    NSData* data = [NSData dataWithContentsOfURL:weatherURL];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:error];
    
    if (!*error) {
        OWWeather* MyWeather = [self getActualWeatherDataFromDict:json
                                                   WithLocation:location
                                                       AndError:error];
        if (!*error) {
            return MyWeather;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

-(OWWeather*)getActualWeatherDataFromDict:(NSDictionary*)jsonDict
                           WithLocation:(CLLocation*)location
                               AndError:(NSError**)error
{
    OWWeather* MyWeather;
    
    @try {
        double temperature = [[[jsonDict objectForKey:@"main"] objectForKey:@"temp"] floatValue];
        NSString* description = [[[jsonDict objectForKey:@"weather"] objectAtIndex:0]
                                                             valueForKey:@"icon"];
        
        MyWeather = [[OWWeather alloc] initWithTemperature:temperature
                                               description:description
                                               AndLocation:location];
        return MyWeather;
    }
    @catch (NSException *exception) {
        *error = [OWErrors getOWError4ForUnsuccessfulDataRead];
        return nil;
    }
}

@end
