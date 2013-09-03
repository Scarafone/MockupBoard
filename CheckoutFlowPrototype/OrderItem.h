//
//  OrderItem.h
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 8/25/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OrderItem : NSManagedObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSString * comp_reason;
@property (nonatomic, retain) NSNumber * company_id;
@property (nonatomic, retain) NSString * created;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSNumber * is_child;
@property (nonatomic, retain) NSNumber * is_comp;
@property (nonatomic, retain) NSNumber * is_void;
@property (nonatomic, retain) NSNumber * item_category_id;
@property (nonatomic, retain) NSString * item_category_name;
@property (nonatomic, retain) NSNumber * item_cost;
@property (nonatomic, retain) NSNumber * item_group_id;
@property (nonatomic, retain) NSNumber * item_id;
@property (nonatomic, retain) NSString * item_name;
@property (nonatomic, retain) NSNumber * item_price;
@property (nonatomic, retain) NSString * kds_state;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * last_update;
@property (nonatomic, retain) NSNumber * line_amount;
@property (nonatomic, retain) NSNumber * line_discount;
@property (nonatomic, retain) NSString * line_discount_type;
@property (nonatomic, retain) NSNumber * line_total;
@property (nonatomic, retain) NSNumber * location_id;
@property (nonatomic, retain) NSNumber * order_item_id;
@property (nonatomic, retain) NSNumber * order_master_id;
@property (nonatomic, retain) NSNumber * parent_order_item_id;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSNumber * tax_amount;
@property (nonatomic, retain) NSNumber * tax_included;
@property (nonatomic, retain) NSNumber * tax_rule_id_1;
@property (nonatomic, retain) NSNumber * tax_rule_id_1_amount;
@property (nonatomic, retain) NSString * tax_rule_id_1_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_1_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_1_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_2;
@property (nonatomic, retain) NSNumber * tax_rule_id_2_amount;
@property (nonatomic, retain) NSString * tax_rule_id_2_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_2_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_2_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_3;
@property (nonatomic, retain) NSNumber * tax_rule_id_3_amount;
@property (nonatomic, retain) NSString * tax_rule_id_3_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_3_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_3_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_4;
@property (nonatomic, retain) NSNumber * tax_rule_id_4_amount;
@property (nonatomic, retain) NSString * tax_rule_id_4_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_4_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_4_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_5;
@property (nonatomic, retain) NSNumber * tax_rule_id_5_amount;
@property (nonatomic, retain) NSString * tax_rule_id_5_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_5_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_5_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_6;
@property (nonatomic, retain) NSNumber * tax_rule_id_6_amount;
@property (nonatomic, retain) NSString * tax_rule_id_6_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_6_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_6_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_7;
@property (nonatomic, retain) NSNumber * tax_rule_id_7_amount;
@property (nonatomic, retain) NSString * tax_rule_id_7_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_7_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_7_total;
@property (nonatomic, retain) NSNumber * tax_rule_id_8;
@property (nonatomic, retain) NSNumber * tax_rule_id_8_amount;
@property (nonatomic, retain) NSString * tax_rule_id_8_name;
@property (nonatomic, retain) NSNumber * tax_rule_id_8_percent;
@property (nonatomic, retain) NSNumber * tax_rule_id_8_total;
@property (nonatomic, retain) NSNumber * user_master_id;
@property (nonatomic, retain) NSString * void_reason;

@end
