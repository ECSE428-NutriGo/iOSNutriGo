//
//  AppDelegate.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-03.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LoginSignUpViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.window.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:238.0/255.0 blue:255.0/255.0 alpha:1];
    UIViewController *homeViewController = [[LoginSignUpViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [self.navController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navController.navigationBar removeFromSuperview];
    [self.window setRootViewController:navController];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
