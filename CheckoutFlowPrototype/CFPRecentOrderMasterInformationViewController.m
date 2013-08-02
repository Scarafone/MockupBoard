//
//  CFPRecentOrderMasterInformationViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderMasterInformationViewController.h"

@interface CFPRecentOrderMasterInformationViewController () {
    CFPRecentOrderSummaryViewController * _summaryVC;
    CFPRecentOrderPaymentViewController * _paymentVC;
    CFPRecentOrderItemViewController    * _itemVC;
    CFPRecentOrderOptionsViewController * _optionsVC;
}

@end

@implementation CFPRecentOrderMasterInformationViewController

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
    
    [_roInformationScrollView setDelegate:self];
    
    _summaryVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryPage"];
    _paymentVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentPage"];
    _itemVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemPage"];
    _optionsVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"OptionsPage"];
    
    [self addChildViewController:_summaryVC];
    [self addChildViewController:_paymentVC];
    [self addChildViewController:_itemVC];
    [self addChildViewController:_optionsVC];
    
    [_roInformationScrollView addSubview:_summaryVC.view];
    [_roInformationScrollView addSubview:_paymentVC.view];
    [_roInformationScrollView addSubview:_itemVC.view];
    [_roInformationScrollView addSubview:_optionsVC.view];
    
    
    CGRect masterBounds = self.view.bounds;
    CGRect windowFrame = masterBounds;
    
    [_summaryVC.view setFrame:windowFrame];
    windowFrame.origin.x += 604;
    [_paymentVC.view setFrame:windowFrame];
    windowFrame.origin.x += 604;
    [_itemVC.view setFrame:windowFrame];
    windowFrame.origin.x += 604;
    [_optionsVC.view setFrame:windowFrame];
    
    [_roInformationScrollView setContentSize:CGSizeMake(604*4, 585)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
