//
//  Node.h
//  DrawTest
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 lrk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Node<T> : NSObject

@property(nonatomic,strong)Node<T> * next;
@property(nonatomic,strong)T data;

-(instancetype)init:(T)data;
@end

NS_ASSUME_NONNULL_END
