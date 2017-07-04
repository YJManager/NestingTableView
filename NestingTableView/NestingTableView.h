//
//  NestingTableView.h
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//  兼容 UITableView 的嵌套

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, NestingTableViewStatusType) {
    NestingTableViewStatusTop = 0,
    NestingTableViewStatusNormal = 1,
    NestingTableViewStatusNormalTop = 2,
    NestingTableViewStatusNormalDown = 3
};


@interface NestingTableView : UITableView


@end
