//
//  MRDLayoutViewController.m
//  Constraints_Rotation_Intro
//
//  Created by Michael Dorsey on 2/1/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDLayoutViewController.h"

@interface MRDLayoutViewController ()

@property (nonatomic, strong) IBOutlet UILabel *portraitLbl;

@property (nonatomic, strong) IBOutlet UIView *redView;
@property (nonatomic, strong) IBOutlet UIView *whiteView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *portraitLabelHorizontalCenteringConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *portraitLabelVerticalCenteringConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *whiteViewEdgeAffinityConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *whiteViewAxisCenteringContraint; 

@end

@implementation MRDLayoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if(self != nil) {
		self.tabBarItem.title = @"HW2";
		UIImage* image = [UIImage imageNamed:@"04-squiggle.png"];
		self.tabBarItem.image = image;
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.redView.backgroundColor = [UIColor redColor];
	self.whiteView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated; {
	[super viewWillAppear:animated];
	
	[self _updatePortraitLabelToInterfaceOrientation:self.interfaceOrientation animated:animated withDuration:0.1];
	[self _updateWhiteViewConstraintsToInterfaceOrientation:self.interfaceOrientation animated:animated withDuration:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints; {
	[super updateViewConstraints];
	
	if(self.portraitLbl.superview != nil) {
		if(self.portraitLabelHorizontalCenteringConstraint == nil) {
			self.portraitLabelHorizontalCenteringConstraint = [NSLayoutConstraint
															   constraintWithItem:self.portraitLbl
															   attribute:NSLayoutAttributeCenterX
															   relatedBy:NSLayoutRelationEqual
															   toItem:self.redView
															   attribute:NSLayoutAttributeCenterX
															   multiplier:1.0f
															   constant:0.0f];
			[self.redView addConstraint:self.portraitLabelHorizontalCenteringConstraint];
		}
		
		if(self.portraitLabelVerticalCenteringConstraint == nil) {
			self.portraitLabelVerticalCenteringConstraint = [NSLayoutConstraint
															 constraintWithItem:self.portraitLbl
															 attribute:NSLayoutAttributeCenterY
															 relatedBy:NSLayoutRelationEqual
															 toItem:self.redView
															 attribute:NSLayoutAttributeCenterY
															 multiplier:1.0f
															 constant:0.0f];
			[self.redView addConstraint:self.portraitLabelVerticalCenteringConstraint];
		}
	}
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
		[self _updatePortraitLabelToInterfaceOrientation:toInterfaceOrientation animated:YES withDuration:duration];
	}
	
	[self _updateWhiteViewConstraintsToInterfaceOrientation:toInterfaceOrientation animated:YES withDuration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if(UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)) {
		[self _updatePortraitLabelToInterfaceOrientation:self.interfaceOrientation animated:YES withDuration:0.1];
	}
}

- (void)_updatePortraitLabelToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation animated:(BOOL)animated withDuration:(NSTimeInterval)duration; {
	
	if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
		[self.portraitLbl removeFromSuperview];
		
		if(self.portraitLabelHorizontalCenteringConstraint != nil && self.portraitLabelVerticalCenteringConstraint != nil) {
			[self.redView removeConstraints:@[self.portraitLabelHorizontalCenteringConstraint, self.portraitLabelVerticalCenteringConstraint]];
		}
		
		self.portraitLabelHorizontalCenteringConstraint = nil;
		self.portraitLabelVerticalCenteringConstraint = nil;
	}
	else {
		[self.redView addSubview:self.portraitLbl];
		[self.view setNeedsUpdateConstraints];
	}	
}

- (void)_updateWhiteViewConstraintsToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation animated:(BOOL)animated withDuration:(NSTimeInterval)duration; {
	
	if(self.whiteViewAxisCenteringContraint != nil) {
		[self.redView removeConstraint:self.whiteViewAxisCenteringContraint];
	}
	if(self.whiteViewEdgeAffinityConstraint != nil) {
		[self.redView removeConstraint:self.whiteViewEdgeAffinityConstraint];
	}

	self.whiteViewEdgeAffinityConstraint = [self _newEdgeAffinityConstraintForView:self.whiteView forOrientation:toInterfaceOrientation];
	self.whiteViewAxisCenteringContraint = [NSLayoutConstraint
											constraintWithItem:self.whiteView
											attribute:UIInterfaceOrientationIsPortrait(toInterfaceOrientation) ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY
											relatedBy:NSLayoutRelationEqual
											toItem:self.redView
											attribute:UIInterfaceOrientationIsPortrait(toInterfaceOrientation) ? NSLayoutAttributeCenterX : NSLayoutAttributeCenterY
											multiplier:1.0f
											constant:0.0f];
	[self.redView addConstraints:@[self.whiteViewAxisCenteringContraint, self.whiteViewEdgeAffinityConstraint]];
	
	if(animated) {
		[UIView animateWithDuration:duration
						 animations:^{
							 [self.redView layoutIfNeeded];
						 }];
	}
	else {
		[self.redView layoutIfNeeded];
	}
}

- (NSLayoutConstraint *)_newEdgeAffinityConstraintForView:(UIView *)view forOrientation:(UIInterfaceOrientation)orientation; {
	NSString *formatString = nil;
	switch(orientation) {
		case UIInterfaceOrientationPortrait: formatString = @"V:[view]-|"; break;
		case UIInterfaceOrientationLandscapeLeft: formatString = @"|-[view]"; break;
		case UIInterfaceOrientationLandscapeRight: formatString = @"[view]-|"; break;
		case UIInterfaceOrientationPortraitUpsideDown: formatString = @"V:|-[view]"; break;
		default: @throw [NSException exceptionWithName:@"UnknownOrientationException" reason:@"Unknown Fifth Orientation" userInfo:nil];
	}
	
	NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)];
	assert(constraints.count == 1);
	return constraints[0];
}

@end
