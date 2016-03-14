//
//  XSCornerRadius.m
//  XSUtils
//
//  Created by jeeliu on 16/2/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import "XSCornerRadius.h"
double ceilbyunit(double num, double unit) {
    return num - modf(num, &unit) + unit;
}

double floorbyunit(double num, double unit) {
    return num - modf(num, &unit);
}

double roundbyunit(double num, double unit) {
    double remain = modf(num, &unit);
    if (remain > unit / 2.0) {
        return ceilbyunit(num, unit);
    } else {
        return floorbyunit(num, unit);
    }
}

double pixel(double num) {
    double unit = 0.f;
    
    int scale = [[UIScreen mainScreen] scale];
    
    switch (scale) {
        case 1:
            unit = 1.0 / 1.0;
            break;
        case 2:
            unit = 1.0 / 2.0;
            break;
        case 3:
            unit = 1.0 / 3.0;
            break;
        default:
            unit = 0.0;
            break;
    }
    return roundbyunit(num, unit);
}

@implementation XSCornerRadius

@end


@implementation UIImage (XSCorner)

- (UIImage *)xs_drawRectWithRoundedCornerRadius:(CGFloat)radius sizetoFit:(CGSize)sizetoFit {
    CGRect rect = {CGPointMake(0, 0), sizetoFit};
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [UIScreen mainScreen].scale);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    
    CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [self drawInRect:rect];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}

@end


@implementation UIView (XSCorner)
- (void)xs_addCornerWithRadius:(CGFloat)radius {
    [self xs_addCornerWithRadius:radius borderWidth:1 backgroundColor:[UIColor clearColor] borderColor:[UIColor blackColor]];
}

- (void)xs_addCornerWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
    
    UIImage *image = [self xs_drawRectWithRoundedCornerRadius:radius borderWidth:borderWidth backgroundColor:backgroundColor borderColor:borderColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self insertSubview:imageView atIndex:0];
}

- (UIImage *)xs_drawRectWithRoundedCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
    
    CGSize sizeToFit = CGSizeMake(pixel(self.bounds.size.width), self.bounds.size.height);
    CGFloat halfBorderWidth = borderWidth / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    
    CGFloat width = sizeToFit.width;
    CGFloat height = sizeToFit.height;
    
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}

@end

@implementation UIImageView (XSCorner)

- (void)xs_addCornerWithRadius:(CGFloat)radius {
    self.image = [self.image xs_drawRectWithRoundedCornerRadius:radius sizetoFit:self.bounds.size];
}

@end