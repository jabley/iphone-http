//
//  ResponseDetailViewController.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FetchTask.h"

/**
 UITableViewController responsible for presenting the response detail of an executed FetchTask.
 */
@interface ResponseDetailViewController : UITableViewController {

    FetchTask *task_;

    UITextView *responseField_; // weak
}

- (id)initWithFetchTask:(FetchTask*)task;

@end
