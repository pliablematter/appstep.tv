//
//  StopwatchViewController.m
//  stopwatch
//
//  Created by Doug Burns on 11/3/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import "StopwatchViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonTapped:(id)sender {
}

- (IBAction)startButtonTapped:(id)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        
        _startTime = [NSDate date];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
        [_timer fire];
    }
    else
    {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        [_timer invalidate];
    }
}

- (IBAction)saveButtonTapped:(id)sender {
}

- (void) tick
{
    NSTimeInterval interval = abs([_startTime timeIntervalSinceNow]);
    self.stopwatchLabel.text = [self timeIntervalToMinutesAndSeconds:interval];
    NSLog(@"tick %f", interval);
}

- (NSString*) timeIntervalToMinutesAndSeconds:(int)timeInterval
{
    int minutes = floor(timeInterval / 60);
    int seconds = timeInterval % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

@end
