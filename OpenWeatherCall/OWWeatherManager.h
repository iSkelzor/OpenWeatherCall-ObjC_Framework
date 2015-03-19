//
//  OWWeatherManager.h
//  OpenWeatherCall
//
//  Created by Arbeit on 06.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWWeather.h"
#import "OWErrors.h"

@interface OWWeatherManager : NSObject

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID;

-(OWWeather*)getActualWeatherWithLocation:(CLLocation*)location AndError:(NSError**)error;

-(NSArray*)getHistoricWeatherWithLocation:(CLLocation*)location
                            Unixstarttime:(long)start
                              Unixendtime:(long)end
                                 AndError:(NSError*)error;

@property(readonly) long LastWeatherCheck;

@end
