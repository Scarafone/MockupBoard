//
//  CFPViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/23/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPViewController.h"
 
@interface CFPViewController () {
    
    CFFlowState   _currentState;
    id            _orderObject;
}

@end

@implementation CFPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [_cfPaymentTableView setDelegate:self];
    [_cfPaymentTableView setDataSource:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateForCurrentState:_currentState];
}

- (void)configureCheckoutFlowForOrder:(id)orderObject withState:(CFFlowState )state{
    
    if(!orderObject){
        NSLog(@"This will spit you back in the future");
    }
    //Will take in order object with all items, payments and anything else i may need.
    _orderObject = orderObject;
    _currentState = state; //Set the current state which is set outside and passed in as needed and will be updated by user actions
    
    [self updateForCurrentState:_currentState];
}

/* State Checking and Handling */

- (void)updateForCurrentState:(CFFlowState)state{

    
    switch (state) {
        case NEW:
        {
            /* Fresh in the payment flow no payments created*/
            
            /* Things that need to happen 
             * - Add button and split button need to moved into place(done)
             * - Table view needs to be hidden(done)
             */
            
            CGRect tableFrame = _cfPaymentTableView.bounds;
            
            [_cfAddPaymentContainer setFrame:CGRectMake(tableFrame.origin.x, tableFrame.origin.y, _cfAddPaymentContainer.frame.size.width, _cfAddPaymentContainer.frame.size.height)];
            
            [_cfPaymentTableView setHidden:YES];
            [_cfPaymentTableView setUserInteractionEnabled:!_cfPaymentTableView.hidden];
            break;
        }
        case LOAD:
        {
            /* Will be the state that comes from a saved order with payments likely already split or attached */
            break;
        }
        case EDITING:
        {
            /* is the state the flow uses during and activity provided by the user outside of simply loading in or starting anew */
            break;
        }
        default:
        {
            NSLog(@"Choosing NONE or not selecting one of the options will default the state to a new blank state, which will likely turn in a return from multiple payments with a 1 for failure");
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Kicking it" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            break;
        }
    }
    
    
    
}

/* Table View Delegate and Datasource */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paymentCell"];
    }
    
    return cell;
}

- (IBAction)didPressCancelPaymentButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
