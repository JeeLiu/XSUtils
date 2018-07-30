//
//  WaterView.m
//  Test--OC
//
//  Created by Input on 2017/12/20.
//  Copyright © 2017年 Input. All rights reserved.
//

#import "WaterView.h"
@interface WaterView ()

@property (nonatomic, assign) BOOL isIncrease;

@property (nonatomic, assign) CGFloat a;
@property (nonatomic, assign) CGFloat b;

@property (nonatomic, assign) CGFloat currentLinePointY;
@property (nonatomic, assign) CGFloat percent1;
@property (nonatomic, strong) UIColor *waterOther;

@end

@implementation WaterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf {
    _a = 1;
    _b = 0;
    _isIncrease = NO;
    
    _currentLinePointY = 50;
    _percent = 0;
    _percent1 = 0.5;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
}
- (void)animation {
    if (_isIncrease) {
        _a += 0.02;
    }else{
        _a -= 0.02;
    }
    
    if (_a <= 0.9) {
        _isIncrease = YES;
    }
    
    if (_a >= 1.5) {
        _isIncrease = NO;
    }
    NSInteger p = _percent * 100;
    NSInteger p1 = _percent1 * 100;
    if (p < p1){
        _percent += 0.01;
    }else if(p > p1){
        _percent -= 0.01;
    }
    _b += 0.1;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (!_waterColor) {
        self.waterColor = [UIColor colorWithRed:117/255.0 green:210/255.0 blue:249/255.0 alpha:0.7];
    }
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    UIBezierPath * path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 1;
    
    [path moveToPoint:CGPointMake(0, _currentLinePointY)];
    [path1 moveToPoint:CGPointMake(0, _currentLinePointY)];

    _currentLinePointY = rect.size.height * (1 - _percent);
    CGFloat y = _currentLinePointY;
    [_waterColor set];
    for(CGFloat x = 0; x <= rect.size.width; x++){
        y = _a * sin( x / 60 * M_PI - 4 * _b / M_PI) * 6 + _currentLinePointY + 2;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [_waterOther set];
    for(CGFloat x = 0; x <= rect.size.width; x++){
        y = _a * cos( x / 60 * M_PI - 4 * _b / M_PI) * 4 + _currentLinePointY + 2;
        [path1 addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path addLineToPoint:CGPointMake(0, rect.size.height)];
    [path addLineToPoint:CGPointMake(0, _currentLinePointY)];
    [path fill];
    
    [path1 addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path1 addLineToPoint:CGPointMake(0, rect.size.height)];
    [path1 addLineToPoint:CGPointMake(0, _currentLinePointY)];
    [path1 fill];
}

-  (void)setWaterColor:(UIColor *)waterColor {
    _waterColor = waterColor;
    NSString *RGBValue = [NSString stringWithFormat:@"%@",waterColor];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    CGFloat r = [[RGBArr objectAtIndex:1] floatValue];
    CGFloat g = [[RGBArr objectAtIndex:2] floatValue];
    CGFloat b = [[RGBArr objectAtIndex:3] floatValue];
    CGFloat a = [[RGBArr objectAtIndex:4] floatValue] - 0.2;
    if (a < 0.4) {
        a  += 0.5;
    }
    _waterOther = [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (void)setPercent:(CGFloat)percent {
    _percent1 = percent;
    if (percent > 1) {
        _percent1 = 1;
    }
    if (percent < 0) {
        _percent1 = 0;
    }
    [self setNeedsDisplay];
}

- (void)setIsCircle:(BOOL)isCircle {
    _isCircle = isCircle;
    self.layer.masksToBounds = YES;
}

@end
