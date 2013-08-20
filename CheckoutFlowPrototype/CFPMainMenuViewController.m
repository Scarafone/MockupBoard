//
//  CFPMainMenuViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPMainMenuViewController.h"
#import "CFPViewController.h"

@interface CFPMainMenuViewController ()

@end

@implementation CFPMainMenuViewController

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
    [_aMultiPaymentButtonNavi setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [_aRecentOrderButtonNavi setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressMultiPaymentNaviButton:(UIButton *)sender {
    NSLog(@"Pressed mutli payment navi button");
    UIStoryboard * multiOrders = [UIStoryboard storyboardWithName:@"MultipaymentStoryboard" bundle:[NSBundle mainBundle]];
    CFPViewController * vc = (CFPViewController*)[multiOrders instantiateInitialViewController];
    
    [vc configureCheckoutFlowForOrder:nil withState:NEW];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didPressRecentOrderButton:(UIButton *)sender {
    NSLog(@"Pressed recent order button");
    UIStoryboard * recentOrders = [UIStoryboard storyboardWithName:@"RecentOrdersStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController * vc = [recentOrders instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
