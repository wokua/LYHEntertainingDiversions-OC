//
//  ViewController.m
//  RunHouse
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 LHR. All rights reserved.
//

#import "ViewController.h"
#import "UIRunHouseView.h"
#import "LYHCustomRunHouseView.h"
#import "LYHImageTitleVIew.h"

@interface ViewController ()<UIRunHouseViewDatasourse>
@property(nonatomic,strong)NSArray * datas;
@property(nonatomic,strong)UIRunHouseView * runHouse;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    self.runHouse = [[UIRunHouseView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    self.runHouse.datasourse = self;
    [self.runHouse registerClass:LYHCustomRunHouseView.class forCellReuseIdentifier:@"LYHCustomRunHouseView"];
    [self.runHouse registerClass:LYHImageTitleVIew.class forCellReuseIdentifier:@"LYHImageTitleVIew"];
    [self.view addSubview:self.runHouse];

    self.datas = @[@"gvhbfdjnklsadlkfnjbnkmls",@"djnfkmaldksfjbnknd",@"jdkadajsdklasjd",@"sdhdsjaksd",@"sjnasjahdkjahsd",@"21678923643923764382187492180376479180378490"];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.runHouse removeFromSuperview];
//    self.runHouse = nil;
//}

- (NSInteger)numberOfItemsInRunHouseView:(UIRunHouseView *)view{
    return self.datas.count;
}

- (UIRunHouseItem *)runHouseView:(UIRunHouseView *)runHouseView itemForIndex:(int)index{
    if (index % 2 == 0) {
        LYHCustomRunHouseView * item = (LYHCustomRunHouseView *)[runHouseView dequeneItemViewResueIdentity:@"LYHCustomRunHouseView"];
        if (item == nil) {
            item = [LYHCustomRunHouseView new];
        }
        item.backgroundColor = [UIColor redColor];
        item.label.text = self.datas[index];
        return item;
    }else{
        LYHImageTitleVIew * item = (LYHImageTitleVIew *)[runHouseView dequeneItemViewResueIdentity:@"LYHImageTitleVIew"];
        if (item == nil) {
            item = [LYHImageTitleVIew new];
        }
        item.backgroundColor = [UIColor redColor];
        item.label.text = self.datas[index];
        item.imageView.image = [UIImage imageNamed:@"Image"];
        return item;
    }
   
}

- (CGFloat)runHouseView:(UIRunHouseView *)runHouseView widthForIndex:(int)index{
    NSString * str = self.datas[index];
    UIFont * font = [UIFont systemFontOfSize:20];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, 40) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font}context:nil];
    if (index % 2 == 0) {
          return rect.size.width + 10;
    }else{
        return rect.size.width + 30;
    }
  
}

@end
