//
//  OWErrors.h
//  OpenWeatherCall
//
//  Created by Arbeit on 19.03.15.
//  Copyright (c) 2015 Andreas Braatz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWErrors : NSObject

+(NSError*)getOWError1ForNoWeatherID;
+(NSError*)getOWError2ForIncompleteInitialisation;
+(NSError*)getOWError3ForToEarlyActualisation;
+(NSError*)getOWError4ForUnsuccessfulDataRead;

+(NSError*)getOWError11ForNoCityID;
+(NSError*)getOWError12ForWrongOWCityID;

@end
