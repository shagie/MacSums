//
//  MacSumsAppDelegate.h
//  MacSums
//
//  Created by Michael on 2/24/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MacSumsAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
