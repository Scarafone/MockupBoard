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
    
    int           _tableLimit;
    int           _itemNum;
    
    CFPAddPaymentViewController     * _addPaymentButton;
    CFPMasterPopoverViewController  * _popoverVC;
    
    NSMutableArray                  * _paymentObjectArray;
    
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


/* Configuration */

- (void)configureCheckoutFlowForOrder:(id)orderObject withState:(CFFlowState )state{
    
    if(!orderObject){
        NSLog(@"There is no orderObject payments can not be processed.");
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
            _itemNum = 0;
            [_cfPaymentTableView setHidden:YES];
//            [_cfPaymentTableView setUserInteractionEnabled:!_cfPaymentTableView.hidden];
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
    return _itemNum;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"paymentCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paymentCell"];
    }
    
    
    UILabel * numberLabel           = (UILabel*)[cell viewWithTag:1];       //Left most label
    UILabel * infoLabel             = (UILabel*)[cell viewWithTag:2];       //Middle and main label
    UITextField * priceTextField    = (UITextField*)[cell viewWithTag:3];   //Right side text field
    
    
    if(true && indexPath.row == _itemNum-1){
        //If it was just added then it should be the first the responder
        //so long as they aren't still editing.
        [priceTextField becomeFirstResponder];
        NSLog(@"Should show!");
    }
    
    NSString * numberString = [NSString stringWithFormat:@"#%i",indexPath.row + 1];
    [numberLabel setText:numberString];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)updateTableView{
    
    _tableLimit = 1;
    
    CGRect mainFrame = _cfPaymentTableView.frame;
    if(_itemNum <= _tableLimit){
        mainFrame.size.height = 62 * _itemNum;
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //Animation
                             _cfPaymentTableView.frame = mainFrame;
                         } completion:^(BOOL finished) {
                             //Completion
                         }];
    } else {
        [_cfPaymentTableView setScrollsToTop:YES];
    }
    

    
    
}

/* Segue */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addPaymentButton"]){
        _addPaymentButton = (CFPAddPaymentViewController*)segue.destinationViewController;
        [_addPaymentButton setDelegate:self];
    }
    if([segue.identifier isEqualToString:@"balanceRemaining"]){
        //nothing happening here yet
    }
}

/* Add button delegate */
- (void)didPressAddPaymentButton:(UIButton *)sender{
    NSLog(@"Pressed button");
    
    _itemNum++;
    
    [self updateTableView];
    [self pressedMe:nil];
    
    if(_cfPaymentTableView.hidden){
        [self noPressedMe:nil];
    }
    
    NSIndexPath * path = [NSIndexPath indexPathForItem:_itemNum-1 inSection:0];//Have to minus 1 counting starts at 0
    [_cfPaymentTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

- (void)didPressSplitPaymentButton:(UIButton *)sender{
    NSLog(@"Pressed Split Payment button");
}

/* Actions */

- (IBAction)didPressCancelPaymentButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressedMe:(UIButton *)sender {
    
    CGRect mainFrame = _cfAddPaymentContainer.frame;
    CGRect secondFrame = _cfAmountDueContainer.frame;
    int buffer = 10;
    
    if(_cfPaymentTableView.hidden){
        mainFrame.origin.y = 228; //Initial Zone Button
        secondFrame.origin.y = 369; //Initial Zone Pay Balance
        
    } else {        
        mainFrame.origin.y = 228 + buffer +  _cfPaymentTableView.frame.size.height;
        secondFrame.origin.y = 369 + buffer /*+ _cfAddPaymentContainer.frame.size.height*/ + _cfPaymentTableView.frame.size.height;
    }
    

    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //Animation
                         _cfAddPaymentContainer.frame = mainFrame;
                         _cfAmountDueContainer.frame = secondFrame;
                     } completion:^(BOOL finished) {
                         //Completion
                     }];
    
    [_cfPaymentTableView reloadData];

}

- (IBAction)noPressedMe:(UIButton *)sender {
    [_cfPaymentTableView setHidden:!_cfPaymentTableView.hidden];

}
@end
