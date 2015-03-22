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
        *error = [OWErrors getOWError1ForNoWeatherID];
        return nil;
    }
    
    if (location == nil) {
        if (cityID == nil) {
            *error = [OWErrors getOWError11ForNoCityID];
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
    
    if (!*error) {
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
    
    if (!*error) {
        if (![self dataAreValidateWithDict:json]) {
            *error = [OWErrors getOWError12ForWrongOWCityID];
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

@end
