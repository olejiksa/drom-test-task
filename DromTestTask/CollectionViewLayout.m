//
//  CollectionViewLayout.m
//  DromTestTask
//
//  Created by Oleg Samoylov on 28.07.2020.
//  Copyright © 2020 Oleg Samoylov. All rights reserved.
//

#import "CollectionViewLayout.h"

@implementation CollectionViewLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat inset = 10;
    CGFloat length;
    switch (UIApplication.sharedApplication.statusBarOrientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        case UIInterfaceOrientationUnknown:
            length = CGRectGetWidth(UIScreen.mainScreen.bounds) - 2 * inset;
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            length = CGRectGetHeight(UIScreen.mainScreen.bounds) - 2 * inset;
            break;
    }
    self.itemSize = CGSizeMake(length, length);
    self.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
}

@end
