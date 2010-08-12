//
//  InfoCell.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "InfoCell.h"


@implementation InfoCell

+ (id)cell {
	InfoCell *cell = [[[InfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoCell"] autorelease];
    
    [[cell textLabel] setFont:[UIFont systemFontOfSize:13]];
	[[cell textLabel] setLineBreakMode:UILineBreakModeWordWrap];
	[[cell textLabel] setNumberOfLines:0];
	
	return cell;	
}

+ (NSUInteger)requiredHeightFor:(NSString *)description withTableWidth:(NSUInteger)tableWidth {
	int tablePadding = 40;
	int offset = 0;
	int textSize = 13;

	CGSize labelSize = [description sizeWithFont:[UIFont systemFontOfSize:textSize] 
                               constrainedToSize:CGSizeMake((tableWidth - tablePadding - offset), 1000) 
                                   lineBreakMode:UILineBreakModeWordWrap];

	if (labelSize.height < 48) {
		return 58;
	}
    
	return labelSize.height;
}

- (void)layoutSubviews {
	[super layoutSubviews];
    
	int tablePadding = 40;
	int tableWidth = [[self superview] frame].size.width;
     
    [[self textLabel] setFrame:CGRectMake(10, 10, tableWidth - tablePadding, 
                                          [[self class] requiredHeightFor:[[self textLabel] text] 
                                                                    withTableWidth:tableWidth])];	
}

@end
