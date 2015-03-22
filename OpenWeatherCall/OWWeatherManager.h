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

#import <Foundation/Foundation.h>
#import "OWWeather.h"
#import "OWErrors.h"

@interface OWWeatherManager : NSObject

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID;

-(OWWeather*)getActualWeatherWithLocation:(CLLocation*)location AndError:(NSError**)error;

-(NSArray*)getHistoricWeatherWithLocation:(CLLocation*)location
                            Unixstarttime:(long)start
                              Unixendtime:(long)end
                                 AndError:(NSError**)error;

@property(readonly) long LastWeatherCheck;

@end
