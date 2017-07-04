//
//  NestingRootViewController.m
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "NestingRootViewController.h"
#import "NestingTableView.h"
#import <ElegantTableView/ElegantTableViewGenerator.h>

@interface NestingRootViewController (){
    CGFloat _preIsCanScrollOffY;
}

@property (nonatomic, assign) BOOL isCanScroll; /**< 是否可以滚动 */

@end

@implementation NestingRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (_isCanScroll) { // 可以滑动子list 记录偏移量
        _preIsCanScrollOffY = MAX(offsetY, 0);
    }else{ // 不可滑动 保持之前的偏移量
        [scrollView setContentOffset:CGPointMake(0, _preIsCanScrollOffY)];
    }
    _scrollView = scrollView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        NestingTableViewStatusType statusType = [[change objectForKey:@"new"] integerValue];
        if (statusType == NestingTableViewStatusNormalTop) {
            self.isCanScroll = NO;
        } else {
            self.isCanScroll = YES;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
