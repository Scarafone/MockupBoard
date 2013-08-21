//
//  CFPMainMenuViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPMainMenuViewController.h"
#import "CFPViewController.h"

@interface CFPMainMenuViewController ()

@end

@implementation CFPMainMenuViewController

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
    [_aMultiPaymentButtonNavi setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [_aRecentOrderButtonNavi setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    
    [_swipeRightGestureRecognizer setDelegate:self];
    [_swipeRightGestureRecognizer setEnabled:YES];
    
    [_aView addGestureRecognizer:_swipeRightGestureRecognizer];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressMultiPaymentNaviButton:(UIButton *)sender {
    NSLog(@"Pressed mutli payment navi button");
    UIStoryboard * multiOrders = [UIStoryboard storyboardWithName:@"MultipaymentStoryboard" bundle:[NSBundle mainBundle]];
    CFPViewController * vc = (CFPViewController*)[multiOrders instantiateInitialViewController];
    
    [vc configureCheckoutFlowForOrder:nil withState:NEW];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didPressRecentOrderButton:(UIButton *)sender {
    NSLog(@"Pressed recent order button");
    UIStoryboard * recentOrders = [UIStoryboard storyboardWithName:@"RecentOrdersStoryboard" bundle:[NSBundle mainBundle]];
    UIViewController * vc = [recentOrders instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didSwipeRight:(UISwipeGestureRecognizer *)sender {
//    NSLog(@"Swipped Right! %@",sender);
}


/* Gesture Recognizer */

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    NSLog(@"GESTURE : \n %@ \n %@",gestureRecognizer,touch);
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
//    NSLog(@"GESTURE : \n %@ \n %@",gestureRecognizer,otherGestureRecognizer);
    return YES;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    NSLog(@"GESTURE : \n %@",gestureRecognizer);
    return YES;
}


/* Touch Methods */


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Touch Began : \n %@,\n with event %@",touches,event);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Touch Moved :\n %@, \n with event %@",touches,event);
   /*
    UITouch * touch = (UITouch*)[[touches allObjects]lastObject];
    CGPoint point = [touch locationInView:self.view];
    
    CGRect frame = _aView.frame;
    point.x -= _aView.frame.size.width/2 + touch.view.frame.origin.x;
    point.y -= _aView.frame.size.height/2;
    
    frame.origin = point;
    
    
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //Animation
                         _aView.frame = frame;

                     } completion:^(BOOL finished) {
                         //Complete

                     }];
    */
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Touch Ended : \n %@, \n with event %@",touches,event);
    CGRect frame = _aView.frame;
    frame.origin = CGPointMake(0, 0);
    [_aView setFrame:frame];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touch Cancelled : \n %@, \n with event %@",touches,event);
}
@end
