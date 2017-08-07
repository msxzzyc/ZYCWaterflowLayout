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

@end
@interface ZYCWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property(nonatomic,weak)id<ZYCWaterflowLayoutDelegate> delegate;
@end
