//
//  AppDelegate.m
//  TextProgramming
//
//  Created by QSP on 2022/11/19.
//

#import "TPAppDelegate.h"
#import "TPMainController.h"

@interface TPAppDelegate ()

@end

@implementation TPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    TPMainController *mainController = [[TPMainController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = navController;
    [self.window makeKeyWindow];
    
    return YES;
}


@end
