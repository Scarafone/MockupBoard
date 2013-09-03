//
//  CFPSummaryCollectionViewCell.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/26/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPSummaryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderMasterID;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *ticketNumber;
@property (weak, nonatomic) IBOutlet UILabel *created;
@property (weak, nonatomic) IBOutlet UILabel *employeeName;
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPayments;
@property (weak, nonatomic) IBOutlet UILabel *numberOfItems;
@property (weak, nonatomic) IBOutlet UILabel *subtotal;
@property (weak, nonatomic) IBOutlet UILabel *discounts;
@property (weak, nonatomic) IBOutlet UILabel *tax;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *tips;
@property (weak, nonatomic) IBOutlet UITextView *notes;

@property (weak, nonatomic) IBOutlet UIButton *editOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *checkoutOrderButton;

- (void) shouldShowOptions:(BOOL)shouldShow;

@end
