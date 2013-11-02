//
//  DetailViewController.h
//  stopwatch
//
//  Created by Doug Burns on 11/2/13.
//  Copyright (c) 2013 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
