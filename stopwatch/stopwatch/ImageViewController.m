//
//  ImageViewController.m
//  stopwatch
//
//  Created by Doug Burns on 1/26/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

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

- (void) viewWillAppear:(BOOL)animated
{
    self.imageView.image = self.image;
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
    NSLog(@"imageWidth %f", self.image.size.width);
    NSLog(@"imageViewWidth %f", self.imageView.image.size.width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
