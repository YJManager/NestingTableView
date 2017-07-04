//
//  MainViewController.m
//  NestingTableViewDemo
//
//  Created by YJHou on 2017/7/4.
//  Copyright © 2017年 侯跃军. All rights reserved.
//

#import "MainViewController.h"
#import "NestingTableView.h"
#import <OCCommonMacro/OCCommonMacro.h>
#import <YJBannerView/YJBannerView.h>
#import "MultiContainerView.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, YJBannerViewDataSource, YJBannerViewDelegate>

@property (nonatomic, assign) NestingTableViewStatusType status; /**< tableView的状态 */
@property (nonatomic, strong) NestingTableView *tableView; /**< 可嵌套TableView */
@property (nonatomic, strong) YJBannerView *bannerView; /**< bannerView */
@property (nonatomic, strong) MultiContainerView *containerView; /**< 容器视图 */

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setUpMainNavView];
    [self _setUpMainView];
}

- (void)_setUpMainNavView{
    self.navigationItem.title = @"嵌套TableView";
}

- (void)_setUpMainView{
    
    self.status = NestingTableViewStatusNormal;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.bannerView;
    
    
    [self.bannerView reloadData];
    [self.tableView reloadData];
}

#pragma mark - Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = kRANDOM_COLOR;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellId = @"NestingTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    self.containerView.managerViewController = self;
    [cell.contentView addSubview:self.containerView];
    
    self.containerView.subControllers = @[@"5666", @"415"];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offY = scrollView.contentOffset.y;
    NSLog(@"-->%f", offY);
    CGFloat navStatusHeight = 64.0f; // 64
    CGFloat justHideOffset = 64.0 + 44.0;
    if (offY >= justHideOffset) { // 控制title的位置
        self.status = NestingTableViewStatusTop;
        scrollView.contentOffset = CGPointMake(0, justHideOffset);
    } else {
        if (offY > -navStatusHeight && offY < justHideOffset) {
            self.status = NestingTableViewStatusNormalTop;
            
        }else if (offY == -navStatusHeight){
            self.status = NestingTableViewStatusNormal;
            scrollView.contentOffset = CGPointMake(0, -navStatusHeight);
        }else if (offY < -navStatusHeight){
            self.status = NestingTableViewStatusNormalDown;
            scrollView.contentOffset = CGPointMake(0, -navStatusHeight);
        }
    }
}

#pragma mark - BannerDataSource
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView{
    return @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788490274&di=0b9453aab06d2ea5a77a47d0d78cfa83&imgtype=0&src=http%3A%2F%2Fwww.16sucai.com%2Fuploadfile%2F2013%2F0407%2F20130407085208429.jpg",
             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788516621&di=4efa056fe4234193736eb7d4dd48a262&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F87%2F10%2F42N58PICFdP_1024.jpg",
             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788546756&di=2a5e74dcbf61882752005d729c07d39b&imgtype=0&src=http%3A%2F%2Fwww.djhnjllm.com%2Fstatic%2Fupload%2Fimage%2F2013%2F2%2F25%2F0039716899204936.jpg",
             @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495788599948&di=d6cef2c314498aa0d78202753a6b2493&imgtype=0&src=http%3A%2F%2Fimg3.redocn.com%2Ftupian%2F20151216%2Fshishangnvzhuangwangzhanbanner_5607161.jpg"];
}

- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"-->%ld", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Lazy
- (NestingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[NestingTableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

- (YJBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 180) dataSource:self delegate:self selectorString:@"sd_setImageWithURL:placeholderImage:" placeholderImage:nil];
    }
    return _bannerView;
}

- (MultiContainerView *)containerView{
    if (!_containerView) {
        _containerView = [[MultiContainerView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        _containerView.backgroundColor = kRANDOM_COLOR;
    }
    return _containerView;
}



@end
