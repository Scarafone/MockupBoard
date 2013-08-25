//
//  CFPMainMenuViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPMainMenuViewController : UIViewController <UIGestureRecognizerDelegate,NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UIButton *aMultiPaymentButtonNavi;
@property (weak, nonatomic) IBOutlet UIButton *aRecentOrderButtonNavi;
@property (weak, nonatomic) IBOutlet UIImageView *aImage;
@property (weak, nonatomic) IBOutlet UIView *aView;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRightGestureRecognizer;


- (IBAction)didPressMultiPaymentNaviButton:(UIButton *)sender;
- (IBAction)didPressRecentOrderButton:(UIButton *)sender;
- (IBAction)didSwipeRight:(UISwipeGestureRecognizer *)sender;

@end

@interface LoginClass : NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *endpoint;
@property (nonatomic, copy) NSNumber *success;

@end