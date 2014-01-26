//
//  Event.h
//  stopwatch
//
//  Created by Doug Burns on 1/26/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSNumber * elapsedTime;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * locationName;

@end
