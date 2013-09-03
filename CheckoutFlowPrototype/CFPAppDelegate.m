 //
//  CFPAppDelegate.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/23/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPAppDelegate.h"
#import "OrderMaster.h"



@implementation CFPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSURL * baseURL = [NSURL URLWithString:@"https://supervisor.getcube.com:65532/"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    //Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Model" ofType:@"momd"]];
    
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL]mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc]initWithManagedObjectModel:managedObjectModel];
    
    objectManager.managedObjectStore = managedObjectStore;
    
    //Set up mappings
    
     RKEntityMapping * entityMapping = [RKEntityMapping mappingForEntityForName:@"OrderMaster" inManagedObjectStore:managedObjectStore];
     [entityMapping addAttributeMappingsFromDictionary:@{
     @"order_master_id"     : @"orderMasterID",
     @"company_id"          : @"companyID",
     @"location_id"         : @"locationID",
     @"user_master_id"      : @"userMasterID",
     @"first_name"          : @"firstName",
     @"last_name"           : @"lastName",
     @"customer_id"         : @"customerID",
     @"ticket_number"       : @"ticketNumber",
     @"order_title"         : @"orderTitle",
     @"order_state"         : @"orderState",
     @"kds_state"           : @"kdsState",
     @"order_fulfilled"     : @"orderFulfilled",
     @"order_discount"      : @"orderDiscount",
     @"comments"            : @"comments",
     @"created"             : @"created",
     @"last_update"         : @"lastUpdate"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping
                                                                                            method:RKRequestMethodPUT
                                                                                       pathPattern:@"/rest.svc/API/order_master"
                                                                                           keyPath:@"data"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    /* Order Item Mapping */
    RKEntityMapping * orderItemEntityMapping = [RKEntityMapping mappingForEntityForName:@"OrderItem" inManagedObjectStore:managedObjectStore];
    
    [orderItemEntityMapping addAttributeMappingsFromDictionary:@{
     @"active":                 @"active",
     @"comments":               @"comments",
     @"comp_reason":            @"comp_reason",
     @"created":                @"created",
     @"first_name":             @"first_name",
     @"is_child":               @"is_child",
     @"is_comp":                @"is_comp",
     @"is_void":                @"is_void",
     @"item_category_id":       @"item_category_id",
     @"item_cost":              @"item_group_id",
     @"item_id":                @"item_id",
     @"item_name":              @"item_name",
     @"item_price":             @"item_price",
     @"kds_state":              @"kds_state",
     @"last_name":              @"last_name",
     @"last_update":            @"last_update",
     @"line_amount":            @"line_amount",
     @"line_discount":          @"line_discount_type",
     @"line_total":             @"line_total",
     @"location_id":            @"location_id",
     @"order_item_id":          @"order_master_id",
     @"parent_order_item_id":   @"parent_order_item_id",
     @"quantity":               @"quantity",
     @"tax_amount":             @"tax_amount",
     @"tax_included":           @"tax_included",
     
     @"tax_rule_id_1":          @"tax_rule_id_1",
     @"tax_rule_id_1_amount":   @"tax_rule_id_1_amount",
     @"tax_rule_id_1_percent":  @"tax_rule_id_1_percent",
     @"tax_rule_id_1_total":    @"tax_rule_id_1_total",
     
     @"tax_rule_id_2":          @"tax_rule_id_2",
     @"tax_rule_id_2_amount":   @"tax_rule_id_2_amount",
     @"tax_rule_id_2_percent":  @"tax_rule_id_2_percent",
     @"tax_rule_id_2_total":    @"tax_rule_id_2_total",
     
     @"tax_rule_id_3":          @"tax_rule_id_3",
     @"tax_rule_id_3_amount":   @"tax_rule_id_3_amount",
     @"tax_rule_id_3_percent":  @"tax_rule_id_3_percent",
     @"tax_rule_id_3_total":    @"tax_rule_id_3_total",
     
     @"tax_rule_id_4":          @"tax_rule_id_4",
     @"tax_rule_id_4_amount":   @"tax_rule_id_4_amount",
     @"tax_rule_id_4_percent":  @"tax_rule_id_4_percent",
     @"tax_rule_id_4_total":    @"tax_rule_id_4_total",
     
     @"tax_rule_id_5":          @"tax_rule_id_5",
     @"tax_rule_id_5_amount":   @"tax_rule_id_5_amount",
     @"tax_rule_id_5_percent":  @"tax_rule_id_5_percent",
     @"tax_rule_id_5_total":    @"tax_rule_id_5_total",
     
     @"tax_rule_id_6":          @"tax_rule_id_6",
     @"tax_rule_id_6_amount":   @"tax_rule_id_6_amount",
     @"tax_rule_id_6_percent":  @"tax_rule_id_6_percent",
     @"tax_rule_id_6_total":    @"tax_rule_id_6_total",
     
     @"tax_rule_id_7":          @"tax_rule_id_7",
     @"tax_rule_id_7_amount":   @"tax_rule_id_7_amount",
     @"tax_rule_id_7_percent":  @"tax_rule_id_7_percent",
     @"tax_rule_id_7_total":    @"tax_rule_id_7_total",
     
     @"tax_rule_id_8":          @"tax_rule_id_8",
     @"tax_rule_id_8_amount":   @"tax_rule_id_8_amount",
     @"tax_rule_id_8_percent":  @"tax_rule_id_8_percent",
     @"tax_rule_id_8_total":    @"tax_rule_id_8_total",
     
     
     @"user_master_id":         @"user_master_id",
     @"void_reason":            @"void_reason"
     
     }];
    
    RKResponseDescriptor * orderItemResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:orderItemEntityMapping method:RKRequestMethodGET pathPattern:@"/rest.svc/API/order_item" keyPath:@"data" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager]addResponseDescriptor:orderItemResponseDescriptor];

    /*
     Complete Core Data Stack initialization
     */
    [managedObjectStore createPersistentStoreCoordinator];
    NSError * error = nil;
    NSPersistentStore __unused *persistentStore = [managedObjectStore addInMemoryPersistentStore:&error];
    NSAssert(persistentStore, @"Failed to add persistent store: %@",error);
    
    //Configure Contexts
    [managedObjectStore createManagedObjectContexts];
    
    //Set the default instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    [RKObjectManager setSharedManager:objectManager];
    
    //Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc]initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    

    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
