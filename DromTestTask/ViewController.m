//
//  ViewController.m
//  DromTestTask
//
//  Created by Oleg Samoylov on 28.07.2020.
//  Copyright © 2020 Oleg Samoylov. All rights reserved.
//

#import "CollectionViewCell.h"
#import "CollectionViewConfigurator.h"
#import "CollectionViewLayout.h"
#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate>

@property (nonatomic, nonnull, strong) UICollectionView *collectionView;
@property (nonatomic, nonnull, strong) UIRefreshControl *refreshControl;
@property (nonatomic, nonnull, strong) CollectionViewConfigurator *configurator;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configurator = [CollectionViewConfigurator new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupCollectionView];
    [self setupRefreshControl];
}

- (void)loadView {
    [super loadView];
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = UIColor.systemBackgroundColor;
    } else {
        self.view.backgroundColor = UIColor.whiteColor;
    }
}

#pragma mark - UI

- (void)setupNavigationBar {
    self.title = @"Заголовок";
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
}

- (void)setupCollectionView {
    CollectionViewLayout *layout = [CollectionViewLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.dataSource = self.configurator;
    self.collectionView.delegate = self.configurator;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [self.view addSubview:self.collectionView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.view.topAnchor constraintEqualToAnchor:self.collectionView.topAnchor],
        [self.view.leadingAnchor constraintEqualToAnchor:self.collectionView.leadingAnchor],
        [self.view.trailingAnchor constraintEqualToAnchor:self.collectionView.trailingAnchor],
        [self.view.bottomAnchor constraintEqualToAnchor:self.collectionView.bottomAnchor]
    ]];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Потяните для обновления"];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 10.0, *)) {
        self.collectionView.refreshControl = self.refreshControl;
    } else {
        [self.collectionView addSubview:self.refreshControl];
    }
}

- (void)refresh {
    [self.configurator forceReload];
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
}

@end
