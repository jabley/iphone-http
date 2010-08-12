//
//  HTTPImplementationEditor.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright 2010 Mobile IQ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTTPImplementationEditor : UITableViewController {

    NSObject *target_;

    NSString *keypath_;

    NSArray *implementations_;
}

@property (nonatomic, copy) NSString *keypath;

@property (nonatomic, retain) NSArray *implementations;

@property (nonatomic, retain) NSObject *target;

@end
