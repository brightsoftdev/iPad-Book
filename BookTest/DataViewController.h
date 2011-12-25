//
//  DataViewController.h
//  BookTest
//
//  Created by Omar Qazi on 12/24/11.
//  Copyright (c) 2011 Hello Galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController {
    NSArray *textSets;
    NSInteger currentSet;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic) NSString *pageText;
- (BOOL)nextSet;
- (BOOL)lastSet;
@end
