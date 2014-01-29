//
//  SavedTableViewController.m
//  stopwatch
//
//  Created by Doug Burns on 1/28/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import "SavedTableViewController.h"
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
    NSArray *events = [self getEvents];
    NSInteger count = [events count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"savedCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Event *event = [[self getEvents] objectAtIndex:indexPath.row];
    
    SavedTableViewCell *savedCell = (SavedTableViewCell*) cell;
    savedCell.elapsedTimeLabel.text = [Utils timeIntervalToMinutesAndSeconds:[event.elapsedTime integerValue]];
    savedCell.dateTimeLabel.text = [_dateFormatter stringFromDate:event.timeStamp];
    
    return cell;
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
        [_appDelegate.managedObjectContext deleteObject:[[self getEvents] objectAtIndex:indexPath.row]];
        [_appDelegate saveContext];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (NSArray*) getEvents {
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSArray *times = [_appDelegate.managedObjectContext executeFetchRequest:fetch error:&error];
    if(error) {
        NSLog(@"There was an error while fetching saved times. %@", error.description);
    }
    return times;
}

@end
