//
//  MRDModalTransitionViewController.h
//  View_Controller_Intro
//
//  Created by Michael Dorsey on 1/26/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRDTransitionViewController.h"

@interface MRDModalTransitionViewController : UIViewController

@property (weak, nonatomic) NSString *transactionType;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;

- (IBAction)returnToParent:(id)sender;

@end
