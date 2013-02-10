//
//  MRDModalTransitionViewController.m
//  Constraints_Rotation_Intro
//
//  Created by Michael Dorsey on 2/1/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDModalTransitionViewController.h"

@interface MRDModalTransitionViewController ()

@end

@implementation MRDModalTransitionViewController

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
	self.view.backgroundColor = [UIColor lightGrayColor];
	
	[[self dismissBtn]
	 setTitle:[NSString stringWithFormat:@"%@%@", @"Dismisss ", [self transactionType]]
	 forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToParent:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
