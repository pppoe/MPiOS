//
//  MPAppDelegate.m
//  demo
//
//  Created by li haoxiang on 8/27/13.
//  Copyright (c) 2013 Haoxiang Li. All rights reserved.
//

#import "MPAppDelegate.h"
#import "MPGlowLabel.h"
#import "MPGradientButton.h"

@implementation MPAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MPGradientButton *btn1 = [[MPGradientButton alloc]
                             initWithFrame:CGRectMake(100, 100, 120, 44)
                             gradientColors:[NSArray arrayWithObjects:
                                             [UIColor yellowColor],
                                             [UIColor redColor], nil]
                             borderColor:[UIColor blackColor]
                             borderWith:1.0f
                             radius:8.0f];
    MPGradientButton *btn2 = [[MPGradientButton alloc]
                             initWithFrame:CGRectMake(100, 200, 120, 44)
                             gradientColors:[NSArray arrayWithObjects:
                                             [UIColor greenColor],
                                             [UIColor purpleColor], nil]
                             borderColor:[UIColor blackColor]
                             borderWith:1.0f
                             radius:8.0f];
    MPGradientButton *btn3 = [[MPGradientButton alloc]
                              initWithFrame:CGRectMake(100, 300, 120, 44)
                              gradientColors:[NSArray arrayWithObjects:
                                              [UIColor grayColor],
                                              [UIColor blueColor], nil]
                              borderColor:[UIColor blackColor]
                              borderWith:1.0f
                              radius:8.0f];
    [self.window addSubview:btn1];
    [self.window addSubview:btn2];
    [self.window addSubview:btn3];

    
    MPGlowLabel *label = [[MPGlowLabel alloc] initWithFrame:CGRectMake(100, 360, 120, 44)];
    [label setText:@"Glowing Label"];
    [self.window addSubview:label];
    [label resumeGlowing];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
