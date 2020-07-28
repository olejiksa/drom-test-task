//
//  CollectionViewConfigurator.m
//  DromTestTask
//
//  Created by Oleg Samoylov on 28.07.2020.
//  Copyright © 2020 Oleg Samoylov. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionViewConfigurator.h"
#import "ImageService.h"

@interface CollectionViewConfigurator ()

@property (nonatomic, nonnull, strong) ImageService *imageService;
@property (nonatomic, nonnull, strong) NSArray *urls;
@property (nonatomic, nonnull, strong) NSMutableArray *localUrls;

@end

@implementation CollectionViewConfigurator

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageService = [ImageService new];
        self.urls = [NSArray arrayWithObjects:
                     @"https://www.freepnglogos.com/uploads/volkswagen-car-logo-png-brand-image-0.png",
                     @"https://www.freepnglogos.com/uploads/cars-logo-brands-png-images-30.png",
                     @"https://www.freepnglogos.com/uploads/bmw-car-logo-png-brand-image-2.png",
                     @"https://www.freepnglogos.com/uploads/alfa-romeo-car-logo-png-brand-image-29.png",
                     @"https://www.freepnglogos.com/uploads/skoda-car-logo-png-brand-image-32.png",
                     @"https://www.freepnglogos.com/uploads/mercedes-benz-car-logo-png-brand-image-1.png", nil];
        self.localUrls = [self.urls mutableCopy];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.localUrls.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = NSStringFromClass([CollectionViewCell class]);
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row >= self.localUrls.count) {
        return cell;
    }
    NSString *string = self.localUrls[indexPath.row];
    [self.imageService loadFromURL:[NSURL URLWithString:string] callback:^(UIImage *image) {
        [cell setImage:image];
    }];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (![cell isImageLoaded]) {
        return;
    }
    
    [UIView animateWithDuration:2 animations:^{
        CGFloat cellWidth = CGRectGetWidth(UIScreen.mainScreen.bounds);
        cell.transform = CGAffineTransformMakeTranslation(-cellWidth, 0);
    } completion:nil];
    
    [collectionView performBatchUpdates:^{
        [self.localUrls removeObjectAtIndex:indexPath.item];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:nil];
}

#pragma mark - Public

- (void)forceReload {
    self.localUrls = [self.urls mutableCopy];
    [self.imageService clearCache];
}

@end
