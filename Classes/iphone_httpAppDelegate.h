//
//  iphone_httpAppDelegate.h
//  iphone-http
//
//  Created by James Abley on 12/08/2010.
//  Copyright Mobile IQ Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iphone_httpAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

