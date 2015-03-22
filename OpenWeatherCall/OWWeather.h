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
#import <CoreLocation/CoreLocation.h>
#import "OWErrors.h"

@interface OWWeather : NSObject

-(instancetype)initWithTemperature:(double)temperature
                       description:(NSString*)description
                     unixTimestamp:(long)unixTimestamp
                       AndLocation:(CLLocation*)location;

-(instancetype)initWithTemperature:(double)temperature
                       description:(NSString*)description
                       AndLocation:(CLLocation*)location;

@property (readonly) double temperature;
@property (nonatomic, readonly, copy) NSString* weatherDescription;
@property (readonly) long unixTimestamp;
@property (nonatomic, readonly, copy) CLLocation* location;

@end
