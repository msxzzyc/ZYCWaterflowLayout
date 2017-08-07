//
//  ViewController.m
//  ZYCWaterflowLayout
//
//  Created by wpzyc on 2017/8/3.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ViewController.h"
#import "ZYCWaterflowLayout.h"
#import "XMGShop.h"
#import "XMGShopCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZYCWaterflowLayoutDelegate>
/** 所有的商品数据 */
@property(nonatomic,strong)NSMutableArray *shops;
@property(nonatomic,weak)UICollectionView *collectionView;
@end
@implementation ViewController
static NSString *const shopId = @"shop";
- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayout];
    [self setUpRefresh];
}
- (void)setUpRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    
    [self.collectionView.header beginRefreshing];
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}
- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [XMGShop objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    });
}
- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [XMGShop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    });
}
- (void)setUpLayout
{
    //创建布局
    ZYCWaterflowLayout *layout = [[ZYCWaterflowLayout alloc]init];
    layout.delegate = self;
    //创建collentionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGShopCell class]) bundle:nil] forCellWithReuseIdentifier:shopId];
    collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopId forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}
#pragma mark - ZYCWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(ZYCWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWid:(CGFloat)itemWid
{
    XMGShop *shop = self.shops[index];
    return itemWid *shop.h/shop.w;
    
}
@end
