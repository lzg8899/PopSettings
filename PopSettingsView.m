//
//  PopSettingsView.m
//  PopSettings
//
//  Created by Alfie on 16/7/30.
//  Copyright © 2016年 Alfie. All rights reserved.
//

#import "PopSettingsView.h"
#import "CKSingleton.h"
#define OriginY(obj) obj.frame.origin.y
#define OriginX(obj) obj.frame.origin.x
#define Height(obj)  obj.frame.size.height
#define Width(obj)   obj.frame.size.width
#define OnePixelH 1 / [UIScreen mainScreen].scale
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

@interface PopSettingsView ()

@property (nonatomic,weak) UIView *sender;
@property (nonatomic,weak) UIView *superView;
@property (nonatomic,weak) CAShapeLayer *bgShapeLayer;

@end

@implementation PopSettingsView
SYNTHESIZE_SINGLETON_FOR_CLASS(PopSettingsView)

- (instancetype)init
{
    if (self = [super init]) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

+ (void)popSettingsViewForSender:(UIView *)sender inView:(UIView *)view
{
    if (view && sender) {
        PopSettingsView *popView = [PopSettingsView sharedPopSettingsView];
        popView.sender = sender;
        popView.superView = view;
        popView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        popView.frame = view.bounds;
        popView.alpha = 1.0;
        [view addSubview:popView];
        [UIView animateWithDuration:0.3 animations:^{
            popView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        }];
    }
}

- (void)tapGes:(UITapGestureRecognizer *)tapGes
{
    [PopSettingsView dismissPopView];
}

+ (void)dismissPopView
{
    PopSettingsView *popView = [PopSettingsView sharedPopSettingsView];
    [UIView animateWithDuration:0.3 animations:^{
        popView.alpha = 0.0;
    }completion:^(BOOL finished) {
        [popView removeFromSuperview];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect convertRect = [self.superView convertRect:self.sender.frame toView:self];

    if (self.sender) {
        CGRect frame = CGRectZero;
        frame.origin.x = 0;
        frame.origin.y = CGRectGetMaxY(convertRect) + 20;
        frame.size.width = self.superView.frame.size.width;
        frame.size.height = 100.0f;
        self.contentView.frame = frame;
    }
    
    UIBezierPath *path = [UIBezierPath new];
    CGFloat arrowW = 17;
    CGFloat arrowH = 10;
    

    CGFloat startX = CGRectGetMaxX(convertRect) - convertRect.size.width*0.5;
    CGFloat point2X = startX+arrowW*0.5;
    CGFloat point3X = CGRectGetMaxX(self.contentView.frame);
    CGFloat point4X = 0;
    CGFloat radius = 5;
    
    [path moveToPoint:CGPointMake(startX, CGRectGetMinY(self.contentView.frame)-arrowH)];
    [path addLineToPoint:CGPointMake(point2X, OriginY(self.contentView))];
    [path addLineToPoint:CGPointMake(point3X-radius, OriginY(self.contentView))];
    [path addArcWithCenter:CGPointMake(point3X-radius, OriginY(self.contentView)+radius) radius:radius startAngle:M_PI*1.5 endAngle:0 clockwise:true];
    [path addLineToPoint:CGPointMake(point3X, OriginY(self.contentView)+Height(self.contentView))];
    [path addArcWithCenter:CGPointMake(point3X-radius, OriginY(self.contentView)+Height(self.contentView)) radius:radius startAngle:0 endAngle:M_PI*0.5 clockwise:true];
    [path addLineToPoint:CGPointMake(point4X+radius, OriginY(self.contentView)+Height(self.contentView)+radius)];
    [path addArcWithCenter:CGPointMake(point4X+radius, OriginY(self.contentView)+Height(self.contentView)) radius:radius startAngle:M_PI*0.5 endAngle:M_PI clockwise:true];
    [path addLineToPoint:CGPointMake(point4X, OriginY(self.contentView)+radius)];
    [path addArcWithCenter:CGPointMake(point4X+radius, OriginY(self.contentView)+radius) radius:radius startAngle:M_PI endAngle:M_PI*1.5 clockwise:true];
    [path addLineToPoint:CGPointMake(startX-arrowW*0.5, OriginY(self.contentView))];
    [path closePath];
    self.bgShapeLayer.path = path.CGPath;
}

#pragma mark getters 
- (UIView *)contentView
{
    if (_contentView == nil) {
        UIView *contentView = [UIView new];
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}

- (CAShapeLayer *)bgShapeLayer
{
    if (_bgShapeLayer == nil) {
        CAShapeLayer *bgShapeLayer = [CAShapeLayer layer];
        [self.layer addSublayer:bgShapeLayer];
        
        bgShapeLayer.lineWidth   = OnePixelH;
        bgShapeLayer.anchorPoint = CGPointMake(0, 0);
//        bgShapeLayer.strokeColor = HEXCOLOR(0x00bbd3).CGColor;// 边缘线的颜色
        bgShapeLayer.fillColor   = [UIColor whiteColor].CGColor;// 闭环填充的颜色
        bgShapeLayer.lineCap     = kCALineCapRound;// 边缘线的类型
        bgShapeLayer.lineJoin    = kCALineJoinRound;
        
        _bgShapeLayer = bgShapeLayer;
    }
    return _bgShapeLayer;
}

@end
