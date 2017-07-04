//
//  MultiContainerView.m
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "MultiContainerView.h"
#import "NestingViewController.h"

@interface MultiContainerView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *pagesScrollView; /**< 页面Scrol */
@property (nonatomic, strong) NSArray *pageControllers; /**< 子页们 */

@end

@implementation MultiContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUpMainView];
    }
    return self;
}

- (void)_setUpMainView{
    
    [self addSubview:self.pagesScrollView];
    
}

- (void)setSubControllers:(NSArray *)subControllers{
    _subControllers = subControllers;
    
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < subControllers.count; i++) {
        NestingViewController *tableList1 = [[NestingViewController alloc] init];
        [vcs addObject:tableList1];
    }
    self.pageControllers = (NSArray *)vcs;
}

- (void)setPageControllers:(NSArray *)pageControllers{
    _pageControllers = pageControllers;
    
    CGFloat pageW = self.bounds.size.width, pageHeight = CGRectGetHeight(_pagesScrollView.frame);
    CGFloat pageX = 0, pageY = 0;
    
    CGSize pageContentSize = CGSizeMake(pageW, pageHeight);
    for (int i = 0; i < pageControllers.count; i++) {
        
        NestingRootViewController *rootVc = [pageControllers objectAtIndex:i];
        rootVc.view.frame = CGRectMake(pageX, pageY, pageW, pageHeight);
        [_pagesScrollView addSubview:rootVc.view];
        
        [self.managerViewController addChildViewController:rootVc];
        [rootVc didMoveToParentViewController:self.managerViewController];
        rootVc.managerViewController = self.managerViewController;
        [self.managerViewController addObserver:rootVc forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        pageX += pageW;
        pageContentSize.width = CGRectGetMaxX(rootVc.view.frame);
    }
    _pagesScrollView.contentSize = pageContentSize;
}


#pragma mark - Lazy
- (UIScrollView *)pagesScrollView{
    if (!_pagesScrollView) {
        _pagesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _pagesScrollView.delegate = self;
        _pagesScrollView.pagingEnabled = YES;
        _pagesScrollView.bounces = NO;
        _pagesScrollView.showsHorizontalScrollIndicator = NO;
        _pagesScrollView.showsVerticalScrollIndicator = NO;
        //        _pagesScrollView.backgroundColor = [UIColor blueColor];
    }
    return _pagesScrollView;
}

@end
