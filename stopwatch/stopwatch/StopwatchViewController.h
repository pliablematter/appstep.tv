//
//  StopwatchViewController.h
//  stopwatch
//
//  Created by Doug Burns on 11/3/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface StopwatchViewController : UIViewController<CLLocationManagerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    NSDate *_startTime;
    NSTimer *_timer;
    NSTimeInterval _elapsedTime;
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    NSString *_locationName;
    UIActionSheet *_actionSheet;
    UIImagePickerController *_cameraUi;
    NSString *_imageName;
}

@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)resetButtonTapped:(id)sender;
- (IBAction)startButtonTapped:(id)sender;
- (IBAction)saveButtonTapped:(id)sender;


@end
