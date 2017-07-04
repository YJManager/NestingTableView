//
//  MultiContainerView.h
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiContainerView : UIView

@property (nonatomic, strong) UIViewController *managerViewController;
@property (nonatomic, strong) NSArray *subControllers; /**< 需要的sub */

@end
