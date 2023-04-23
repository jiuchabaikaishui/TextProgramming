//
//  main.m
//  TextProgramming
//
//  Created by QSP on 2022/11/19.
//

#import <UIKit/UIKit.h>
#import "TPAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([TPAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
