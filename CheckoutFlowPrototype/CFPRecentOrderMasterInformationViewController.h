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

@interface CFPRecentOrderMasterInformationViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *roInformationScrollView;


@end
