//
//  RootViewController.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright Mobile IQ Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Main view controller of the application.
 */
@interface RootViewController : UITableViewController {

    /**
     The URL.
     */
    UITextField *urlField_;

    /**
     The Go! button.
     */
    UIButton *goButton_;

    /**
     The array of dictionaries of available http clients.
     */
    NSArray *httpClients_;

    /**
     The currently selected http client.
     */
    NSMutableDictionary *httpClient_;

    /**
     Array of dictionaries describing cell / row creation logic.
     */
    NSArray *cellStructures_;
}

/**
 The currently selected http client.
 */
@property (nonatomic, retain) NSMutableDictionary* httpClient;

@end
