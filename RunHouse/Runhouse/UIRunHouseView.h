//
//  UIRunHouseView.h
//  DrawTest
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 lrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIRunHouseItem.h"
@class UIRunHouseView;

@protocol UIRunHouseViewDatasourse <NSObject>

@required
-(NSInteger)numberOfItemsInRunHouseView:(UIRunHouseView *)view;  //一共多少个item
-(CGFloat)runHouseView:(UIRunHouseView *)runHouseView widthForIndex:(int)index; //每个item的宽度
-(nullable UIRunHouseItem *)runHouseView:(UIRunHouseView *)runHouseView itemForIndex:(int)index;

@end

@protocol UIRunHouseViewDelegate <NSObject>

//点击事件等等保留

@end

NS_ASSUME_NONNULL_BEGIN

@interface UIRunHouseView : UIView
/*
 CGFloat _offSet;
 CGFloat _space;
 int _currentIndex;
 int _aa;
 CGRect _oldFrame;
*/
@property(nonatomic,weak)id<UIRunHouseViewDatasourse>datasourse;//数据源
@property(nonatomic,assign)CGFloat space; //item间距 默认30

-(void)reloadData; //刷新数据
-(void)registerClass:(Class)classType forCellReuseIdentifier:(nullable NSString *)reuseID; //注册重用View
-(UIRunHouseItem *)dequeneItemViewResueIdentity:(NSString *)resueIdentity; //获取重用View
-(void)clearCache;//清空缓存

@end

NS_ASSUME_NONNULL_END
