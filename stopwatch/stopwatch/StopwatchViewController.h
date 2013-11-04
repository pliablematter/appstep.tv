//
//  StopwatchViewController.h
//  stopwatch
//
//  Created by Doug Burns on 11/3/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StopwatchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)resetButtonTapped:(id)sender;
- (IBAction)startButtonTapped:(id)sender;
- (IBAction)saveButtonTapped:(id)sender;


@end
