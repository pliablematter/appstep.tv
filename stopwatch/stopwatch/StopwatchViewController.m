//
//  StopwatchViewController.m
//  stopwatch
//
//  Created by Doug Burns on 11/3/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import "StopwatchViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import "Utils.h"

@interface StopwatchViewController ()

@end

@implementation StopwatchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _elapsedTime = 0;
	// Do any additional setup after loading the view.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    
    _geocoder = [[CLGeocoder alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonTapped:(id)sender {
    
    _elapsedTime = 0;
    _timer = nil;
    self.stopwatchLabel.text = [Utils timeIntervalToMinutesAndSeconds:0];
    [self disableResetButton];
    [self disableSaveButton];
}

- (IBAction)startButtonTapped:(id)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self start];
    }
    else
    {
        [self stop];
    }
}

- (void) start
{
    [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    _startTime = [NSDate date];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [_timer fire];
    [self disableResetButton];
    [self disableSaveButton];
}

- (void) stop
{
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [_timer invalidate];
    _elapsedTime += abs([_startTime timeIntervalSinceNow]);
    [self enableResetButton];
    [self enableSaveButton];
}

- (void) enableResetButton
{
    self.resetButton.userInteractionEnabled = YES;
    self.resetButton.alpha = 1.0;
}

- (void) disableResetButton
{
    self.resetButton.userInteractionEnabled = NO;
    self.resetButton.alpha = .35;
}

- (void) enableSaveButton
{
    self.saveButton.userInteractionEnabled = YES;
    self.saveButton.alpha = 1.0;
}

- (void) disableSaveButton
{
    self.saveButton.userInteractionEnabled = NO;
    self.saveButton.alpha = .35;
}

- (IBAction)saveButtonTapped:(id)sender {
    [_locationManager startUpdatingLocation];
}

- (void) save
{
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *delegate = app.delegate;
    Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:delegate.managedObjectContext];
    event.timeStamp = [NSDate date];
    event.elapsedTime = [NSNumber numberWithDouble:_elapsedTime];
    event.locationName = _locationName;
    [delegate saveContext];
    [self disableSaveButton];

}

- (void) tick
{
    NSTimeInterval interval = abs([_startTime timeIntervalSinceNow]);
    NSTimeInterval adjustedInterval = interval + _elapsedTime;
    self.stopwatchLabel.text = [Utils timeIntervalToMinutesAndSeconds:adjustedInterval];
    NSLog(@"tick %f", interval);
}

/* CLLocationManagerDelegate */

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if ([locations count] > 0)
    {
        CLLocation *location = [locations objectAtIndex:0];
        if(location.horizontalAccuracy >= _locationManager.desiredAccuracy
           && [location.timestamp timeIntervalSinceNow] < 60)
        {
            // Get the location name
            [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
                if(!error)
                {
                    CLPlacemark *placemark = [placemarks objectAtIndex:0];
                    _locationName = placemark.name;

                }
                else
                {
                    _locationName = nil;
                }
            }];
            [self save];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_locationManager stopUpdatingLocation];
    _locationName = nil;
    [self save];
}

@end
