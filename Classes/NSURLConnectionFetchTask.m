//
//  NSURLConnectionFetchTask.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "NSURLConnectionFetchTask.h"


@implementation NSURLConnectionFetchTask

- (void)dealloc {
    [error_ release];
    [response_ release];

    [super dealloc];
}

- (NSError*)error {
    return error_;
}

- (NSDictionary*)responseHeaders {
    return [response_ allHeaderFields];
}

#pragma mark FetchTaskProtectedMethods
- (void)performRequest {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self url]];
    [request addValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];

    [self setContentLength:[[NSURLConnection sendSynchronousRequest:request returningResponse:&response_ error:&error_] length]];

    [response_ retain];
    [error_ retain];

    [request release];

    if (error_) {
        NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), error_);
    }
}

@end
