//
//  DataViewController.m
//  BookTest
//
//  Created by Omar Qazi on 12/24/11.
//  Copyright (c) 2011 Hello Galaxy. All rights reserved.
//

#import "DataViewController.h"

@implementation DataViewController

@synthesize imageView;
@synthesize dataObject = _dataObject;
@synthesize scrollView;
@synthesize pageText;
@synthesize label;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    imageView.image = [UIImage imageNamed:self.dataObject];
    textSets = [pageText componentsSeparatedByString:@"\n"];
    currentSet = 0;
    label.text = [textSets objectAtIndex:currentSet];
    if ([self.dataObject isEqualToString:@"cover.png"]) {
        [scrollView setHidden:YES];
        currentSet = 1;
    }
}


//This method returns no if there's nowhere to advance to
- (BOOL)nextSet {
    currentSet++;
    if (currentSet >= [textSets count]) {
        currentSet = ([textSets count] - 1);
        return NO;
    }
    [UIView animateWithDuration:0.125 animations:^{
        [label setCenter:CGPointMake(label.center.x - 500,label.center.y)];
    } completion:^(BOOL suc) {
        label.text = [textSets objectAtIndex:currentSet];
        [label setCenter:CGPointMake(label.center.x + 1500,label.center.y)];
        [UIView animateWithDuration:0.125 animations:^{
            [label setCenter:CGPointMake(label.center.x - 1000,label.center.y)];
        }];
    }];
    return YES;
}

- (BOOL)lastSet {
    currentSet--;
    if (currentSet <= -1) {
        currentSet = 0;
        return NO;
    }
    [UIView animateWithDuration:0.125 animations:^{
        [label setCenter:CGPointMake(label.center.x + 1000,label.center.y)];
    } completion:^(BOOL suc) {
        label.text = [textSets objectAtIndex:currentSet];
        [label setCenter:CGPointMake(label.center.x - 1500,label.center.y)];
        [UIView animateWithDuration:0.125 animations:^{
            [label setCenter:CGPointMake(label.center.x + 500,label.center.y)];
        }];
    }];

    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
