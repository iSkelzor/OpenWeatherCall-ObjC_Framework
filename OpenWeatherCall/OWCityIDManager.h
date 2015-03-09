//
//  OWCityIDManager.h
//  OpenWeatherCall
//
//  Created by Arbeit on 08.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWCityIDManager : NSObject

//for the last used cityID set location nil
-(NSNumber*)getCityIDWithLocation:(CLLocation*)location AndError:(NSError**)error;

@end
