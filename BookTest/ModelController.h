//
//  ModelController.h
//  BookTest
//
//  Created by Omar Qazi on 12/24/11.
//  Copyright (c) 2011 Hello Galaxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource> {
    UIPageViewController *pageViewController;
}
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
- (void)startOver;
@end
