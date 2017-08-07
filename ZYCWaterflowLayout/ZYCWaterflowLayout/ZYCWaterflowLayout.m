//
//  ZYCWaterflowLayout.m
//  ZYCWaterflowLayout
//
//  Created by wpzyc on 2017/8/3.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ZYCWaterflowLayout.h"
/** 默认列数*/
static const CGFloat ZYCDefaultColumnCount = 3;
/** 列间间距*/
static const CGFloat ZYCDefaultColumnMargin = 10;
/** 行间间距*/
static const CGFloat ZYCDefaultRowMargin = 10;
/** 边缘间距*/
static const UIEdgeInsets ZYCDefaultEdgeInsets = {10,10,10,10};
@interface ZYCWaterflowLayout()
/** 存放所有cell的布局属性*/
@property(nonatomic,strong)NSMutableArray *attrsArray;
/** 存放所有列的当前高度*/
@property(nonatomic,strong)NSMutableArray *columnHeights;
@end
@implementation ZYCWaterflowLayout
- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}
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
    //清除以前计算的所有高度
    [self.attrsArray removeAllObjects];
    for (NSInteger i = 0; i<ZYCDefaultColumnCount; i++) {
        [self.columnHeights addObject:@(ZYCDefaultEdgeInsets.top)];
    }
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
    
    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //设置布局属性的frame
    CGFloat w = (collectionViewW - ZYCDefaultEdgeInsets.left- ZYCDefaultEdgeInsets.right -(ZYCDefaultColumnCount - 1)*ZYCDefaultColumnMargin)/ZYCDefaultColumnCount;
    
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndex:indexPath.item itemWid:w];
    //找出高度最短的那一列
//    __block NSInteger destColumn = 0;
//    __block CGFloat minColumnHeight = MAXFLOAT;
//    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber  *columnHeightNumber, NSUInteger idx, BOOL *stop) {
//        CGFloat columnHeight = columnHeightNumber.doubleValue;
//        if (minColumnHeight>columnHeight) {
//            minColumnHeight = columnHeight;
//            destColumn = idx;
//        }
//    }];
    
    //找出高度最短的那一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i<ZYCDefaultColumnCount; i++) {
        //取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat x = ZYCDefaultEdgeInsets.left + (w+ZYCDefaultColumnMargin)*destColumn;
    CGFloat y = minColumnHeight;
    if (y != ZYCDefaultEdgeInsets.top) {//非第一行
        y += ZYCDefaultRowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    //更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    return attrs;
}

- (CGSize)collectionViewContentSize
{
    //找出高度最长的那一列
    NSInteger destColumn = 0;
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i<ZYCDefaultColumnCount; i++) {
        //取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    return CGSizeMake(0, maxColumnHeight + ZYCDefaultEdgeInsets.bottom);
}
@end
