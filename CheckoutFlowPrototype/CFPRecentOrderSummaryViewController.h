//
//  CFPRecentOrderSummaryViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPRecentOrderSummaryViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *roSummaryCollectionView;



/*
 
 Labels 
 
 101 - OrderMasterIDLabel
 102 - Order State Label
 103 - Ticket Number
 104 - Created Date
 105 - Employee Name (Full)
 106 - Customer Name (Full)
 107 - Number of Payments
 108 - Number of Items
 109 - Subtotal Label
 110 - Discount Label
 111 - Tax Label
 112 - Total Label
 113 - Order Notes

 Buttons
 
 121 - Edit Order Button
 122 - Checkout Order Button
 */

- (void) setDataForCollection:(NSArray*)data;

@end
