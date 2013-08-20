//
//  CFPRecentOrderSummaryViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderSummaryViewController.h"

@interface CFPRecentOrderSummaryViewController () {
    UIView * _tempView;
}

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* Collection View Delegate and Datasource */

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"summarycell" forIndexPath:indexPath];
    
    UIButton * edit_order_button = (UIButton*)[cell viewWithTag:101];//101 edit order
    UIButton * checkout_order_button = (UIButton*)[cell viewWithTag:102];//102 checkout order

    
    
    if(!true){//If open order buttons will need to be visible other wise they will be hidden
        [edit_order_button setHidden:NO];
        [checkout_order_button setHidden:NO];
    } else {
        [edit_order_button setHidden:YES];
        [checkout_order_button setHidden:YES];
    }
    

    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //Grab the view
    _tempView = (UIView*)[collectionView viewWithTag:103];
    
    //Zoom on that cell
    [self shouldZoom:YES CellAtIndexPath:indexPath];

}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self shouldZoom:NO CellAtIndexPath:indexPath];
    _tempView = nil;
}

- (void)shouldZoom:(BOOL)on CellAtIndexPath:(NSIndexPath*)indexPath{

    
    CGRect mainFrame = _tempView.frame;
    
    if(on){
//        mainFrame.size.height *=2;
//        mainFrame.size.width  *=2;
        
//        mainFrame.origin.x -= mainFrame.size.width / 2;
//        mainFrame.origin.y -= mainFrame.size.height / 2;
    } else {
//        mainFrame.size.height /=2;
//        mainFrame.size.width  /=2;
        
//        mainFrame.origin.x += mainFrame.size.width;
//        mainFrame.origin.y += mainFrame.size.height;
    }

    
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //Animations
                         _tempView.frame = mainFrame;
                     } completion:^(BOOL finished) {
                         //Completion
                     }];
}


@end
