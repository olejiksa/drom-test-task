//
//  CollectionViewCell.m
//  DromTestTask
//
//  Created by Oleg Samoylov on 28.07.2020.
//  Copyright © 2020 Oleg Samoylov. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (nonatomic, nonnull, strong) UIImageView *imageView;

@end

@implementation CollectionViewCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstraints];
    }
    return self;
}

- (void)prepareForReuse {
    self.imageView.image = nil;
}

#pragma mark - Public

- (BOOL)isImageLoaded {
    return self.imageView.image != nil;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

#pragma mark - Private

- (void)setupUI {
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.imageView];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.topAnchor constraintEqualToAnchor:self.imageView.topAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor]
    ]];
}

@end
