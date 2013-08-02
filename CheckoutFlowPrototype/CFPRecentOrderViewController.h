//
//  CFPRecentOrderViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/31/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NONE = 100,
    SUMMARY = 101,
    PAYMENTS = 102,
    ITEMS = 103,
    OPTIONS = 104
}TAB_GROUP_BUTTON;



@interface CFPRecentOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *roTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *roScrollView;
@property (weak, nonatomic) IBOutlet UIView *roContainerView;

//Tab Group
@property (weak, nonatomic) IBOutlet UIView *roTabGroupButtonView;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupSummaryButton;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupPaymentsButton;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupItemsButton;
@property (weak, nonatomic) IBOutlet UIButton *roTabGroupOptionsButton;
@property (weak, nonatomic) IBOutlet UIImageView *roTabGroupSelectionArrow;

- (IBAction)roDidPressTabGroupButton:(UIButton *)sender;

//Navigation Filters
@property (weak, nonatomic) IBOutlet UIButton *roNaviGroupOpenOrders;
@property (weak, nonatomic) IBOutlet UIButton *roNaviGroupCompletedOrders;
@property (weak, nonatomic) IBOutlet UIButton *roNaviGroupAllOrders;
- (IBAction)roDidPressNaviGroupButton:(UIButton *)sender;


- (IBAction)didPressHomeButton:(UIButton *)sender;

@end
