//
//  ImageService.m
//  DromTestTask
//
//  Created by Oleg Samoylov on 28.07.2020.
//  Copyright © 2020 Oleg Samoylov. All rights reserved.
//

#import "ImageService.h"

@interface ImageService ()

@property (nonatomic, nonnull, strong) NSCache *imageCache;

@end

@implementation ImageService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)loadFromURL:(NSURL *)url callback:(void (^)(UIImage *image))callback {
    UIImage *cachedImage = [self.imageCache objectForKey:url.absoluteString];
    if (cachedImage) {
        callback(cachedImage);
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            if (image) {
                [self.imageCache setObject:image forKey:url.absoluteString];
            }
            
            callback(image);
        });
    });
}

- (void)clearCache {
    [self.imageCache removeAllObjects];
}

@end
