//
//  Node.m
//  DrawTest
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 lrk. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)init:(id)data{
    
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}


@end
