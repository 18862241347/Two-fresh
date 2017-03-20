//
//  UITableViewCell+common.h
//  绿色家园
//
//  Created by yons on 15/12/30.
//  Copyright (c) 2015年 蒋玉顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (common)
//  
+ (UINib *)returnNib;
+ (NSString *)returnDefaultReuseIdentifier;

/**
 *   注册一个 cellNib
 *
 */
+ (void)autoRegistNibForTableView:(UITableView *)tableView;
/**
 *   注册一个 cellClass
 *
 */
+ (void)autoRegistClassForTableView:(UITableView *)tableView;


/**
 *   注册一个 cell  解决它的重用
 *
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
@interface UICollectionViewCell (quick)

+ (UINib *)returnNib;

+ (NSString *)returnDefaultReuseIdentifier;

/**
 *   注册一个 CollectionView Nib
 *
 */
+ (void)autoRegistNibForCollectionView:(UICollectionView *)collectionView;
/**
 *   注册一个 CollectionView Class
 *
 */
+ (void)autoRegistClassForCollectionView:(UICollectionView *)collectionView;


/**
 *   注册一个 collectionView  解决它的重用
 *
 */
+ (instancetype)collectionViewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath*)indexPath;
@end
