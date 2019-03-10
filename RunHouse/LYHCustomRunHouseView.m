//
//  LYHCustomRunHouseVIew.m
//  RunHouse
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 LHR. All rights reserved.
//

#import "LYHCustomRunHouseView.h"
#import "Masonry.h"

@implementation LYHCustomRunHouseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)prepareForReuse{
    self.label.text = nil;
}

-(void)creatUI{
    self.label = [UILabel new];
    self.label.textAlignment = NSTextAlignmentLeft;
    self.label.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.label];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
  
}

@end
