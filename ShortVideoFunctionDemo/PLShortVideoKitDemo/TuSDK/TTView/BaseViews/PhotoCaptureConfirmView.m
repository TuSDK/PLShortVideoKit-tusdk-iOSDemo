/********************************************************
 * @file    : PhotoCaptureConfirmView.m
 * @project : TuSDKVideoDemo
 * @author  : Copyright © http://tutucloud.com/
 * @date    : 2020-08-01
 * @brief   : 相机拍照结果展示页
*********************************************************/

#import "PhotoCaptureConfirmView.h"

static const NSTimeInterval kAnimationDuration = 0.25;  // 动画时长

static const CGFloat kTopBarHeight = 64.0; // 顶部工具栏高度

@implementation PhotoCaptureConfirmView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self commonInit];
    }
    return self;
}

/**
 配置视图
 */
- (void)commonInit {
    // 背景容器视图
    _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_backgroundView];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0;
    // 拍照结果展示视图
    _photoView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_photoView];
    _photoView.contentMode = UIViewContentModeScaleAspectFit;
    _photoView.alpha = 0;
    _photoView.backgroundColor = [UIColor blackColor];
    // 返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_backButton];
    [_backButton setImage:[UIImage imageNamed:@"video_ic_back"] forState:UIControlStateNormal];
    [_backButton sizeToFit];
    _backButton.alpha = 0;
    // 确认按钮
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_doneButton];
    [_doneButton setImage:[UIImage imageNamed:@"video_ic_sure"] forState:UIControlStateNormal];
    [_doneButton sizeToFit];
    _doneButton.alpha = 0;
}

- (void)layoutSubviews {
    const CGSize size = self.bounds.size;
    const CGFloat centerY = size.height - 91;
    _backButton.center = CGPointMake(size.width / 4, centerY);
    _doneButton.center = CGPointMake(size.width / 4 * 3, centerY);
    _backgroundView.frame = self.bounds;
    
//    if (_photoRatio == 1.0 || _photoRatio == 3.0/4) {
//        CGFloat topOffset = 0;
//        if (_photoRatio == 1.0) topOffset = kTopBarHeight;
//        if (@available(iOS 11.0, *)) {
//            CGFloat safeTopOffset = self.safeAreaInsets.top;
//            if (safeTopOffset > 0) topOffset = kTopBarHeight + safeTopOffset;
//        }
//        _photoView.frame = CGRectMake(0, topOffset, size.width, size.width / _photoRatio);
//    } else
    {
        _photoView.frame = self.bounds;
    }
}

- (void)setPhotoRatio:(CGFloat)photoRatio {
    _photoRatio = photoRatio;
    [self setNeedsLayout];
}

#pragma mark - public

/**
 视图显示状态
 */
- (void)show {
    CGPoint backButtonCenter = _backButton.center;
    _backButton.center = CGPointMake(backButtonCenter.x, backButtonCenter.y + 44);
    CGPoint doneButtonCenter = _doneButton.center;
    _doneButton.center = CGPointMake(doneButtonCenter.x, doneButtonCenter.y + 44);
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.backgroundView.alpha = 1;
        self.doneButton.alpha = self.backButton.alpha = self.photoView.alpha = 1;
        self.backButton.center = backButtonCenter;
        self.doneButton.center = doneButtonCenter;
    }];
}

/**
 完成后回调操作

 @param completion 完成后的操作
 */
- (void)hideWithCompletion:(void (^)(void))completion {
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.backgroundView.alpha = 0;
        self.doneButton.alpha = self.backButton.alpha = self.photoView.alpha = 0;
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

@end
