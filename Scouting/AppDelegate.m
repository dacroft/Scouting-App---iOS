//
//  AppDelegate.m
//  Scouting
//
//  Created by Doug Croft on 2/24/15.
//  Copyright (c) 2015 Doug Croft. All rights reserved.
//

#import "AppDelegate.h"

//#import <AFNetworkReachabilityManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Allow saving via Parse
    
    [Parse enableLocalDatastore];
    [Parse setApplicationId:@"8ExTEoeHhV5ANaA9wBHJ8ZAgBpJYIQvbKQ8m4P87"
                  clientKey:@"218c1A4anSh9cAgiyJjBIS8wPfKEUXkF2za754lf"];
    
//    // By default, all users are allowed to modify all objects.
//    ParseUser.enableAutomaticUser();
//    ParseACL defaultACL = new ParseACL();
//    defaultACL.setPublicReadAccess(true);
//    ParseACL.setDefaultACL(defaultACL, true);
    
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        NSLog(@"Reachability changed: %@", AFStringFromNetworkReachabilityStatus(status));
//        
//        
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                // -- Reachable -- //
//                NSLog(@"Reachable");
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//            default:
//                // -- Not reachable -- //
//                NSLog(@"Not Reachable");
//                break;
//        }
//        
//    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
