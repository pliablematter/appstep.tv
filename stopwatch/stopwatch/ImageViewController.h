//
//  ImageViewController.h
//  stopwatch
//
//  Created by Doug Burns on 1/29/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;

@end
