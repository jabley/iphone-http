//
//  FetchTask.m
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import "FetchTask.h"

@implementation FetchTask

@synthesize url = url_;
@synthesize contentLength = contentLength_;
@synthesize duration = duration_;

- (id)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        [self setUrl:url];
    }

    return self;
}

- (void)dealloc {
    [url_ release];

    [super dealloc];
}

#pragma mark -
#pragma mark FetchTask
- (void)main {
    [self execute];
}

- (void)execute {
    /* Template Method for doing the task. */
    [self setup];
    [self performRequest];
    [self tearDown];
}

- (NSError*)error {
    /* Ensure that subclasses provide an implementation. */
    [self doesNotRecognizeSelector:_cmd];
}

- (NSDictionary*)responseHeaders {
    /* Ensure that subclasses provide an implementation. */
    [self doesNotRecognizeSelector:_cmd];
}

#pragma mark -
#pragma mark ProtectedMethods
- (void)setup {
    startTime_ = [NSDate timeIntervalSinceReferenceDate];
}

- (void)performRequest {
    /* Ensure that subclasses provide an implementation. */
    [self doesNotRecognizeSelector:_cmd];
}

- (void)tearDown {
    endTime_ = [NSDate timeIntervalSinceReferenceDate];
    duration_ = endTime_ - startTime_;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"FetchTaskCompleted" object:nil];
}

@end
