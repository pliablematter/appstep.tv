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
    }
    else
    {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (IBAction)saveButtonTapped:(id)sender {
}
@end
