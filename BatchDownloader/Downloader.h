//
//  Downloader.h
//  BatchDownloader
//
//  Created by Ronald Li on 17/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloaderDelegate;

@interface Downloader : NSObject {
@private
    id<DownloaderDelegate> _delegate;
    NSInteger _start;
    NSInteger _end;
    NSString *_url;
}
- (void)download:(NSString *)url start:(NSInteger)start inclusiveEnd:(NSInteger)end delegate:(id<DownloaderDelegate>)delegate;
@end

@protocol DownloaderDelegate <NSObject>
@required
- (void)downloader:(Downloader *)downloader didDownloadSingleUrl:(NSURL *)url;
@end