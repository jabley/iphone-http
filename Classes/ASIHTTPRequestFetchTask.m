//
//  ASIHTTPRequestFetchTask.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "ASIHTTPRequestFetchTask.h"


@implementation ASIHTTPRequestFetchTask

- (void)dealloc {
    [request_ release];

    [super dealloc];
}

- (NSError*)error {
    return [request_ error];
}

- (NSDictionary*)responseHeaders {
    return [request_ responseHeaders];
}

#pragma mark -
#pragma mark FetchTaskProtectedMethods
- (void)performRequest {

    request_ = [[ASIHTTPRequest requestWithURL:[self url]] retain];
    [request_ addRequestHeader:@"User-Agent" value:@"iPhone"];
    [request_ startSynchronous];

    if ([request_ error]) {
        NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), [request_ error]);
    } else {
        [self setContentLength:[[request_ responseData] length]];
    }
}

@end
