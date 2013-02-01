//
//  MRDSecondViewController.m
//  Constraints_Rotation_Intro
//
//  Created by Michael Dorsey on 2/1/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDSecondViewController.h"

@interface MRDSecondViewController ()

@end

@implementation MRDSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"Second", @"Second");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
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
