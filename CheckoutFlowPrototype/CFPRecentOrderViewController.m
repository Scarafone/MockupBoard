//
//  CFPRecentOrderViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/31/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderViewController.h"
#import "OrderMaster.h"




static void CFPShowAlertWithError(NSError *error)
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    [alert show];
}

@implementation OrderDetailClass
@end

@interface CFPRecentOrderViewController () {
    
    BOOL _tabGroupIsShowing;

    NSMutableArray      * _roNavigationButtonArray;
    NAVIGATION_BUTTONS    _roSelectedFilter;

    CFPRecentOrderMasterInformationViewController   * _roMasterInformationViewController;

}

@property (nonatomic, strong)NSFetchedResultsController * fetchedResultsController;
@property (nonatomic, strong)UITableViewController      * tableViewController;

@end

@implementation CFPRecentOrderViewController

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
    [_roTableView setDelegate:self];
    [_roTableView setDataSource:self];
    
    //Hide the information container until requested
    [_roContainerView setHidden:YES];

    /**
    *   Grab the navigation buttons in the view to make an array to be used for mutal exclusive
    *   tags 50 - 53 (Home(0),Open(1),Completed(2),All(3))
    *   Not grabbing home button
    */
    
    _roNavigationButtonArray = [@[]mutableCopy];
    
    
    
    
    /* Set the default button to be highligted */
    
    for(int i =51;i < 54;i++){
        UIButton * button = (UIButton*)[self.view viewWithTag:i];
        [_roNavigationButtonArray addObject:button];
        if(button.tag == NAVI_ALL_ORDERS)
            [button setSelected:YES];
    }
    
    
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"OrderMaster"];
    NSSortDescriptor * descriptor = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    NSError * error = nil;
    
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                  managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                    sectionNameKeyPath:nil
                                                                             cacheName:nil];
    
    [self.fetchedResultsController setDelegate:self];
    BOOL fetchSuccessful = [self.fetchedResultsController performFetch:&error];
    if(!fetchSuccessful){
        CFPShowAlertWithError(error);
    }
   
    
    self.tableViewController = [[UITableViewController alloc]init];
    self.tableViewController.tableView = self.roTableView;
    
    
    UIRefreshControl * refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.tableViewController.refreshControl = refreshControl;

    
    [self.tableViewController.refreshControl beginRefreshing];
    
    [self loadData];
    
    

}

- (void) loadData
{
    NSLog(@"Loading data...");
    
    /* 
     Load data for just today
     */


    [[RKObjectManager sharedManager] setRequestSerializationMIMEType:RKMIMETypeJSON];
    
    [[[RKObjectManager sharedManager]defaultHeaders]setValue:@"application/json" forKey:@"Content-Type"];
    [[[RKObjectManager sharedManager]defaultHeaders]setValue:@"application/json" forKey:@"x-cube-encoding"];
    //NSError * error = nil;
    //NSData * jsonData = [NSJSONSerialization dataWithJSONObject:searchFilterArray
      //                                                  options:0
        //                                                  error:&error];
    
    /*
    NSString *JSONString;
    if(!jsonData){
        NSLog(@"Error : %@",error);
    } else {
        JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        NSLog(@"JSON OUTPUT: %@",JSONString);
    }
     */
    


    
    //NSDictionary *myDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
   /* 
        Multiple Calls for orders, pull in completed order from the current day unless other with specified
        pull in all open orders
    */
    
    NSArray * parameters = [NSArray arrayWithObjects:@{
                            //Data Condition
                            @"field":@"created",
                            @"condition":@"greater_than",
                            @"value":@"08/25/2013"},
                            nil];
    [[RKObjectManager sharedManager]putObject:nil path:@"/rest.svc/API/order_master" parameters:(NSDictionary*)parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Success
        [self.tableViewController.refreshControl endRefreshing];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //Fail
        [self.tableViewController.refreshControl endRefreshing];
        CFPShowAlertWithError(error);
    }];
    
    NSArray * openParameters = [NSArray arrayWithObjects:@{
                            //Data Condition
                            @"field":@"order_state",
                            @"condition":@"equals",
                            @"value":@"open"},
                            nil];
    [[RKObjectManager sharedManager]putObject:nil path:@"/rest.svc/API/order_master" parameters:(NSDictionary*)openParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Success
        [self.tableViewController.refreshControl endRefreshing];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //Fail
        [self.tableViewController.refreshControl endRefreshing];
        CFPShowAlertWithError(error);
    }];
    
    
 
    /*
    [[RKObjectManager sharedManager]getObjectsAtPath:@"/rest.svc/API/order_master" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Success
        NSLog(@"Success");
        [self.tableViewController.refreshControl endRefreshing];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //Fail
        [self.tableViewController.refreshControl endRefreshing];
        CFPShowAlertWithError(error);
    }];

    */ 

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* Table view Datasource Delegate methods */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    /* Sets the section header view with the section title(date) */
    
    UIView * view = [[UIView alloc]init];
    [view setBackgroundColor:[UIColor colorWithRed:216.0/255.0f green:216.0/255.0f blue:216.0/255.0f alpha:1]];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"EEEE, MMM dd, YYYY"];
    NSDate * date = [NSDate date];
    NSString * date_string = [format stringFromDate:date];
    
    [label setText:date_string];
    [view addSubview:label];
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"order_cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"order_cell"];
    }
    //Cell selection background
    [cell setSelectedBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buttonselectionhighlightimage.png"]]];
    
    //Grab cell labels for data output
    UILabel * order_label = (UILabel*)[cell viewWithTag:1];
    UILabel * time_date_label = (UILabel *)[cell viewWithTag:2];
    UILabel * price_label = (UILabel *)[cell viewWithTag:3];
    UILabel * status_label = (UILabel *)[cell viewWithTag:4];
   
    OrderMaster *orderMaster = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"hh:mm a"];
    NSDate * date = orderMaster.created;
    NSString * date_string = [format stringFromDate:date];
    

    
    [order_label setText:[NSString stringWithFormat:@"Order #%@",orderMaster.orderMasterID.stringValue]];
    [time_date_label setText:date_string];
    
    [price_label setText:orderMaster.ticketNumber != nil ? [NSString stringWithFormat:@"Ticket #%@",orderMaster.ticketNumber]:@"Not Available"];
    
    if([orderMaster.orderState isEqualToString:@"closed"]){//Determine the color of the status label depending on the order_state
        [status_label setTextColor:[UIColor redColor]];
    } else {
        [status_label setTextColor:[UIColor greenColor]];
    }
    [status_label setText:orderMaster.orderState];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected cell @ %@ ",indexPath);
    [_roContainerView setHidden:NO];
    
    /* What to pass*/
    [self createAndLoadMasterInformationVC:indexPath];
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_roContainerView setHidden:YES];
    [_roMasterInformationViewController shouldShowTabButtonGroup:NO];
    
}

/* Feteched Results Controller */

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.roTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Should not happen
    //Grab the view controller to be segued to for button control and response
    _roMasterInformationViewController = (CFPRecentOrderMasterInformationViewController*)segue.destinationViewController;
}

- (void)createAndLoadMasterInformationVC:(NSIndexPath*)indexPath{
    
    //Remove Old Views
    [_roMasterInformationViewController.view removeFromSuperview];
    [_roMasterInformationViewController removeFromParentViewController];
    //End
    
    if(!_roMasterInformationViewController){
        _roMasterInformationViewController = (CFPRecentOrderMasterInformationViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MasterInformationVC"];
    }

    OrderMaster * orderMaster = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    

    /* Show loader Here*/
    
    /* End Loader */
    
    
    NSArray * parameters = [NSArray arrayWithObject:@{
                                 @"field":@"order_master_id",
                                 @"condition":@"equals",
                                 @"value":[NSString stringWithFormat:@"%@",orderMaster.orderMasterID]}
                                 ];
    
    RKObjectMapping * orderDetailMapping = [RKObjectMapping mappingForClass:[OrderDetailClass class]];
    [orderDetailMapping addAttributeMappingsFromDictionary:@{
     @"success" :@"success",
     @"data"    :@"data"
     }];
    
    RKResponseDescriptor * responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:orderDetailMapping method:RKRequestMethodPUT pathPattern:@"/rest.svc/API/report/order_detail" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager]addResponseDescriptor:responseDescriptor];
    
    __block OrderDetailClass * orderDetail;
    [[RKObjectManager sharedManager]putObject:nil path:@"/rest.svc/API/report/order_detail" parameters:(NSDictionary*)parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //success
        orderDetail = [mappingResult firstObject];
        [_roMasterInformationViewController setOrderObject:orderDetail];//Pass order object to use
        //Display loaded information
        
        [_roContainerView addSubview:_roMasterInformationViewController.view];
        [self addChildViewController:_roMasterInformationViewController];
        
        [_roMasterInformationViewController shouldShowTabButtonGroup:YES];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //fail
        CFPShowAlertWithError(error);
    }];
    
    
    
    
    

    
    //END SCREEN HERE
    //[self screenEndingMethod];
    
}


- (IBAction)roDidPressNaviGroupButton:(UIButton *)sender {
    
    [sender setSelected:!sender.selected];
    
    for(UIButton * button in _roNavigationButtonArray){
        if(button.selected && button != sender){
            button.selected = NO;
        }
        if(!button.selected && button == sender){
            button.selected = YES;
            _roSelectedFilter = sender.tag;
        }
    }
    
    [self filterListByType:sender.tag];

}

- (void)filterListByType:(NAVIGATION_BUTTONS)type{
    
    switch (type) {
        case NAVI_OPEN_ORDERS:{
            break;
        }
        case NAVI_COMPLETED_ORDERS:{
            break;
        }
        case NAVI_ALL_ORDERS:{
            break;
        }
        default:{
            break;
        }
    }
    
}

- (IBAction)didPressHomeButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
