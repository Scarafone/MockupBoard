//
//  CFPViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/23/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFPAddPaymentViewController.h"
#import "CFPMasterPopoverViewController.h"

typedef enum {
    NONE,       //Blank state safe mode
    NEW,        //Initial state, first entrance
    LOAD,       //Saved order payments already
    EDITING,    //Currently modifiying the payments
    COMPLETE    //After all payments are complete
}CFFlowState;


@interface CFPViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,SPAddPaymentProtocol>

//Properties
@property (weak, nonatomic) IBOutlet UITableView *cfPaymentTableView;
@property (weak, nonatomic) IBOutlet UIView *cfAddPaymentContainer;
@property (weak, nonatomic) IBOutlet UIView *cfAmountDueContainer;
@property (weak, nonatomic) IBOutlet UILabel *cfTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *cfMasterTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cfCancelButton;

- (IBAction)didPressCancelPaymentButton:(UIButton *)sender;

- (IBAction)pressedMe:(UIButton *)sender;
- (IBAction)noPressedMe:(UIButton *)sender;


//Instance Methods
- (void) configureCheckoutFlowForOrder:(id)orderObject withState:(CFFlowState)state;



@end


