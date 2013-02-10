//
//  MRDTransitionViewController.m
//  View_Controller_Intro
//
//  Created by Michael Dorsey on 1/26/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDModalTransitionViewController.h"
#import "MRDTransitionViewController.h"
#import "MRDViewControllerIntroConstants.h"

@interface MRDTransitionViewController ()

- (IBAction)showActionSheet:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *coverVerticalLbl;
@property (nonatomic, strong) IBOutlet UILabel *flipHorizontalLbl;
@property (nonatomic, strong) IBOutlet UILabel *crossDissolveLbl;
@property (nonatomic, strong) IBOutlet UILabel *partialCurlLbl;

@property (nonatomic, strong) NSMutableArray *portraitConstraints;
@property (nonatomic, strong) NSMutableArray *landscapeConstraints;

@property (nonatomic, assign) int coverVerticalCount;
@property (nonatomic, assign) int flipHorizontalCount;
@property (nonatomic, assign) int crossDissolveCount;
@property (nonatomic, assign) int partialCurlCount;
@property (nonatomic, strong) UIActionSheet *transitionSheet;

@property (nonatomic, strong) NSMutableArray *transitionLabels;

@end

@implementation MRDTransitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if(self != nil) {
		self.tabBarItem.title = @"HW1";
		UIImage* image = [UIImage imageNamed:@"03-loopback.png"];
		self.tabBarItem.image = image;
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor grayColor];
	
	[[self coverVerticalLbl] setText:[NSString stringWithFormat:@"%@%@%d", CoverVertical, @": ",0]];
	[[self flipHorizontalLbl] setText:[NSString stringWithFormat:@"%@%@%d", FlipHorizontal, @": ", 0]];
	[[self crossDissolveLbl] setText:[NSString stringWithFormat:@"%@%@%d", CrossDissolve, @": ", 0]];
	[[self partialCurlLbl] setText:[NSString stringWithFormat:@"%@%@%d", PartialCurl, @": ", 0]];
	
	if(self.transitionLabels == nil) {
		self.transitionLabels = [NSMutableArray array];
		[[self transitionLabels] addObject:[self coverVerticalLbl]];
		[[self transitionLabels] addObject:[self flipHorizontalLbl]];
		[[self transitionLabels] addObject:[self crossDissolveLbl]];
		[[self transitionLabels] addObject:[self partialCurlLbl]];
	}
	
	[self _removeInitialLabelConstraints];
}

- (void)viewWillAppear:(BOOL)animated; {
	[self _updateTransitionLabelConstraintsForOrientation:self.interfaceOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showActionSheet:(id)sender {
	UIActionSheet *transitionSheet = nil;
	transitionSheet = [[UIActionSheet alloc]
					   initWithTitle:@"Which Modal Transition Style?"
					   delegate: self
					   cancelButtonTitle:@"Cancel"
					   destructiveButtonTitle:@"Destroy"
					   otherButtonTitles:CoverVertical,
					   FlipHorizontal,
					   CrossDissolve,
					   PartialCurl,
					   nil];
	
	self.transitionSheet = transitionSheet;
	
	[transitionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	MRDModalTransitionViewController *modalController = [[MRDModalTransitionViewController alloc] init];
	
	switch (buttonIndex) {
        case 0:
		{
			UIAlertView *alert = [[UIAlertView alloc]
								  initWithTitle:@"Really Destroy?"
								  message:@"This will destroy everything."
								  delegate:self
								  cancelButtonTitle:nil
								  otherButtonTitles:@"Yes", @"No", nil];
			[alert show];
			break;
		}
		// TODO: eliminate code reuse here
        case 1:
            [modalController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
			modalController.transactionType = CoverVertical;
			[self presentViewController:modalController animated:YES completion:nil];
			self.coverVerticalCount++;
			[[self coverVerticalLbl] setText:[NSString stringWithFormat:@"%@%@%d", CoverVertical, @": ", [self coverVerticalCount]]];
            break;
        case 2:
			[modalController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
			modalController.transactionType = FlipHorizontal;
			[self presentViewController:modalController animated:YES completion:nil];
			self.flipHorizontalCount++;
			[[self flipHorizontalLbl] setText:[NSString stringWithFormat:@"%@%@%d", FlipHorizontal, @": ", [self flipHorizontalCount]]];
            break;
		case 3:
            [modalController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
			modalController.transactionType = CrossDissolve;
			[self presentViewController:modalController animated:YES completion:nil];
			self.crossDissolveCount++;
			[[self crossDissolveLbl] setText:[NSString stringWithFormat:@"%@%@%d", CrossDissolve, @": ", [self crossDissolveCount]]];
            break;
		case 4:
            [modalController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
			modalController.transactionType = PartialCurl;
			[self presentViewController:modalController animated:YES completion:nil];
			self.partialCurlCount++;
			[[self partialCurlLbl] setText:[NSString stringWithFormat:@"%@%@%d", PartialCurl, @": ", [self partialCurlCount]]];
            break;
		case 5:
			[actionSheet dismissWithClickedButtonIndex:actionSheet.cancelButtonIndex animated:YES];
			break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		self.view.backgroundColor = [UIColor redColor];
	}
	else {
		self.view.backgroundColor = [UIColor lightGrayColor];
	}
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self _updateTransitionLabelConstraintsForOrientation:toInterfaceOrientation];
	
	[self.view setNeedsUpdateConstraints];
	[UIView animateWithDuration:duration animations:^{
		[self.view layoutIfNeeded];
	}];
}

#pragma mark helpers

- (void)_removeInitialLabelConstraints; {
	NSMutableArray *labelConstraints = [NSMutableArray array];
	for(NSLayoutConstraint *constraint in self.view.constraints) {
		if([self.transitionLabels containsObject:constraint.firstItem] || [self.transitionLabels containsObject:constraint.secondItem]) {
			[labelConstraints addObject:constraint];
		}
	}
	
	[self.view removeConstraints:labelConstraints];
	
	if(UIInterfaceOrientationIsPortrait([self interfaceOrientation])) {
		[self _constructPortraitConstraints];
		[self.view addConstraints:self.portraitConstraints];
	}
	else if(UIInterfaceOrientationIsLandscape([self interfaceOrientation])) {
		[self _constructLandscapeConstraints];
		[self.view addConstraints:self.landscapeConstraints];
	}
		
	[self.view setNeedsUpdateConstraints];
}

- (void)_updateTransitionLabelConstraintsForOrientation:(UIInterfaceOrientation)orientation; {
	if(UIInterfaceOrientationIsPortrait(orientation)) {
		[self _constructPortraitConstraints];
		if(self.landscapeConstraints != nil) {
			[self.view removeConstraints:self.landscapeConstraints];
		}
		[self.view addConstraints:self.portraitConstraints];
	}
	else if(UIInterfaceOrientationIsLandscape(orientation)) {
		[self _constructLandscapeConstraints];
		if(self.portraitConstraints != nil) {
			[self.view removeConstraints:self.portraitConstraints];
		}
		[self.view addConstraints:self.landscapeConstraints];
	}
}

- (void)_constructPortraitConstraints; {
	
	if(self.portraitConstraints != nil)
		return;
	
	self.portraitConstraints = [NSMutableArray array];
	
	for(NSUInteger idx = 0; idx < self.transitionLabels.count; idx++) {
		UILabel *label = self.transitionLabels[idx];
		
		// Add vertical constraint(s)
		if(idx == self.transitionLabels.count - 1) {
			[self.portraitConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
		}
		else {
			UILabel *nextLabel = self.transitionLabels[idx + 1];
			[self.portraitConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-[nextLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label, nextLabel)]];
		}
			
		// Add horizontal Constraint(s)
		[self.portraitConstraints addObjectsFromArray:[NSLayoutConstraint
													   constraintsWithVisualFormat:@"|-[label]-|"
													   options:0
													   metrics:nil
													   views:NSDictionaryOfVariableBindings(label)]];
	}
}

- (void)_constructLandscapeConstraints; {
	
	if(self.landscapeConstraints != nil)
		return;
	
	assert(self.transitionLabels.count == 4);
	
	self.landscapeConstraints = [NSMutableArray array];
	
	for(NSUInteger idx = 0; idx < 4; idx += 2) {
		UILabel *firstLabel = self.transitionLabels[idx];
		UILabel *secondLabel = self.transitionLabels[idx + 1];
		
		[self.landscapeConstraints addObjectsFromArray:[NSLayoutConstraint
														constraintsWithVisualFormat:@"|-[firstLabel][secondLabel]-|"
														options:0
														metrics:nil
														views:NSDictionaryOfVariableBindings(firstLabel, secondLabel)]];
		
		[self.landscapeConstraints addObject:[NSLayoutConstraint constraintWithItem:firstLabel
																		  attribute:NSLayoutAttributeWidth
																		  relatedBy:NSLayoutRelationEqual
																			 toItem:secondLabel
																		  attribute:NSLayoutAttributeWidth multiplier:1.0f
																		   constant:0.0f]];
	}
	
	for(NSUInteger idx = 0; idx < 2; idx++) {
		UILabel *firstLabel = self.transitionLabels[idx];
		UILabel *secondLabel = self.transitionLabels[idx + 2];
		
		[self.landscapeConstraints addObjectsFromArray:[NSLayoutConstraint
														constraintsWithVisualFormat:@"V:[firstLabel]-[secondLabel]-|"
														options:0
														metrics:nil
														views:NSDictionaryOfVariableBindings(firstLabel, secondLabel)]];
	}
}

@end
