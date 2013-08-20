//
//  CFPAddPaymentViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPAddPaymentProtocol <NSObject>
@required
-(void)didPressAddPaymentButton:(UIButton*)sender;
-(void)didPressSplitPaymentButton:(UIButton*)sender;

@end

@interface CFPAddPaymentViewController : UIViewController


@property (weak, nonatomic) id <SPAddPaymentProtocol> delegate;

@property (weak, nonatomic) IBOutlet UIButton *aAddPayButton;
@property (weak, nonatomic) IBOutlet UIButton *aQuickSplitButton;


- (IBAction)didPressAddPaymentButton:(UIButton *)sender;
- (IBAction)didPressSplitPaymentButton:(UIButton *)sender;

@end
