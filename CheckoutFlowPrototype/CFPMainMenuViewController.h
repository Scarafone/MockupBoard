//
//  CFPMainMenuViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPMainMenuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *aMultiPaymentButtonNavi;
@property (weak, nonatomic) IBOutlet UIButton *aRecentOrderButtonNavi;

- (IBAction)didPressMultiPaymentNaviButton:(UIButton *)sender;

- (IBAction)didPressRecentOrderButton:(UIButton *)sender;

@end
