//
//  SavedTableViewController.h
//  stopwatch
//
//  Created by Doug Burns on 1/25/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SavedTableViewController : UITableViewController {
    
    AppDelegate *_appDelegate;
    NSDateFormatter *_dateFormatter;
}

@end
