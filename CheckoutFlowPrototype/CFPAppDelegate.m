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
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/rest.svc/API/order_master"
                                                                                           keyPath:@"data"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
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
