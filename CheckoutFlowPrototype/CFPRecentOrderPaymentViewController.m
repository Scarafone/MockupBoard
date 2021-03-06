//
//  CFPRecentOrderPaymentViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderPaymentViewController.h"

@interface CFPRecentOrderPaymentViewController ()

@property (copy, nonatomic) NSArray * paymentArray;

@end

@implementation CFPRecentOrderPaymentViewController

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
    [_roPaymentCollectionView setDelegate:self];
    [_roPaymentCollectionView setDataSource:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataForCollection:(NSArray *)data{
    self.paymentArray = data;
    [self.roPaymentCollectionView reloadData];
}


/* Collection View Delegate and Datasource */

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.paymentArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"paymentCellCredit" forIndexPath:indexPath];
    
    return cell;
    
}


@end
