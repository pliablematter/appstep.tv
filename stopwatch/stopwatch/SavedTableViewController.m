//
//  SavedTableViewController.m
//  stopwatch
//
//  Created by Doug Burns on 1/25/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import "SavedTableViewController.h"
#import "Event.h"
#import "SavedTableViewCell.h"
#import "Utils.h"
#import "ImageViewController.h"

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
    savedCell.locationNameLabel.text = event.locationName;
    
    if(event.imageName != NULL)
    {
        savedCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        savedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
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
        Event *event = [[self getEvents] objectAtIndex:indexPath.row];
        if(event.imageName != nil)
        {
            NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:event.imageName];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error;
            [fileManager removeItemAtPath:imagePath error:&error];
            if(error)
            {
                NSLog(@"Error deleting file %@", error.description);
            }
        }
        [_appDelegate.managedObjectContext deleteObject:event];
        [_appDelegate saveContext];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"imageSegue" sender:nil];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    // Only segue if the selected row has a disclosure indicator
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    return (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the documents directory
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // Get the image name from the event in the selected row
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    Event *event = [[self getEvents] objectAtIndex:indexPath.row];
    
    // Get the full image path
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:event.imageName];
    
    NSLog(@"imagePath %@", imagePath);
    
    // Create a UIImage object for the path
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    NSLog(@"image width 1: %f", image.size.width);
    
    // Pass it to the image view controller
    ImageViewController *imageViewController = (ImageViewController*) segue.destinationViewController;
    imageViewController.image = image;
}

- (NSArray*) getEvents {
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timeStamp" ascending:NO];
    [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSError *error;
    NSArray *times = [_appDelegate.managedObjectContext executeFetchRequest:fetch error:&error];
    if(error) {
        NSLog(@"There was an error while fetching saved time. %@", error.description);
    }
    return times;
}

@end
