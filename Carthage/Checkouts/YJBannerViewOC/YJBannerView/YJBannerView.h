//
//  YJBannerView.h
//  YJBannerViewDemo
//
//  Created by YJHou on 2014/5/24.
//  Copyright © 2014年 地址:https://github.com/YJManager/YJBannerViewOC . All rights reserved.
//

/** a.当前版本:2.1.1  */

/** b.联系方式: 发现BUG感谢及时通知我修复, 邮箱: houmanager@hotamil.com 或者GitHub上明示 */

/** c.待优化
        1.支持左右间距设置
 */

/** 版本记录:
    2015/2/10   版本1.0   是以静态库的方式使用 Cocoapods 引入功能
    2016/10/17  版本2.0   是以源码的方式使用 Cocoapods 引入功能
    2017/5/29   版本2.1   自动滚动时间间隔调整为3s、动画变化比例调整为1.0、设置标题默认边间距为10, 可任意设置
    2017/7/3    版本2.1.1  修改通过传递UIImageView设置网络图片的方法给BannerView设置图片, 不再依赖 SDWebImage
 */

#import <UIKit/UIKit.h>

/////////////////////////////////// 可以根据选择以下枚举, 配置不同的显示效果。包括: 指示器的位置 和 指示器的样式 /////////////////////////
/** PageControl的位置 */
typedef NS_ENUM(NSInteger, YJBannerViewPageControlAliment) {
    YJBannerViewPageControlAlimentLeft = 0,     // 居左
    YJBannerViewPageControlAlimentCenter,       // 居中
    YJBannerViewPageControlAlimentRight         // 居右
};

/** PageControl的样式 */
typedef NS_ENUM(NSInteger, YJBannerViewPageControlStyle) {
    YJBannerViewPageControlNone = 0,    // 无
    YJBannerViewPageControlSystem,      // 系统自带
    YJBannerViewPageControlAnimated,    // 动画
    YJBannerViewPageControlCustom       // 自定义
};

/** 滚动方向 */
typedef NS_ENUM(NSInteger, YJBannerViewDirection) {
    YJBannerViewDirectionLeft = 0,      // 水平向左
    YJBannerViewDirectionRight,         // 水平向右
    YJBannerViewDirectionTop,           // 竖直向上
    YJBannerViewDirectionBottom         // 竖直向下
};

////////////////////////////////////////// 数据源部分 ////////////////////////////////////////
@class YJBannerView;
@protocol YJBannerViewDataSource <NSObject>

@required
/** 显示图片的数据源 兼容http:// https:// 和本地图片名字 */
- (NSArray *)bannerViewImages:(YJBannerView *)bannerView;
@optional
/** 显示文字数据源 */
- (NSArray *)bannerViewTitles:(YJBannerView *)bannerView;

@end

///////////////////////////////////// 代理方法部分 包括: 滚动的回调 和 点击的回调 ////////////////////////////
@protocol YJBannerViewDelegate <NSObject>

@optional
/** 滚动回调 */
- (void)bannerView:(YJBannerView *)bannerView didScroll2Index:(NSInteger)index;

/** 点击回调 */
- (void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;

@end

@interface YJBannerView : UIView

@property (nonatomic, weak) id<YJBannerViewDataSource> dataSource; /**< 数据源代理 */
@property (nonatomic, weak) id<YJBannerViewDelegate> delegate; /**< 代理 */


///////////////////////////////////////////////// 动态控制部分 ////////////////////////////////////////////////
@property (nonatomic, assign) CGFloat autoDuration; /**< 自动滚动时间间隔 默认3s */

@property (nonatomic, assign, getter=isAutoScroll) BOOL autoScroll; /**< 是否自动 默认YES */

@property (nonatomic, assign) YJBannerViewDirection bannerViewScrollDirection; /**< 滚动方向 默认水平向左 */

/** 卡在一半的问题, 在控制器viewWillAppear时调用此方法 */
- (void)adjustBannerViewWhenViewWillAppear;

////////////////////////////////////////////  自定义样式接口  //////////////////////////////////////////////
@property (nonatomic, assign) UIViewContentMode bannerImageViewContentMode; /**< 填充样式 默认UIViewContentModeScaleToFill */

@property (nonatomic, strong) UIImage *placeholderImage; /**< placeholderImage */

@property (nonatomic, assign, getter=isOnlyDisplayText) BOOL onlyDisplayText; /**< 是否只显示文字 默认NO */

@property (nonatomic, assign) YJBannerViewPageControlAliment pageControlAliment; /**< 分页控件的位置 默认是Center */

@property (nonatomic, assign) YJBannerViewPageControlStyle pageControlStyle; /**< 分页控件样式 默认System */

@property (nonatomic, assign) CGFloat pageControlBottomMargin; /**< 分页控件距离底部的间距 默认10 */

@property (nonatomic, assign) CGFloat pageControlHorizontalEdgeMargin; /**< 分页控件水平方向上的边缘间距 默认10 */

@property (nonatomic, assign) CGSize pageControlDotSize; /**< 分页控件小圆标大小 默认8*8*/

@property (nonatomic, strong) UIColor *pageControlNormalColor; /**< 分页控件正常颜色 */

@property (nonatomic, strong) UIColor *pageControlHighlightColor; /**< 前分页控件小圆标颜色 */

@property (nonatomic, strong) UIImage *pageControlNormalImage; /**< 分页小圆点正常的图片 */

@property (nonatomic, strong) UIImage *pageControlHighlightImage; /**< 当前分页控件图片 */

@property (nonatomic, strong) UIFont *titleFont; /**< 文字大小 */

@property (nonatomic, strong) UIColor *titleTextColor; /**< 文字颜色 */

@property (nonatomic, assign) NSTextAlignment titleAlignment; /**< 文字对齐方式 */

@property (nonatomic, strong) UIColor *titleBackgroundColor; /**< 文字背景颜色 */

@property (nonatomic, assign) CGFloat titleHeight; /**< 文字高度 */

@property (nonatomic, assign) CGFloat titleEdgeMargin; /**< 文字边缘间距 默认是10*/

////////////////////////// bannerView Block 回调部分 ////////////////////////
@property (nonatomic, copy) void(^didScroll2IndexBlock)(NSInteger index);
@property (nonatomic, copy) void(^didSelectItemAtIndexBlock)(NSInteger index);

/** 刷新BannerView */
- (void)reloadData;

/**
 * 创建bannerView实例的方法
 *
 * @frame               banner的大小
 * @dataSource          数据源代理
 * @delegate            普通代理
 * @selectorString      必须是 UIImageView 设置图片和placeholderImage的方法 如: @"sd_setImageWithURL:placeholderImage:"
 * @placeholderImage    默认图片
 *
 * @return bannerView的实例
 */
+ (YJBannerView *)bannerViewWithFrame:(CGRect)frame dataSource:(id<YJBannerViewDataSource>)dataSource delegate:(id<YJBannerViewDelegate>)delegate selectorString:(NSString *)selectorString placeholderImage:(UIImage *)placeholderImage;

@end
