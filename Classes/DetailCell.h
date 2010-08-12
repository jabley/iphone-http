//
//  DetailCell.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 UITableViewCell implementation for showing Response header detail. Needed to give greater control over layout.
 */
@interface DetailCell : UITableViewCell {

}

/**
 Factory method for creating a cell.
 */
+ (id)cell;

@end
