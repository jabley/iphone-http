//
//  RootViewController.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright Mobile IQ Ltd 2010. All rights reserved.
//

#import "RootViewController.h"
#import "InfoCell.h"
#import "HTTPImplementationEditor.h"
#import "FetchTask.h"
#import "ResponseDetailViewController.h"

@interface RootViewController(PrivateMethods)

- (IBAction)goWasTapped:(id)sender;

- (UITableViewCell*)httpImplementationCell:(NSDictionary*)userInfo;

- (UITableViewCell*)infoCell:(NSDictionary*)userInfo;

- (NSNumber*)infoRowHeight:(UITableView*)tableView;

- (UITableViewCell*)responseCell:(NSDictionary*)userInfo;

- (UITableViewCell*)urlCell:(NSDictionary*)userInfo;

- (NSNumber*)defaultRowHeight:(UITableView*)tableView;

@end

static NSString *intro = @"Select an HTTP client implementation and see how it performs.";

@implementation RootViewController

@synthesize httpClient = httpClient_;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:@"HTTP library comparisons"];

    cellStructures_ = [[NSArray alloc] initWithObjects:

                       /* info row */
                       [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSValue valueWithPointer:@selector(infoCell:)], @"cellSelector",
                            [NSValue valueWithPointer:@selector(infoRowHeight:)], @"rowHeightSelector",
                        nil],

                       /* HTTP client implementation row */
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"Select an HTTP client", @"sectionHeader",
                        [NSValue valueWithPointer:@selector(httpImplementationCell:)], @"cellSelector",
                        [NSValue valueWithPointer:@selector(defaultRowHeight:)], @"rowHeightSelector",
                        [NSNumber numberWithBool:YES], @"allowsRowSelection",
                        nil],

                       /* URL selection row */
                       [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Enter a URL", @"sectionHeader",
                            [NSValue valueWithPointer:@selector(urlCell:)], @"cellSelector",
                            [NSValue valueWithPointer:@selector(defaultRowHeight:)], @"rowHeightSelector",
                        nil],

                       /* Response row */
                       [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Responses", @"sectionHeader",
                            [NSValue valueWithPointer:@selector(responseCell:)], @"cellSelector",
                            [NSValue valueWithPointer:@selector(defaultRowHeight:)], @"rowHeightSelector",
                            [NSNumber numberWithBool:YES], @"allowsRowSelection",
                            nil],
                       nil];

    httpClients_ = [[NSArray alloc] initWithObjects:
                    [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     @"NSURLConnection", @"displayName",
                     @"NSURLConnectionFetchTask", @"impl",
                     nil],
                    [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     @"ASIHTTPRequest", @"displayName",
                     @"ASIHTTPRequestFetchTask", @"impl",
                     nil],
                    nil];

    httpClient_ = [[httpClients_ objectAtIndex:0u] retain];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark RootViewController
- (void)setHttpClient:(NSMutableDictionary *)client {
    /* Override this to update the UI when it changes. */

    if (client == httpClient_) {
        return;
    }

    [client retain];
    [httpClient_ release];
    httpClient_ = client;

    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[self httpClient] objectForKey:@"tasks"]) {
        return [cellStructures_ count];
    }

    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 3: // Response headers
            return [[[self httpClient] objectForKey:@"tasks"] count];
        default:
            return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(NSNumber*)[self performSelector:[[[cellStructures_ objectAtIndex:[indexPath section]] objectForKey:@"rowHeightSelector"] pointerValue]
                      withObject:tableView] floatValue];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	// Configure the cell.
    return [self performSelector:[[[cellStructures_ objectAtIndex:[indexPath section]] objectForKey:@"cellSelector"] pointerValue]
                      withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  tableView, @"tableView",
                                  indexPath, @"indexPath",
                                  nil]];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[cellStructures_ objectAtIndex:section] objectForKey:@"sectionHeader"];
}

#pragma mark -
#pragma mark Table view delegate
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[cellStructures_ objectAtIndex:[indexPath section]] objectForKey:@"allowsRowSelection"] boolValue]) {
        return indexPath;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch ([indexPath section]) {
        case 1: { // HTTP client selection
            HTTPImplementationEditor *controller = [[HTTPImplementationEditor alloc] init];
            [controller setTarget:self];
            [controller setKeypath:@"httpClient"];
            [controller setImplementations:httpClients_];

            [[self navigationController] pushViewController:controller animated:YES];

            [controller release];
            break;
        }
        case 3: { // Response detail selection
            FetchTask *selectedTask = [[[self httpClient] objectForKey:@"tasks"] objectAtIndex:[indexPath row]];
            ResponseDetailViewController *controller = [[ResponseDetailViewController alloc] initWithFetchTask:selectedTask];
            [[self navigationController] pushViewController:controller animated:YES];
            [controller release];
        }
        default:
            break;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [cellStructures_ release];
    [httpClient_ release];
    [httpClients_ release];

    [super dealloc];
}

#pragma mark -
#pragma mark PrivateMethods
- (IBAction)goWasTapped:(id)sender {

    NSURL *url = [NSURL URLWithString:[urlField_ text]];
    Class implementationClass = NSClassFromString([httpClient_ objectForKey:@"impl"]);

    [httpClient_ removeObjectForKey:@"tasks"];
    [httpClient_ setObject:url forKey:@"url"];

    NSMutableArray *tasks = [[NSMutableArray alloc] initWithCapacity:10];

    for (NSInteger i = 0, n = 10; i < n; ++i) {
        FetchTask *task = [[implementationClass alloc] initWithURL:url];
        [task execute];

        [tasks addObject:task];
        [task release];
    }

    [httpClient_ setObject:tasks forKey:@"tasks"];
    [tasks release];

    [[self tableView] reloadData];
}

- (UITableViewCell*)httpImplementationCell:(NSDictionary *)userInfo {
    UITableView *tableView = [userInfo objectForKey:@"tableView"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTTPCell"];

    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HTTPCell"] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }

    [[cell textLabel] setText:[[self httpClient] objectForKey:@"displayName"]];

    return cell;
}

- (UITableViewCell*)infoCell:(NSDictionary*)userInfo {

    UITableView *tableView = [userInfo objectForKey:@"tableView"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoCell"];

    if (!cell) {
        cell = [InfoCell cell];
    }

    [[cell textLabel] setText:intro];
    [cell layoutSubviews];

    return cell;
}

- (NSNumber*)infoRowHeight:(UITableView *)tableView {
    return [NSNumber numberWithUnsignedInteger:[InfoCell requiredHeightFor:intro withTableWidth:[tableView frame].size.width] + 20];
}

- (UITableViewCell*)responseCell:(NSDictionary*)userInfo {

    UITableView *tableView = [userInfo objectForKey:@"tableView"];
    NSIndexPath *indexPath = [userInfo objectForKey:@"indexPath"];


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell"];

    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResponseCell"] autorelease];
    }

    NSArray *tasks = [[self httpClient] objectForKey:@"tasks"];

    FetchTask *task = [tasks objectAtIndex:[indexPath row]];

    if ([task error]) {
        [[cell textLabel] setTextColor:[UIColor redColor]];
    } else {
        [[cell textLabel] setTextColor:[UIColor blackColor]];
    }

    [[cell textLabel] setText:[NSString stringWithFormat:@"%fs", [task duration]]];
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton]; // Tapping on this cell should show the response detail

    return cell;
}

- (UITableViewCell*)urlCell:(NSDictionary *)userInfo {

    UITableView *tableView = [userInfo objectForKey:@"tableView"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"URLCell"];

    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"URLCell"] autorelease];
        urlField_ = [[[UITextField alloc] initWithFrame:CGRectZero] autorelease];
        [[cell contentView] addSubview:urlField_];
        goButton_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [goButton_ setTitle:@"Go!" forState:UIControlStateNormal];
        [goButton_ addTarget:self action:@selector(goWasTapped:) forControlEvents:UIControlEventTouchUpInside];
        [[cell contentView] addSubview:goButton_];
    }

    int tablePadding = 40;
	int tableWidth = [tableView frame].size.width;

    [goButton_ setFrame:CGRectMake((tableWidth - tablePadding - 38), 7, 20, 20)];
    [goButton_ sizeToFit];

    [urlField_ setFrame:CGRectMake(10, 12, (tableWidth - tablePadding - 50), 20)];

    if ([[self httpClient] objectForKey:@"url"]) {
        [urlField_ setText:[[[self httpClient] objectForKey:@"url"] absoluteString]];
    } else {
        [urlField_ setText:@"http://www.google.com/"];
    }

    return cell;
}

- (NSNumber*)defaultRowHeight:(UITableView *)tableView {
    return [NSNumber numberWithUnsignedInteger:48U];
}

@end

