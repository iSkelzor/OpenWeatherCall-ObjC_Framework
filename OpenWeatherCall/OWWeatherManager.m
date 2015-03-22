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

#import "OWWeatherManager.h"
#import "OWCityIDManager.h"

@implementation OWWeatherManager
{
    OWCityIDManager* cityIDManager;
    NSString* openWeatherID;
    
    OWWeather* lastWeather;
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
    
    if ((time - _LastWeatherCheck) < 600) {
        *error = [OWErrors getOWError3ForToEarlyActualisation];
        return lastWeather;
    }
    
    NSNumber* cityID = [cityIDManager getCityIDWithLocation:location AndError:error];
    
    if (*error) {
        return nil;
    }
    
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
        OWWeather* newWeather;
        newWeather = [self getWeatherDataFromDict:json
                                            WithLocation:location
                                                AndError:error];
        if ((newWeather != nil) && (!*error)) {
            _LastWeatherCheck = time;
            lastWeather = newWeather;
        }
        return lastWeather;
    } else {
        return nil;
    }
}

-(NSArray*)getHistoricWeatherWithLocation:(CLLocation*)location
                            Unixstarttime:(long)start
                              Unixendtime:(long)end
                                 AndError:(NSError**)error;
{
    if ((cityIDManager == nil) || (openWeatherID == nil)) {
        *error = [OWErrors getOWError2ForIncompleteInitialisation];
        return nil;
    }
    
    long time = [[NSDate date] timeIntervalSince1970];
    
    if ((time < start) || (time < end)) {
        *error = [OWErrors getOWError6ForUnhistoricWeather];
        return nil;
    }
    
    if (start > end) {
        *error = [OWErrors getOWError5ForStartTimeLaterEndtime];
        return nil;
    }
    
    NSNumber* cityID = [cityIDManager getCityIDWithLocation:location AndError:error];
    
    if (*error) {
        return nil;
    }
    
    NSString *urlString =
    [NSString stringWithFormat:
     @"http://api.openweathermap.org/data/2.5/history/city?id=%@&type=hour&start=%li&end=%li",
     cityID, start, end];
    NSURL *weatherURL = [NSURL URLWithString: urlString];
    
    //HTTP-Request - conscious in sync
    NSData* data = [NSData dataWithContentsOfURL:weatherURL];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:error];
    
    NSMutableArray* historicWeatherArray;
    if (!*error) {
        historicWeatherArray = [NSMutableArray alloc];
        long count = [self countHistoricDataArrayFromDict:json WithError:error];
        
        for (int i = 0; i < count; ++i) {
            OWWeather* newWeather = [self getWeatherDataFromDict:[[json objectForKey:@"list"]
                                                                  objectAtIndex:i]
                                                    WithLocation:location
                                                        AndError:error];
            if (!*error) {
                [historicWeatherArray addObject:newWeather];
            } else {
                return nil;
            }
        }
    }
    
    if ((!*error) && (historicWeatherArray != nil)) {
        return historicWeatherArray;
    } else {
        return nil;
    }
}

-(OWWeather*)getWeatherDataFromDict:(NSDictionary*)jsonDict
                           WithLocation:(CLLocation*)location
                               AndError:(NSError**)error
{
    OWWeather* MyWeather;
    
    @try {
        double temperature = [[[jsonDict objectForKey:@"main"] objectForKey:@"temp"] floatValue];
        temperature = temperature - 273.15; //from Kelvin to Celsius
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

-(long)countHistoricDataArrayFromDict:(NSDictionary*)jsonDict WithError:(NSError**)error
{
    @try {
        long count = [[jsonDict valueForKey:@"cnt"] integerValue];
        
        if (count > 0) {
            return count;
        } else {
            *error = [OWErrors getOWError4ForUnsuccessfulDataRead];
            return 0;
        }
    }
    @catch (NSException *exception) {
        *error = [OWErrors getOWError4ForUnsuccessfulDataRead];
        return 0;
    }
}

@end
