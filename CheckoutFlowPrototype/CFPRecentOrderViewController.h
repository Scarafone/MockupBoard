//
//  CFPRecentOrderViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/31/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFPRecentOrderMasterInformationViewController.h"



typedef enum
{
    NAVI_HOME               = 50,
    NAVI_OPEN_ORDERS        = 51,
    NAVI_COMPLETED_ORDERS   = 52,
    NAVI_ALL_ORDERS         = 53
    
}NAVIGATION_BUTTONS;

@interface CFPRecentOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *roTableView;
@property (weak, nonatomic) IBOutlet UIView *roContainerView;
@property (weak, nonatomic) IBOutlet UILabel *roOrderTitleLabel;


//Navigation Filters
@property (weak, nonatomic) IBOutlet UIButton *roNaviGroupOpenOrders;
@property (weak, nonatomic) IBOutlet UIButton *roNaviGroupCompletedOrders;
@property (weak, nonatomic) IBOutlet UIButton *roNaviGroupAllOrders;

- (IBAction)roDidPressNaviGroupButton:(UIButton *)sender;
- (IBAction)didPressHomeButton:(UIButton *)sender;

@end


@interface OrderDetailClass : NSObject

@property (nonatomic, copy) NSDictionary * data;
@property (nonatomic, copy) NSString * success;

@end