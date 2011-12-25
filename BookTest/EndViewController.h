//
//  EndViewController.h
//  BookTest
//
//  Created by Omar Qazi on 12/25/11.
//  Copyright (c) 2011 Hello Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"

@interface EndViewController : UIViewController
- (IBAction)readAgain:(id)sender;
@property (strong, nonatomic) ModelController *modelController;
@end
