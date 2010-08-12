//
//  NSURLConnectionFetchTask.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchTask.h"

@interface NSURLConnectionFetchTask : FetchTask {

    NSHTTPURLResponse *response_;

    NSError *error_;

}

@end
