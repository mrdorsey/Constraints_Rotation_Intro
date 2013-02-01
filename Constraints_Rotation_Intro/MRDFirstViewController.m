//
//  MRDFirstViewController.m
//  Constraints_Rotation_Intro
//
//  Created by Michael Dorsey on 2/1/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDFirstViewController.h"

@interface MRDFirstViewController ()

@end

@implementation MRDFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"First", @"First");
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
