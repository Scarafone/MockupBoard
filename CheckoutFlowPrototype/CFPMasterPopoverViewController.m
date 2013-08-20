//
//  CFPMasterPopoverViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/6/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPMasterPopoverViewController.h"

@interface CFPMasterPopoverViewController ()

@end

@implementation CFPMasterPopoverViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressCancelButton:(UIButton *)sender {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
@end
