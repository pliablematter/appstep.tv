//
//  Utils.m
//  stopwatch
//
//  Created by Doug Burns on 1/25/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString*) timeIntervalToMinutesAndSeconds:(int)timeInterval
{
    int minutes = floor(timeInterval / 60);
    int seconds = timeInterval % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

@end
