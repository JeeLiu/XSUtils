//
//  XSCornerRadius.h
//  XSUtils
//
//  Created by jeeliu on 16/2/29.
//  Copyright © 2016年 yy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XSCornerRadius : NSObject

@end

@interface UIImage (XSCorner)
- (UIImage *)xs_drawRectWithRoundedCornerRadius:(CGFloat)radius sizetoFit:(CGSize)sizetoFit;
@end


@interface UIView (XSCorner)
- (void)xs_addCornerWithRadius:(CGFloat)radius;
@end

@interface UIImageView (XSCorner)
- (void)xs_addCornerWithRadius:(CGFloat)radius;
@end