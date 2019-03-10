//
//  LYHImageTitleVIew.m
//  RunHouse
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 LHR. All rights reserved.
//

#import "LYHImageTitleVIew.h"
#import "Masonry.h"

@implementation LYHImageTitleVIew

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.imageView = [UIImageView new];
    self.label = [UILabel new];
    
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(5);
        make.width.mas_equalTo(self.imageView.mas_height);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).offset(5);
        make.centerY.mas_equalTo(self);
    }];
    
}

@end
