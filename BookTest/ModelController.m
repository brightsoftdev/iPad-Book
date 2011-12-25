//
//  ModelController.m
//  BookTest
//
//  Created by Omar Qazi on 12/24/11.
//  Copyright (c) 2011 Hello Galaxy. All rights reserved.
//

#import "ModelController.h"

#import "DataViewController.h"
#import "EndViewController.h"
/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@property (readonly, strong, nonatomic) NSArray *pageText;
@end

@implementation ModelController

@synthesize pageData = _pageData;
@synthesize pageText = _pageText;

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        _pageData = [NSArray arrayWithObjects:@"cover.png",@"p1-RGB.jpg",@"p2-RGB.jpg",@"p3-RGB.jpg",@"p4-RGB.jpg",@"p5-RGB.jpg",@"p6-RGB.jpg",@"p7-RGB.jpg",@"p8-RGB.jpg",@"p9-RGB.jpg",@"theend.png",nil];
        NSString *manifestPath = [[NSBundle mainBundle]pathForResource:@"SugarBug" ofType:@"manifest"];
        NSString *rawText = [NSString stringWithContentsOfFile:manifestPath encoding:NSUTF8StringEncoding error:nil];
        _pageText = [rawText componentsSeparatedByString:@"\nPPP\n"];
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    
    if (index == ([self.pageData count] - 1)) {
        EndViewController  *endViewController = [storyboard instantiateViewControllerWithIdentifier:@"EndViewController"];
        endViewController.modelController = self;
        return endViewController;
    }
    
    //Or if we're not at the end
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = [self.pageData objectAtIndex:index];
    dataViewController.pageText = [self.pageText objectAtIndex:index];
    return dataViewController;
}

- (void)startOver {
    [pageViewController performSelector:@selector(_handleTapGesture:) withObject:nil];
    
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{   
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)lpageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([(DataViewController *)viewController lastSet]) {
        return nil; //If we're not done with all the text on this page, don't go back
    }
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)lpageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([(DataViewController *)viewController nextSet]) {
        return nil; //If we're not done with all the text on this page, don't advance
    }
    
    pageViewController = lpageViewController;
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return [self viewControllerAtIndex:0 storyboard:viewController.storyboard];
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
