//
//  CFPMainMenuViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/30/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPMainMenuViewController.h"
#import "CFPViewController.h"
#import "OrderMaster.h"

@implementation LoginClass

@end

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
    
    self.managedObjectContext = [RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext;
	// Do any additional setup after loading the view.
    [_aMultiPaymentButtonNavi setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    [_aRecentOrderButtonNavi setBackgroundImage:[[UIImage imageNamed:@"addPayment-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
    
    [_swipeRightGestureRecognizer setDelegate:self];
    [_swipeRightGestureRecognizer setEnabled:YES];
    
    [_aView addGestureRecognizer:_swipeRightGestureRecognizer];
    
    [self loginToServer];

}


-(void)loginToServer{

    
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"data"    :   @"token",
     @"endpoint":   @"endpoint",
     @"success" :   @"success"
     }];
    
    
    RKRequestDescriptor * requestDescriptor  = [RKRequestDescriptor requestDescriptorWithMapping:mapping objectClass:[LoginClass class] rootKeyPath:nil method:RKRequestMethodGET];
    RKResponseDescriptor * responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:@"rest.svc/api/login" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager]addRequestDescriptor:requestDescriptor];
    [[RKObjectManager sharedManager]addResponseDescriptor:responseDescriptor];
    
    [[[RKObjectManager sharedManager]HTTPClient]setDefaultHeader:@"x-cube-email" value:@"mfalco@getcube.com"];
    [[[RKObjectManager sharedManager]HTTPClient]setDefaultHeader:@"x-cube-password" value:@"whiskey"];
    
    [[RKObjectManager sharedManager]getObject:nil path:@"rest.svc/api/login" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Success
        
        NSLog(@"Success Login :%@ ",[mappingResult firstObject]);
        NSDictionary * results = [mappingResult firstObject];
        LoginClass * login = [LoginClass new];
        
        @try {
            [login setValuesForKeysWithDictionary:results];
        }
        @catch (NSException *exception) {
            NSLog(@"Unable to set login class with information");
        }
        @finally {
            //Finally
        }

        
        AFHTTPClient * client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:login.endpoint]];
        [RKObjectManager sharedManager].HTTPClient = client;
        
        [[[RKObjectManager sharedManager]HTTPClient]setDefaultHeader:@"x-cube-token" value:login.token];
        
        for(RKResponseDescriptor * response in  [RKObjectManager sharedManager].responseDescriptors){
            response.baseURL  = [NSURL URLWithString:login.endpoint];
        }
     
    
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //Fail
        NSLog(@"Failed Request :%@",error);
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"Failed Login" message:@"Unable to login please check the informationa and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }];
    

    
}

-(NSArray*)getOrderSummaryObjects{
    

   
    
//    RKResponseDescriptor * responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping method:RKRequestMethodGET pathPattern:@"/rest.svc/API/order_master" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    responseDescriptor.baseURL = [RKObjectManager sharedManager].baseURL; 
    
//    [[RKObjectManager sharedManager]addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager]getObjectsAtPath:@"/rest.svc/API/order_master" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Success
        NSLog(@"Mapping Results : %@",mappingResult);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //Fail
    }];
    
    return nil;
}


- (NSFetchedResultsController*)fetchedResultsController{
    return _fetchedResultsController;
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
