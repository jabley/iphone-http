//
//  InfoCell.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InfoCell : UITableViewCell {

}

/**
 Factory method for creating a cell instance.
 */
+ (id)cell;

/**
 Returns the height required to display the text.
 @param description - the text to be displayed
 @param tableWidth - the width of the containing table
 */
+ (NSUInteger)requiredHeightFor:(NSString *)description withTableWidth:(NSUInteger)tableWidth;

@end
