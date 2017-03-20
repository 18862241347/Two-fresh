//
//  UITableViewCell+common.m
//  绿色家园
//
//  Created by yons on 15/12/30.
//  Copyright (c) 2015年 蒋玉顺. All rights reserved.
//

#import "UITableViewCell+common.h"

@implementation UITableViewCell (common)
+ (UINib *)returnNib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}
+ (NSString *)returnDefaultReuseIdentifier {
    return NSStringFromClass(self);
}
+ (void)autoRegistNibForTableView:(UITableView *)tableView {
    [tableView registerNib:[self returnNib] forCellReuseIdentifier:[self returnDefaultReuseIdentifier]];
}
+ (void)autoRegistClassForTableView:(UITableView *)tableView {
    [tableView registerClass:self forCellReuseIdentifier:[self returnDefaultReuseIdentifier]];
}
+(instancetype)cellWithTableView:(UITableView *)tableView 
{
    NSString *ID =[self returnDefaultReuseIdentifier];
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
     cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    

}
@end
@implementation UICollectionViewCell (quick)

+ (UINib *)returnNib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}
+ (NSString *)returnDefaultReuseIdentifier
{
    return NSStringFromClass(self);
}

/**
 *   注册一个 CollectionView Nib
 *
 */
+ (void)autoRegistNibForCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerNib:[self returnNib] forCellWithReuseIdentifier:[self returnDefaultReuseIdentifier]];
}
/**
 *   注册一个 CollectionView Class
 *
 */
+ (void)autoRegistClassForCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:self forCellWithReuseIdentifier:[self returnDefaultReuseIdentifier]];
    
    
}
/**
 *   注册一个 collectionView  解决它的重用
 *
 */
+ (instancetype)collectionViewWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath*)indexPath
{
    
    NSString *ID =[self returnDefaultReuseIdentifier];
    UICollectionViewCell *collection= [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return collection;
}
@end