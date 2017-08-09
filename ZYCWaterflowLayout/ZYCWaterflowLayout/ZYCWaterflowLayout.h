//
//  ZYCWaterflowLayout.h
//  ZYCWaterflowLayout
//
//  Created by wpzyc on 2017/8/3.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCWaterflowLayout;
@protocol ZYCWaterflowLayoutDelegate <NSObject>

@required
- (CGFloat)waterflowLayout:(ZYCWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWid:(CGFloat)itemWid;
@optional
- (CGFloat)columnCountInWaterflowLayout:(ZYCWaterflowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(ZYCWaterflowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(ZYCWaterflowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZYCWaterflowLayout *)waterflowLayout;
@end


@interface ZYCWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property(nonatomic,weak) id <ZYCWaterflowLayoutDelegate> delegate;
//@property(nonatomic,assign)CGFloat rowMargin;
//@property(nonatomic,assign)CGFloat columnCount;
@end
