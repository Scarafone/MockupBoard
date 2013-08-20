//
//  CFPAddPaymentViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPAddPaymentViewController.h"

@interface CFPAddPaymentViewController ()

@end

@implementation CFPAddPaymentViewController

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
    
    //setup buttons    
    [_aAddPayButton setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [_aAddPayButton setBackgroundImage:[[UIImage imageNamed:@"addPayment-button(active).png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateSelected];
    
    [_aQuickSplitButton setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [_aQuickSplitButton setBackgroundImage:[[UIImage imageNamed:@"addPayment-button(active).png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressAddPaymentButton:(UIButton *)sender {
    [_delegate didPressAddPaymentButton:sender];
}

- (IBAction)didPressSplitPaymentButton:(UIButton *)sender {
    [_delegate didPressSplitPaymentButton:sender];
}
@end
