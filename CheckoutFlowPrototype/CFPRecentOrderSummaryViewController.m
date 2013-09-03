//
//  CFPRecentOrderSummaryViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderSummaryViewController.h"
#import "CFPSummaryCollectionViewCell.h"

@interface CFPRecentOrderSummaryViewController () {
    UIView * _tempView;
}

@property (copy, nonatomic) NSDictionary    * summaryData;
@property (copy, nonatomic) NSArray         * paymentArray;
@property (copy, nonatomic) NSDictionary    * orderMasterDictionary;
@property (copy, nonatomic) NSArray         * orderItemArray;
@property (copy, nonatomic) NSDictionary    * customerDictionary;

@end

@implementation CFPRecentOrderSummaryViewController

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
    [_roSummaryCollectionView setDelegate:self];
    [_roSummaryCollectionView setDataSource:self];
    
    [self.view setHidden:YES];

}

- (void)viewWillDisappear:(BOOL)animated{
    self.summaryData = nil;//Clear old data
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataForCollection:(NSArray *)data{
    
    self.summaryData            = [data objectAtIndex:0];
    self.orderItemArray         = [self.summaryData objectForKey:@"order_item_entry_list"];
    self.paymentArray           = [self.summaryData objectForKey:@"payment_list"];
    self.orderMasterDictionary  = [self.summaryData objectForKey:@"order_master"];
    self.customerDictionary     = [self.summaryData objectForKey:@"customer"];
    
    
    
    [self.view setHidden:NO];
    [_roSummaryCollectionView reloadData];
}


/* Collection View Delegate and Datasource */

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CFPSummaryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"summarycell" forIndexPath:indexPath];
    // No data to display
    if(!self.summaryData){
        return cell;
    }
    
    UIButton * edit_order_button = (UIButton*)[cell viewWithTag:121];
    UIButton * checkout_order_button = (UIButton*)[cell viewWithTag:122];
    
    [edit_order_button addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [checkout_order_button addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];

    
    if([[self.orderMasterDictionary valueForKey:@"order_state"]isEqualToString:@"open"]){//If open order buttons will need to be visible other wise they will be hidden
        [cell shouldShowOptions:YES];
        [cell.orderState setTextColor:[UIColor greenColor]];
    } else {
        [cell shouldShowOptions:NO];
        [cell.orderState setTextColor:[UIColor redColor]];
    }
    
    cell.orderMasterID.text     = [NSString stringWithFormat:@"#%@",[self.orderMasterDictionary valueForKey:@"order_master_id"]];
    cell.orderState.text        = [[NSString stringWithFormat:@"%@",[self.orderMasterDictionary valueForKey:@"order_state"]]uppercaseString];
    cell.ticketNumber.text      = [NSString stringWithFormat:@"%@", [self.orderMasterDictionary valueForKey:@"ticket_number"]];
    cell.created.text           = [NSString stringWithFormat:@"%@", [self.orderMasterDictionary valueForKey:@"created"]];
    cell.employeeName.text      = [NSString stringWithFormat:@"%@ %@",[self.orderMasterDictionary valueForKey:@"first_name"],[self.orderMasterDictionary valueForKey:@"last_name"]];
    if((NSNull*)self.customerDictionary != [NSNull null]){
        cell.customerName.text  = [NSString stringWithFormat:@"%@ %@",[self.customerDictionary valueForKey:@"first_name"],[self.customerDictionary valueForKey:@"last_name"]];
    } else {
        cell.customerName.text  = @"";
    }
    cell.numberOfPayments.text  = [NSString stringWithFormat:@"%i",self.paymentArray.count];
    cell.numberOfItems.text = [NSString stringWithFormat:@"%@",[self.summaryData valueForKey:@"item_count"]];
    cell.subtotal.text      = [NSString stringWithFormat:@"$%@",[self.summaryData valueForKey:@"amount_subtotal"]];
    cell.discounts.text     = [NSString stringWithFormat:@"$%@",[self.summaryData valueForKey:@"amount_discount"]];
    cell.tax.text           = [NSString stringWithFormat:@"$%@",[self.summaryData valueForKey:@"amount_tax"]];
    cell.tips.text          = [NSString stringWithFormat:@"$%@",[self.summaryData valueForKey:@"amount_tip"]];
    cell.total.text         = [NSString stringWithFormat:@"$%@",[self.summaryData valueForKey:@"amount_total"]];
    cell.notes.text         = [NSString stringWithFormat:@"%@",[self.orderMasterDictionary valueForKey:@"comments"]];
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //Grab the view
    _tempView = (UIView*)[collectionView viewWithTag:103];
    

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{


    _tempView = nil;
}

#pragma mark - Collection View Actions

-(void)didPressButton:(UIButton*)sender{
    NSLog(@"Pressed button : %@",sender);
    
}


@end
