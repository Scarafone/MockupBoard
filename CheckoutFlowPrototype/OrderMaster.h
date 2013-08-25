//
//  OrderMaster.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/23/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OrderMaster : NSManagedObject

@property (nonatomic, retain) NSNumber * orderMasterID;
@property (nonatomic, retain) NSNumber * companyID;
@property (nonatomic, retain) NSNumber * locationID;
@property (nonatomic, retain) NSNumber * userMasterID;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * customerID;
@property (nonatomic, retain) NSString * ticketNumber;
@property (nonatomic, retain) NSString * orderTitle;
@property (nonatomic, retain) NSString * orderState;
@property (nonatomic, retain) NSString * kdsState;
@property (nonatomic, retain) NSNumber * orderFulfilled;
@property (nonatomic, retain) NSNumber * orderDiscount;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSDate * lastUpdate;

@end
