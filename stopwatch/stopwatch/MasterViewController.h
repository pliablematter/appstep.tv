//
//  MasterViewController.h
//  stopwatch
//
//  Created by Doug Burns on 11/2/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
