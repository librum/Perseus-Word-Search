//
//  AppDelegate.m
//  Perseus Word Search
//
//  Created by Claudio Capobianco on 26/02/13.
//  Copyright (c) 2013 Librum. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self showWindow];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)showWindow {
    
    if (!self.window) {
        [NSBundle loadNibNamed:@"searchWindow" owner:self];
    }
    
    //[self.window makeKeyAndOrderFront:self];

}

@end
