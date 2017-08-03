//
//  ViewController.m
//  ZYCWaterflowLayout
//
//  Created by wpzyc on 2017/8/3.
//  Copyright © 2017年 wpzyc. All rights reserved.
//

#import "ViewController.h"
#import "ZYCWaterflowLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation ViewController
static NSString *const shopId = @"shop";
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建布局
    UICollectionViewLayout *layout = [[ZYCWaterflowLayout alloc]init];
    //创建collentionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.dataSource = self;
    //注册
    [collectionView registerClass:[UICollectionViewCell class]forCellWithReuseIdentifier:shopId];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

@end
