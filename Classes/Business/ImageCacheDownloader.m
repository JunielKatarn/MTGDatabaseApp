//
//  ImageCacheDownloader.m
//  MTG Deck Builder
//
//  Created by Kyle Hankinson on 10-09-02.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageCacheDownloader.h"
#import "AppDelegate.h"
#import "MTGCard.h"

@interface ImageCacheDownloader ()
@end

@implementation ImageCacheDownloader

id<ImageCacheDownloaderProtocol> delegate;
static NSOperationQueue * downloadQueue = nil;

+ (void) initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadQueue = [[NSOperationQueue alloc] init];
        downloadQueue.maxConcurrentOperationCount = 5;
        [downloadQueue setSuspended: YES];
        [self initializeDownloads];
    });
}

+ (void) setDelegate: (id<ImageCacheDownloaderProtocol>) _delegate
{
    delegate = _delegate;
}

+ (BOOL) enabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey: @"AutoDownloadImages"];
}

+ (void) setEnabled: (BOOL) enabled
{
    [[NSUserDefaults standardUserDefaults] setBool: enabled
                                            forKey: @"AutoDownloadImages"];
}

+ (void) setPaused: (BOOL) paused
{
    [downloadQueue setSuspended: paused];
} // End of setPaused

+ (void) initializeDownloads
{
    NSError * error = nil;
    @autoreleasepool
    {
        NSArray * fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath: [AppDelegate cardsPath]
                                                                                 error: &error];

        NSLog(@"FileList count:  %ld", (long) fileList.count);
    } // End of autorelease

    [[AppDelegate databaseQueue] inDatabase: ^(FMDatabase * database) {
        FMResultSet * results = [database executeQuery: @"SELECT DISTINCT multiverseId FROM card"];

        while ([results next])
        {
            NSInteger multiverseId = (NSInteger)[results longForColumnIndex: 0];
            NSBlockOperation * blockOperation = [NSBlockOperation blockOperationWithBlock: ^{
                // Download the images
                [self downloadImageForMultiverseId: multiverseId];
            }];

            blockOperation.qualityOfService = NSQualityOfServiceBackground;
            [downloadQueue addOperation: blockOperation];
        } // End of while loop
    }];
} // End of startDownload

+ (void) downloadImageForMultiverseId: (NSInteger) multiverseId
{
    NSString * fileName = [NSString stringWithFormat: @"%ld.jpg", (long)multiverseId];
    NSString * path = [NSString stringWithFormat: @"%@/%@", [AppDelegate cardsPath], fileName];

    // Already exists. Exit.
    if([[NSFileManager defaultManager] fileExistsAtPath: path])
    {
        return;
    }
/*
    NSData * data = [NSData dataWithContentsOfURL: [NSURL URLWithString: [MTGCard pathForMultiverseId: multiverseId]]];
    if(data)
    {
        [data writeToFile: path
               atomically: YES];

        [delegate imageCacheProgressChanged: 0];
    } // Write to file
*/
}

@end
