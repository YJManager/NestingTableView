//
//  NestingTableView.m
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "NestingTableView.h"

@implementation NestingTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;

//    if ([otherGestureRecognizer.delegate isKindOfClass:[NestingTableView class]]) {
//        return YES;
//    }
//    return NO;
}

@end
