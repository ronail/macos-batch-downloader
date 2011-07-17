//
//  Downloader.m
//  BatchDownloader
//
//  Created by Ronald Li on 17/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Downloader.h"

@interface Downloader (){
    
}
@property (nonatomic, retain) id<DownloaderDelegate> delegate;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger end;
@property (nonatomic, retain) NSString *url;
- (NSString *)fileSavePath;
- (void)didDownloadSingleUrl:(NSURL *)url;
- (void)doDownloadUrlToDirectory:(NSString *)fileDir;
@end

@implementation Downloader
@synthesize delegate=_delegate;
@synthesize start=_start;
@synthesize end=_end;
@synthesize url=_url;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)download:(NSString *)url start:(NSInteger)start inclusiveEnd:(NSInteger)end delegate:(id<DownloaderDelegate>)delegate
{
    self.delegate = delegate;
    // check if the url contain a %@ variable
    NSRange variableRange = [url rangeOfString:@"%@"];
    if (variableRange.location == NSNotFound){
        NSLog(@"%%@ not found");
        return;
    }
    
    // check if end > start
    if (end < start){
        NSLog(@"Ending number is smaller than starting number");
        return;
    }
    self.start = start;
    self.end = end;
    self.url = url;
    NSString *fileDir = [self fileSavePath];
    
    [self performSelectorInBackground:@selector(doDownloadUrlToDirectory:) withObject:fileDir];
}

- (void)doDownloadUrlToDirectory:(NSString *)fileDir
{
    NSAutoreleasePool *pool = nil;
    if (![NSThread isMainThread]){
        pool = [[NSAutoreleasePool alloc] init];
    }
    for (NSInteger i = self.start; i <= self.end; i++) {
        NSURL *replacedUrl = [NSURL URLWithString:[NSString stringWithFormat:self.url, [[NSNumber numberWithInteger:i] stringValue]]];
        
        NSData *data = [NSData dataWithContentsOfURL:replacedUrl];
        NSString *filepath = [fileDir stringByAppendingString:[replacedUrl lastPathComponent]];
        NSLog(@"Saved file %@", filepath);
        [data writeToFile: filepath  atomically:YES];
        if(self.delegate != nil) {
            [self performSelectorOnMainThread:@selector(didDownloadSingleUrl:) withObject:replacedUrl waitUntilDone:NO];
        }
    }
    if (nil != pool)
        [pool drain];
}

- (void)didDownloadSingleUrl:(NSURL *)url
{
    [self.delegate downloader:self didDownloadSingleUrl:url];
}

- (NSString *)fileSavePath
{
    NSOpenPanel *panel = [[NSOpenPanel alloc] init];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    if ([panel runModal] == NSOKButton) {
        NSString *filename = [[panel filenames] objectAtIndex:0];
        return [filename stringByAppendingString:@"/"];
    }
    return nil;
}
@end
