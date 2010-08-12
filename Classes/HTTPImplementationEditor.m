//
//  HTTPImplementationEditor.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "HTTPImplementationEditor.h"


@implementation HTTPImplementationEditor

@synthesize implementations = implementations_;
@synthesize keypath = keypath_;
@synthesize target = target_;

- (void)dealloc {
    [keypath_ release];
    [implementations_ release];
    [target_ release];

    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    return [[self implementations] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    }

    NSString *title = [[[self implementations] objectAtIndex:[indexPath row]] objectForKey:@"displayName"];

    [[cell textLabel] setText:title];

    if ([[[[self target] valueForKey:[self keypath]] objectForKey:@"displayName"] isEqualToString:title]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id implementation = [[self implementations] objectAtIndex:[indexPath row]];
    [[self target] setValue:implementation forKey:[self keypath]];
    [[self navigationController] popViewControllerAnimated:YES];
}


@end
