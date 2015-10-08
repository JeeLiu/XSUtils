//
//  NSString+XSBirthday.m
//  XSUtils
//
//  Created by jeeliu on 14/6/16.
//  Copyright © 2015年 jeeliu All rights reserved.
//

#import "NSString+XSBirthday.h"

@implementation NSString (XSBirthday)

//获取星座
// 例如 ：2010-01-09
+ (NSString *)astroForBirthday:(NSString *)birthday {
    //月
    int month = [[[birthday componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    //天
    int day = [[[birthday componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result = [astroString substringWithRange:NSMakeRange(month *2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)];
    
    return [result stringByAppendingString:@"座"];
}

- (NSString *)astroString {
    //月
    int month = [[[self componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
    //天
    int day = [[[self componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result = [astroString substringWithRange:NSMakeRange(month *2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)];
    
    return [result stringByAppendingString:@"座"];
}
@end
