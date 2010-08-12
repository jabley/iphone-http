//
//  ResponseDetailViewController.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "ResponseDetailViewController.h"
#import "DetailCell.h"

@implementation ResponseDetailViewController


#pragma mark -
#pragma mark Initialization

- (id)initWithFetchTask:(FetchTask *)task {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        task_ = task;
    }

    return self;
}

#pragma mark -
#pragma mark View lifecycle

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return [[task_ responseHeaders] count];
        }
        case 1: {
            return 1;
        }
        default:
            return 1;
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;

    int tablePadding = 40;
	int tableWidth = [tableView frame].size.width;

    switch ([indexPath section]) {
        case 0: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];

            if (!cell) {
                cell = [DetailCell cell];
            }

            NSString *key = [[[task_ responseHeaders] allKeys] objectAtIndex:[indexPath row]];
            [[cell textLabel] setText:key];
            [[cell detailTextLabel] setText:[[task_ responseHeaders] objectForKey:key]];

            break;
        }
        case 1: {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ResponseCell"];

            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResponseCell"] autorelease];
                responseField_ = [[[UITextView alloc] initWithFrame:CGRectZero] autorelease];
                [responseField_ setBackgroundColor:[UIColor clearColor]];
                [[cell contentView] addSubview:responseField_];
            }

            [responseField_ setFrame:CGRectMake(5, 5, (tableWidth - tablePadding), 150)];
            [responseField_ setText:@"Not implemented"];

            break;
        }

        default:
            break;
    }

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Response Headers";
        case 1:
            return @"Response body";
        default:
            return nil;
    }
}

#pragma mark -
#pragma mark Table view delegate
- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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
    // Don't need to release the responseField_ ivar since it is weakly-referenced.

    [super dealloc];
}


@end

