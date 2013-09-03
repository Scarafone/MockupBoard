//
//  CFPRecentOrderMasterInformationViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderMasterInformationViewController.h"
#import "CFPRecentOrderViewController.h"

@interface CFPRecentOrderMasterInformationViewController () {
    CFPRecentOrderSummaryViewController * _summaryVC;
    CFPRecentOrderPaymentViewController * _paymentVC;
    CFPRecentOrderItemViewController    * _itemVC;
    CFPRecentOrderOptionsViewController * _optionsVC;


}

@property (strong, nonatomic) OrderDetailClass * orderDetail;

@end

@implementation CFPRecentOrderMasterInformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_roInformationScrollView setDelegate:self];
    
    _summaryVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"SummaryPage"];
    _paymentVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentPage"];
    _itemVC     = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemPage"];
    _optionsVC  = [self.storyboard instantiateViewControllerWithIdentifier:@"OptionsPage"];
    
    [self addChildViewController:_summaryVC];
    [self addChildViewController:_paymentVC];
    [self addChildViewController:_itemVC];
    [self addChildViewController:_optionsVC];
    
    [_roInformationScrollView addSubview:_summaryVC.view];
    [_roInformationScrollView addSubview:_paymentVC.view];
    [_roInformationScrollView addSubview:_itemVC.view];
    [_roInformationScrollView addSubview:_optionsVC.view];
    
    
    CGRect masterBounds = self.view.bounds;
    CGRect windowFrame = masterBounds;
    
    [_summaryVC.view setFrame:windowFrame];
    windowFrame.origin.x += 600;
    [_paymentVC.view setFrame:windowFrame];
    windowFrame.origin.x += 600;
    [_itemVC.view setFrame:windowFrame];
    windowFrame.origin.x += 600;
    [_optionsVC.view setFrame:windowFrame];
    
    [_roInformationScrollView setContentSize:CGSizeMake(600*4, 585)];
    
    [self shouldShowTabButtonGroup:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self updateTabButtonSelected:_roTabGroupSelectionArrow.frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Tab Group Methods */
-(IBAction)roDidPressTabGroupButton:(UIButton *)sender{
//    NSLog(@"Did press tab button %@",sender);
    CGPoint scrollPoint;
    scrollPoint.x = 600 * (sender.tag - 1);
    
    [_roInformationScrollView setContentOffset:scrollPoint animated:YES];
}

/* Show / Hide Scroll View */
- (void)shouldShowTabButtonGroup:(BOOL)shouldShow{
    //Yes = should be showing
    //No = should be hiding
    CGRect animationFrame = _roTabGroupButtonView.frame;
    if(shouldShow){
        animationFrame.origin.y = 0;
    } else {
        animationFrame.origin.y = -100;
    }
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //Animation
                         _roTabGroupButtonView.frame = animationFrame;
                     } completion:^(BOOL finished) {
                         //Complete
                     }];
}


/* Scroll View Delegate Methods */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateAndAnimateArrowForScrollView:scrollView];
    //Check for button updates
}

- (void)updateAndAnimateArrowForScrollView:(UIScrollView*)scrollView{
    
    
    CGRect animationFrame = _roTabGroupSelectionArrow.frame;
    
    animationFrame.origin.x =  fmodf(scrollView.contentOffset.x/4, _roTabGroupButtonView.frame.size.width) + _roTabGroupSummaryButton.frame.size.width/2 - _roTabGroupSelectionArrow.frame.size.width/2;
    
    [UIView animateWithDuration:0.1
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //Animation
                         if(animationFrame.origin.x > 0 && animationFrame.origin.x < (_roInformationScrollView.frame.size.width - _roTabGroupSelectionArrow.frame.size.width) ){
                             _roTabGroupSelectionArrow.frame = animationFrame;
                         }
                         
                     } completion:^(BOOL finished) {
                         //Completion
                            [self updateTabButtonSelected:animationFrame];
                     }];
    

}

- (void)updateTabButtonSelected:(CGRect)animationFrame{
    CGPoint checkPoint = animationFrame.origin;
    
    if(checkPoint.x > _roTabGroupSummaryButton.frame.origin.x && checkPoint.x <
       (_roTabGroupSummaryButton.frame.origin.x + _roTabGroupSummaryButton.frame.size.width)){
        //Arrow is within the button should be selected
        [_roTabGroupSummaryButton setSelected:YES];
    } else {
        [_roTabGroupSummaryButton setSelected:NO];
    }
    
    if(checkPoint.x > _roTabGroupPaymentsButton.frame.origin.x && checkPoint.x <
       (_roTabGroupPaymentsButton.frame.origin.x + _roTabGroupPaymentsButton.frame.size.width)){
        //Arrow is within the button should be selected
        [_roTabGroupPaymentsButton setSelected:YES];
    } else {
        [_roTabGroupPaymentsButton setSelected:NO];
    }
    
    if(checkPoint.x > _roTabGroupItemsButton.frame.origin.x && checkPoint.x <
       (_roTabGroupItemsButton.frame.origin.x + _roTabGroupItemsButton.frame.size.width)){
        //Arrow is within the button should be selected
        [_roTabGroupItemsButton setSelected:YES];
    } else {
        [_roTabGroupItemsButton setSelected:NO];
    }
    
    if(checkPoint.x > _roTabGroupOptionsButton.frame.origin.x && checkPoint.x <
       (_roTabGroupOptionsButton.frame.origin.x + _roTabGroupOptionsButton.frame.size.width)){
        //Arrow is within the button should be selected
        [_roTabGroupOptionsButton setSelected:YES];
    } else {
        [_roTabGroupOptionsButton setSelected:NO];
    }
    
    
    
}

- (void) setOrderObject:(OrderDetailClass*)orderObject{
    if(!orderObject){
        NSLog(@"No Object Present!");
    } else {
        NSLog(@"Order Object : %@",orderObject);
        [self setOrderDetailForChildViews:orderObject];
        [_roInformationScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


- (void) setOrderDetailForChildViews:(OrderDetailClass*)orderDetail{
    
    if(!orderDetail){
        NSLog(@"There has been a problem!");
        return;
    }
    [_summaryVC setDataForCollection:[orderDetail.data valueForKey:@"report_detail"]];
    

}

@end
