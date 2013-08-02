//
//  CFPRecentOrderViewController.m
//  CheckoutFlowPrototype
//
//  Created by Brent Scarafone on 7/31/13.
//  Copyright (c) 2013 Brent Scarafone. All rights reserved.
//

#import "CFPRecentOrderViewController.h"

@interface CFPRecentOrderViewController () {
    
    BOOL _tabGroupIsShowing;
    
}

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
    
    [_roTabGroupButtonView setHidden:YES];
    
//    [_roScrollView setDelegate:self];
//    [_roScrollView setContentSize:CGSizeMake(1500, 585)];
    
    
//    CGRect mainframe = _roContainerView.frame;
//    [_roContainerView setBounds:CGRectMake(mainframe.origin.x, mainframe.origin.y
//                                          , 2000, mainframe.size.height)];
    

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
    return 2;
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
    [self tabGroupIsShowing:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tabGroupIsShowing:NO];
}

/* Animate Tab Group */

- (void)tabGroupIsShowing:(BOOL)showing{

    CGRect mainFrame = _roTabGroupButtonView.frame;
    if(showing){
        [_roTabGroupButtonView setHidden:NO];
        _tabGroupIsShowing = YES;
        mainFrame.origin.y = 76;
        [_roTabGroupSummaryButton setSelected:YES];
        [_roTabGroupSelectionArrow setHidden:NO];
    } else {
        mainFrame.origin.y = 22;
        _tabGroupIsShowing = NO;
    }

    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //Animation
                         _roTabGroupButtonView.frame = mainFrame;
                         if(!_tabGroupIsShowing){
                             _roTabGroupButtonView.alpha = !_roTabGroupButtonView.alpha;
                         } else {
                             _roTabGroupButtonView.alpha = 1;
                         }
                     } completion:^(BOOL finished) {
                         //Completion
                         if(!_tabGroupIsShowing){
                             [_roTabGroupButtonView setHidden:YES];
                         }
                     }];
}

- (IBAction)roDidPressTabGroupButton:(UIButton *)sender {
    NSLog(@"Did press tab button %@",sender);
    [sender setSelected:!sender.selected];
}

- (IBAction)roDidPressNaviGroupButton:(UIButton *)sender {
    NSLog(@"Did press navi button %@",sender);
    [sender setSelected:!sender.selected];
}

- (IBAction)didPressHomeButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
