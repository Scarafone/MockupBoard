//
//  CFPRecentOrderMasterInformationViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFPRecentOrderSummaryViewController.h"
#import "CFPRecentOrderPaymentViewController.h"
#import "CFPRecentOrderItemViewController.h"
#import "CFPRecentOrderOptionsViewController.h"

typedef enum {
    NONE = 100,
    SUMMARY = 101,
    PAYMENTS = 102,
    ITEMS = 103,
    OPTIONS = 104
}TAB_GROUP_BUTTON;

@interface CFPRecentOrderMasterInformationViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *roInformationScrollView;

//Tab Group
@property (weak, nonatomic) IBOutlet UIView *roTabGroupButtonView;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupSummaryButton;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupPaymentsButton;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupItemsButton;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupOptionsButton;
@property (weak, nonatomic) IBOutlet UIImageView *roTabGroupSelectionArrow;

- (IBAction)roDidPressTabGroupButton:(UIButton *)sender;


- (void)shouldShowTabButtonGroup:(BOOL)shouldShow;
- (void)setOrderObject:(id)orderObject;

@end
