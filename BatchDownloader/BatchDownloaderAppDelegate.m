//
//  BatchDownloaderAppDelegate.m
//  BatchDownloader
//
//  Created by Ronald Li on 17/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BatchDownloaderAppDelegate.h"

@implementation BatchDownloaderAppDelegate
@synthesize progressIndicator;
@synthesize startTextField;
@synthesize endTextField;
@synthesize urlTextField;
@synthesize statusTextField;
@synthesize downloadButton;
@synthesize saveNameTextField;
@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self.progressIndicator setMinValue:0];
    [self.progressIndicator setUsesThreadedAnimation:YES];
    [self.statusTextField setStringValue:NSLocalizedString(@"Ready", @"Init text for status text field in BatchDownloaderAppDelegate")];
}

- (void)beginDownload:(id)sender
{
    NSString *url = [self.urlTextField stringValue];
    if ([url length] == 0){
        NSLog(@"Empty url");
        return;
    }
    NSInteger start;
    NSInteger end;
        start = [self.startTextField integerValue];
        end = [self.endTextField integerValue];
    if ([[self.startTextField stringValue] length] == 0 || [[self.endTextField stringValue] length] == 0){
        NSLog (@"Value for start or end missing");
        return;
    }
    // init the progress bar
    [self.progressIndicator setDoubleValue:0];
    [self.progressIndicator setMaxValue:(end - start)];
    
    Downloader *downloader = [[Downloader alloc] init];
    [downloader download:url start:start inclusiveEnd:end delegate:self];
}

- (void)updateStatus:(NSUInteger)index
{
    NSUInteger count = [[NSNumber numberWithDouble:[self.progressIndicator maxValue]] unsignedIntegerValue];
    NSString *status = nil;
    if (index == count) {
        // download finished
        status = NSLocalizedString(@"Ready", @"Text for idle status of status Text Field in BatchDownloaderAppDelegate");
    }else {
        status = [NSString stringWithFormat:NSLocalizedString(@"Downloading %i of %i file(s)", @"Text for status text field in BatchDownloaderAppDelegate"), index, [[NSNumber numberWithDouble:[self.progressIndicator maxValue]] integerValue]];
    }
    NSLog(@"%@", status);
    [self.statusTextField setStringValue:status];
}

- (void)downloader:(Downloader *)downloader didDownloadSingleUrl:(NSURL *)url
{
    [self.progressIndicator incrementBy:1];
    [self updateStatus:[[NSNumber numberWithDouble:[self.progressIndicator doubleValue]] integerValue]];
}

@end
