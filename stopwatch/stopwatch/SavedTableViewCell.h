//
//  SavedTableViewCell.h
//  stopwatch
//
//  Created by Doug Burns on 1/28/14.
//  Copyright (c) 2014 Pliable Matter LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;

@end
