//
//  CFPSummaryCollectionViewCell.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/26/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPSummaryCollectionViewCell.h"

@implementation CFPSummaryCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) shouldShowOptions:(BOOL)shouldShow{
    [self.editOrderButton setHidden:!shouldShow];
    [self.checkoutOrderButton setHidden:!shouldShow];
}

@end
