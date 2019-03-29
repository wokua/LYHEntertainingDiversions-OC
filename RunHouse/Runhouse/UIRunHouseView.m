//
//  UIRunHouseView.m
//  DrawTest
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 lrk. All rights reserved.
//

#import "UIRunHouseView.h"
#import "Quene.h"
#import "YYWeakProxy.h"

@interface UIRunHouseView()
{
    CGFloat _offSet;   //距离多少加载下一个view
    int _currentIndex;  //当前最后一个的角标
    CGRect _oldFrame;  //上一次的frame，动画会一直执行layoutsubviews
}

@property(nonatomic,strong)NSMutableArray<UIRunHouseItem *> * visibleViewArr; //可视item
@property(nonatomic,strong)NSMutableDictionary<NSString *,Quene<UIRunHouseItem *> *>  * reuseViewCache; //id->[item]缓存
@property(nonatomic,strong)NSMutableDictionary<NSString *,NSString *> * idCache; //Class->id 缓存
@property(nonatomic,strong)CADisplayLink * timer; //计时器
@property(nonatomic,assign)NSUInteger itemCount; //条目个数
@property(nonatomic,strong)NSMutableDictionary<NSNumber *,NSNumber *> * widthCache; //条目宽度缓存

@end

@implementation UIRunHouseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

//初始化数据
-(void)initData{
    self.timer = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(run)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:UITrackingRunLoopMode];
    self.visibleViewArr = [NSMutableArray array];
    self.reuseViewCache = [NSMutableDictionary new];
    self.widthCache = [NSMutableDictionary dictionary];
    self.idCache = [NSMutableDictionary dictionary];
    _space = 30;
    _offSet = 100;
    self.clipsToBounds = true;
}

#pragma mark 定时器
-(void)run{
    
    for (UIRunHouseItem * view in self.visibleViewArr) {
        view.transform = CGAffineTransformTranslate(view.transform,-1, 0);
    }
    [self updateView];
}

#pragma mark 更新view
-(void)updateView{
    
    CGFloat frameWidth = self.frame.size.width;

    UIRunHouseItem * lastShowView = self.visibleViewArr.lastObject;
    UIRunHouseItem * firstShowView = self.visibleViewArr.firstObject;

    //出页面，移除队列
    if (firstShowView.frame.origin.x + firstShowView.frame.size.width < 0) {
        [self.visibleViewArr removeObjectAtIndex:0];
        [self saveViewToCache:firstShowView];
    }
    
    CGFloat lastViewRight = lastShowView.frame.origin.x + lastShowView.frame.size.width;
    if (lastViewRight <= frameWidth + _offSet) {
        if (_currentIndex < self.itemCount - 1) {
            _currentIndex += 1;
        }else{
            _currentIndex = 0;
        }
        [self addItem:lastViewRight + _space];
    }
    
    
}

#pragma mark 刷新布局
-(void)reloadData{
 
    CGRect frame = self.frame;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat frameWidth = frame.size.width;
    CGFloat currentWidth = 0;
    [self clearCache];
    while (currentWidth < frameWidth + _offSet) {
        
        if (self.datasourse != nil){
            
            self.itemCount = [self.datasourse numberOfItemsInRunHouseView:self];
            CGFloat itemWidth = [self addItem:currentWidth];
            _currentIndex += 1;
            if (_currentIndex == self.itemCount) {
                _currentIndex = 0;
            }
            currentWidth += itemWidth + _space;
        }else{
            NSLog(@"runHouseViewError:datasourse nil");
            break;
        }
        
    }
}

#pragma mark 添加条目 返回新增item的宽度
-(CGFloat)addItem:(CGFloat)originX{
    
    CGRect frame = self.frame;
    CGFloat frameHeight = frame.size.height;
    CGFloat itemWidth = self.widthCache[[NSNumber numberWithInt:_currentIndex]].doubleValue;
    if (itemWidth == 0) {
        itemWidth =  [self.datasourse runHouseView:self widthForIndex:_currentIndex];
        self.widthCache[[NSNumber numberWithInt:_currentIndex]] = [NSNumber numberWithDouble:itemWidth];
    }
    UIRunHouseItem * item = [self.datasourse runHouseView:self itemForIndex:_currentIndex];
    item.frame = CGRectMake(originX, 0, itemWidth, frameHeight);
    [self addSubview:item];
    [self.visibleViewArr addObject:item];
    return itemWidth;
}


#pragma mark 刷新布局
- (void)layoutSubviews{
    
    
    CGRect frame = self.frame;
    if (_oldFrame.origin.x == self.frame.origin.x && _oldFrame.size.width == self.frame.size.width && _oldFrame.origin.y == self.frame.origin.y && _oldFrame.size.height == self.frame.size.height) {
        return;
    }
    _oldFrame = frame;
    [self reloadData];
}

#pragma mark 注册View
- (void)registerClass:(Class)classType forCellReuseIdentifier:(NSString *)reuseID{
  
    self.idCache[NSStringFromClass(classType)] = reuseID;
}
#pragma mark 获取重用view
- (UIRunHouseItem *)dequeneItemViewResueIdentity:(NSString *)resueIdentity{
    return [self getViewFromCacheWithId:resueIdentity];
}

//重用View加入缓存
-(void)saveViewToCache:(UIRunHouseItem *)item{
    NSString * resueIdentity = self.idCache[NSStringFromClass(item.class)];
    Quene * viewQuene = self.reuseViewCache[resueIdentity];
    if (viewQuene) {
        [viewQuene enquene:item];
    }else{
        self.reuseViewCache[resueIdentity] = [[Quene alloc]init:item];
    }
}

//从缓存中读取重用view
-(UIRunHouseItem *)getViewFromCacheWithId:(NSString *)resueIdentity{
    Quene<UIRunHouseItem *> * viewQuene = self.reuseViewCache[resueIdentity];
    return [viewQuene dequene];
}
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)clearCache{
    self.reuseViewCache = [NSMutableDictionary dictionary];
    self.widthCache = [NSMutableDictionary dictionary];
}
@end
