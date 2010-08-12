//
//  FetchTask.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Interface defining a task to fetch a resource.
 */
@interface FetchTask : NSObject {

    NSURL *url_;

    NSUInteger contentLength_;

    NSTimeInterval duration_;

    NSTimeInterval startTime_;

    NSTimeInterval endTime_;

}

- (id)initWithURL:(NSURL*)url;

@property (nonatomic, retain) NSURL *url;

@property (nonatomic) NSUInteger contentLength;

@property (nonatomic, readonly) NSTimeInterval duration;

@property (nonatomic, readonly) NSDictionary *responseHeaders;

@property (nonatomic, readonly) NSError *error;

- (void)execute;

@end

@interface FetchTask(FetchTaskProtectedMethods)

- (void)performRequest;

- (void)setup;

- (void)tearDown;

@end

