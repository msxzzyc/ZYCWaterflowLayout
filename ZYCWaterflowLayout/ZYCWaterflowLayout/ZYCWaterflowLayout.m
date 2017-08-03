//
//  ZYCWaterflowLayout.m
//  ZYCWaterflowLayout
//
//  Created by wpzyc on 2017/8/3.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCWaterflowLayout.h"
@interface ZYCWaterflowLayout()
/** 存放所有cell的布局属性*/
@property(nonatomic,strong)NSMutableArray *attrsArray;
@end
@implementation ZYCWaterflowLayout
- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
/**  初始化 */
- (void)prepareLayout
{
    [super prepareLayout];
    [self.attrsArray removeAllObjects];
    //创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i<count; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray addObject:attrs];
    }
}
/** 决定cell的排布 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attrsArray;
    
}
/** 返回indexPath 位置cell对应的布局属性 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //设置布局属性的frame
    attrs.frame = CGRectMake(arc4random_uniform(300), arc4random_uniform(300), arc4random_uniform(300), arc4random_uniform(300));
    
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    
    return CGSizeMake(0, 1000);
}
@end
