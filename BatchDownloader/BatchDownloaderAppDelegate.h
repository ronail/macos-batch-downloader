//
//  BatchDownloaderAppDelegate.h
//  BatchDownloader
//
//  Created by Ronald Li on 17/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BatchDownloaderAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
