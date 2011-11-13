//
//  PoiDetailController2.m
//  OverThere
//
//  Created by Frank Weiss on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PoiDetailController2.h"

@interface PoiDetailController2 (private)
- (void) phoneAction;
@end

@implementation PoiDetailController2

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView {    
    UITableView* tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
    
    fields = [[NSMutableArray alloc] init ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)  shouldAutorotateToInterfaceOrientation:  (UIInterfaceOrientation) interfaceOrientation {
    return YES;
}

#pragma mark - Table view data source

- (NSInteger) tableView: (UITableView*) view numberOfRowsInSection: (NSInteger) section {
    return section == 0 ? [fields count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.frame = CGRectMake(0, 0, 200, 50);
    int i =  [indexPath indexAtPosition:1];
    cell.textLabel.text = [fields objectAtIndex:i];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if ([indexPath indexAtPosition:1] == phoneFieldIndex & phoneFieldIndex != -1) {
        [self phoneAction];        
    }
}

#pragma mark - Custom methods

- (void) setPoi:(PoiAnnotation *)poi {
    [fields removeAllObjects];
    [fields addObject: poi.title];
    [fields addObject: poi.subtitle];
    if ([poi.phone isEqualToString: @"--"] ) {
        phoneFieldIndex = -1;
    }  else {
         phoneFieldIndex = [fields count];
        [fields addObject: poi.phone];
    }
    [fields addObject: poi.hours];
    [fields addObject: poi.specialties];
    [self.tableView reloadData];
}
- (void) phoneAction {
    NSString* phone = [fields objectAtIndex: phoneFieldIndex];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat: @"tel:%@", phone]]];
}

@end
