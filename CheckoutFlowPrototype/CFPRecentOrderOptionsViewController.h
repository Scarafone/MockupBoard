//
//  CFPRecentOrderOptionsViewController.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/1/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPRecentOrderOptionsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *roOptionsSelectionButton;

@end
