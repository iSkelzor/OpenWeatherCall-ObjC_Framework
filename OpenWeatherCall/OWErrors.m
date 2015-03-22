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

+(NSError*)getOWError5ForStartTimeLaterEndtime
{
    NSString* userInfoString = [NSString stringWithFormat:@"Starttime later endtime"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:5
                                  userInfo:userInfo];
}

+(NSError*)getOWError6ForUnhistoricWeather
{
    NSString* userInfoString = [NSString stringWithFormat:@"Time is in the future"];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:userInfoString
                                                         forKey:@"userInfo"];
    
    return [[NSError alloc] initWithDomain:@"OWGettingWeatherError"
                                      code:6
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
