//
//  DetailCell.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "DetailCell.h"


@implementation DetailCell


+ (id)cell {
	DetailCell *cell = [[[DetailCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"HeaderCell"] autorelease];
	[[cell detailTextLabel] setTextAlignment:UITextAlignmentLeft];
	[[cell detailTextLabel] setFont:[UIFont systemFontOfSize:14]];
	return cell;
}

- (void)layoutSubviews {
	[super layoutSubviews];

    int tablePadding = 40;

	[[self textLabel] setFrame:CGRectMake(5, 5, 120, 20)];
	[[self detailTextLabel] setFrame:CGRectMake(135, 5, ([self frame].size.width - 145 - tablePadding), 20)];
}

@end
