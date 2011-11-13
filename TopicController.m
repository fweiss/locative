//
//  TopicController.m
//  OverThere
//
//  Created by Frank Weiss on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TopicController.h"


@implementation TopicController

@synthesize topics;

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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    UITableView* tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - UITableViewDelgate implementation

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] init];
    
    NSArray* topicKeys = [[NSArray alloc] initWithObjects:@"1", @"4", @"21", @"22", @"8", @"17", nil];
    //NSString* topicKey = @"1"; // [indexPath indexAtPosition: 1
    NSString* topicKey = [topicKeys objectAtIndex:[indexPath indexAtPosition: 1]];
    [userInfo setObject: topicKey forKey: @"topicId"];
    [[NSNotificationCenter defaultCenter] postNotificationName: @"topicChanged" object: self userInfo: userInfo];
    self.tabBarController.selectedIndex = 0;
}

#pragma mark - UITableViewDataSource implementation

- (NSInteger) tableView: (UITableView*) view numberOfRowsInSection: (NSInteger) section {
    return section == 0 ? [topics count] : 0;
}
- (UITableViewCell*) tableView: (UITableView*) tableView cellForRowAtIndexPath: (NSIndexPath*) indexPath {
    UITableViewCell* tableViewCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"default"];
    int i =  [indexPath indexAtPosition:1];
    tableViewCell.textLabel.text = [topics objectAtIndex:i];
    return tableViewCell;
}

@end
