//
//  ASIHTTPRequestFetchTask.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchTask.h"
#import "ASIHTTPRequest.h"

@interface ASIHTTPRequestFetchTask : FetchTask {

    ASIHTTPRequest *request_;

}

@end
