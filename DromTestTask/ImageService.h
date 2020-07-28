//
//  ImageService.h
//  DromTestTask
//
//  Created by Oleg Samoylov on 28.07.2020.
//  Copyright © 2020 Oleg Samoylov. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface ImageService : NSObject

- (void)loadFromURL:(NSURL *)url callback:(void (^)(UIImage *image))callback;
- (void)clearCache;

@end
