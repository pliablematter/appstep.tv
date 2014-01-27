//
//  ImageViewController.h
//  stopwatch
//
//  Created by Doug Burns on 1/26/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
