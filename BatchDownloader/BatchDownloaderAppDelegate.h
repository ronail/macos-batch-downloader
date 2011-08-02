//
//  BatchDownloaderAppDelegate.h
//  BatchDownloader
//
//  Created by Ronald Li on 17/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Downloader.h"

@interface BatchDownloaderAppDelegate : NSObject <NSApplicationDelegate, DownloaderDelegate> {
@private
    NSWindow *window;
    NSTextField *urlTextField;
    NSTextField *startTextField;
    NSTextField *endTextField;
    NSProgressIndicator *progressIndicator;
    NSButton *downloadButton;
    NSTextField *statusTextField;
    NSTextField *saveNameTextField;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet NSTextField *urlTextField;
@property (nonatomic, retain) IBOutlet NSTextField *startTextField;
@property (nonatomic, retain) IBOutlet NSTextField *endTextField;
@property (nonatomic, retain) IBOutlet NSProgressIndicator *progressIndicator;
@property (nonatomic, retain) IBOutlet NSButton *downloadButton;
@property (nonatomic, retain) IBOutlet NSTextField *statusTextField;
@property (nonatomic, retain) IBOutlet NSTextField *saveNameTextField;

- (IBAction) beginDownload:(id)sender;
@end
