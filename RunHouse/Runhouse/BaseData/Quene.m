//
//  Quene.m
//  DrawTest
//
//  Created by lrk on 2019/2/28.
//  Copyright © 2019 lrk. All rights reserved.
//

#import "Quene.h"
#import "Node.h"

@interface Quene<T>()

@property(nonatomic,strong)Node<T> *firstNode;
@property(nonatomic,strong)Node<T> *lastNode;

@end

@implementation Quene

- (instancetype)init:(id)data{
    self = [super init];
    if (self) {
        Node * node = [[Node alloc]init:data];
        self.firstNode = node;
        self.lastNode = node;
    }
    return self;
}

- (void)enquene:(id)data{
    
    Node * newNode = [[Node alloc]init:data];
    if (self.firstNode == nil){
        self.firstNode = newNode;
        self.lastNode = newNode;
    }else{
        self.lastNode.next = newNode;
        self.lastNode = newNode;
    }
}

- (id)dequene{
    Node * node = self.firstNode;
    if (node.next == nil){
        self.lastNode = nil;
    }
    self.firstNode = node.next;
    return node.data;
}

- (BOOL)isEmpty{
    return self.firstNode == nil;
}

- (int)count{
    Node * nextNode = self.firstNode;
    int count = 0;
    while (nextNode != nil) {
        count ++;
        nextNode = nextNode.next;
    }
    return count;
}

- (id)top{
    return self.firstNode.data;
}

- (void)clear{
    
    self.firstNode = nil;
    self.lastNode = nil;
}
@end
