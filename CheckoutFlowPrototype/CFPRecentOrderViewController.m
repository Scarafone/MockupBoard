//
//  CFPRecentOrderViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/31/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderViewController.h"


static void CFPShowAlertWithError(NSError *error)
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles: nil];
    [alert show];
}

@interface CFPRecentOrderViewController () {
    
    BOOL _tabGroupIsShowing;
    CFPRecentOrderMasterInformationViewController * _roMasterInformationViewController;
    
    NSMutableArray * _roNavigationButtonArray;
    NAVIGATION_BUTTONS _roSelectedFilter;
    

}

@property (nonatomic, strong)NSFetchedResultsController * fetchedResultsController;

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
    
    
    
    
    /* Set the default button to be highligted*/
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
    
    [self loadData];
    
    

}

- (void) loadData
{
    NSLog(@"Loading data...");
    
    [[RKObjectManager sharedManager]getObjectsAtPath:@"/rest.svc/API/order_master" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        //Success
        NSLog(@"Success");
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        //Fail
        CFPShowAlertWithError(error);
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* Table view Datasource Delegate methods */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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
    
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"hh:mm a"];
    NSDate * date = [NSDate date];
    NSString * date_string = [format stringFromDate:date];
    
    
    [order_label setText:@"Order # 100000"];
    [time_date_label setText:date_string];
    [price_label setText:@"$100.00"];
    
    if(true){//Determine the color of the status label depending on the order_state
        [status_label setTextColor:[UIColor redColor]];
    } else {
        [status_label setTextColor:[UIColor greenColor]];
    }
    [status_label setText:@"Closed"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Selected cell @ %@ ",indexPath);
    [_roContainerView setHidden:NO];
    [_roMasterInformationViewController shouldShowTabButtonGroup:YES];
    
    /* What to pass*/
    [self createAndLoadMasterInformationVC:indexPath];
    
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_roContainerView setHidden:YES];
    [_roMasterInformationViewController shouldShowTabButtonGroup:NO];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Should not happen
    //Grab the view controller to be segued to for button control and response
    _roMasterInformationViewController = (CFPRecentOrderMasterInformationViewController*)segue.destinationViewController;
}

- (void)createAndLoadMasterInformationVC:(id)something{
    
    if(!_roMasterInformationViewController){
        _roMasterInformationViewController = (CFPRecentOrderMasterInformationViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MasterInformationVC"];
    }

    
    
    // Process Request Screen Layover HERE
    /* Restkit block 
     
     * Send for order master object
     * Order master object returns 
     * send order master object to be displayed
     
     */

    
    [_roMasterInformationViewController setOrderObject:nil];//Pass order object to use
    
    
    //Display loaded information
    
    [_roContainerView addSubview:_roMasterInformationViewController.view];
    [self addChildViewController:_roMasterInformationViewController];
    
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
