//
//  NestingViewController.m
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "NestingViewController.h"
#import <ElegantTableView/ElegantTableViewGenerator.h>

@interface NestingViewController ()

@end

@implementation NestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *array = @[@"但渐渐地就", @"的控件的肯定", @"的民进党的", @"基督教大家都", @"但渐渐地就的", @"等你建行点击的", @"达克赛德", @"的交互记得记得", @"但渐渐地就的", @"就记得记得", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看", @"坑的开口道看"];
    
    [[ElegantTableViewGenerator shareInstance] createTableViewWithTitles:array subTitles:nil rowHeight:44 superView:self.view didSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"-->%ld", (long)indexPath.row);
    } didScrollBlock:^(UIScrollView *tableView, CGPoint contentOffset) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
