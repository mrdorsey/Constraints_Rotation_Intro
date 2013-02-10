//
//  MRDTabBarController.m
//  Constraints_Rotation_Intro
//
//  Created by Michael Dorsey on 2/7/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDTabBarController.h"

@interface MRDTabBarController ()

@end

@implementation MRDTabBarController

- (BOOL)shouldAutorotate; {
	return YES;
}

- (NSUInteger)supportedInterfaceOrientations; {
	return UIInterfaceOrientationMaskAll;
}

@end
