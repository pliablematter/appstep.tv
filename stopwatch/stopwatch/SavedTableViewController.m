//
//  SavedTableViewController.m
//  stopwatch
//
//  Created by Doug Burns on 1/25/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import "SavedTableViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import "SavedTableViewCell.h"
#import "Utils.h"

@interface SavedTableViewController ()

@end

@implementation SavedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIApplication *app = [UIApplication sharedApplication];
    _appDelegate = app.delegate;
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"M/d/yy HH:mm a"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getEvents] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"savedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Event *event = [[self getEvents] objectAtIndex:indexPath.row];
    
    SavedTableViewCell *savedCell = (SavedTableViewCell*) cell;
    savedCell.elapsedTimeLabel.text = [Utils timeIntervalToMinutesAndSeconds:[event.elapsedTime integerValue]];
    savedCell.dateTimeLabel.text = [_dateFormatter stringFromDate:event.timeStamp];
    
    return cell;
}

- (NSArray*) getEvents
{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSArray *times = [_appDelegate.managedObjectContext executeFetchRequest:fetch error:&error];
    NSLog(@"_savedTimes size is %d", (int) [times count]);
    if(error)
    {
        NSLog(@"There was a error fetching saved times %@", error.description);
    }
    return times;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_appDelegate.managedObjectContext deleteObject:[[self getEvents] objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
