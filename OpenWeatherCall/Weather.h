//
//  Weather.h
//  OpenWeatherCall
//
//  Created by Arbeit on 06.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Weather : NSObject

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
