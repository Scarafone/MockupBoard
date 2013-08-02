//
//  CFPAddPaymentViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CFPAddPaymentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *aAddPayButton;
@property (weak, nonatomic) IBOutlet UIButton *aQuickSplitButton;


- (IBAction)didPressAddPaymentButton:(UIButton *)sender;
- (IBAction)didPressSplitPaymentButton:(UIButton *)sender;

@end
