//
//  Quene.h
//  DrawTest
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 lrk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Quene<T>: NSObject

-(int)count;
-(void)enquene:(T)data;
-(T)dequene;
-(T)top;
-(BOOL)isEmpty;
-(void)clear;

-(instancetype)init:(T)data;
@end

NS_ASSUME_NONNULL_END
