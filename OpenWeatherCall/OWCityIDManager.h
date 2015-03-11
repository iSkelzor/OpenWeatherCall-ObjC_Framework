//
//  OWCityIDManager.h
//  OpenWeatherCall
//
//  Created by Arbeit on 08.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OWCityIDManager : NSObject

-(instancetype)initWithOpenWeatherID:(NSString*)OpenWeatherID;

//for getting the last used cityID set location nil
-(NSNumber*)getCityIDWithLocation:(CLLocation*)location AndError:(NSError**)error;

@end
