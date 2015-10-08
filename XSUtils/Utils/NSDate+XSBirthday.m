//
//  NSDate+XSBirthday.m
//  XSUtils
//
//  Created by jeeliu on 14/6/16.
//  Copyright © 2015年 jeeliu All rights reserved.
//

#import "NSDate+XSBirthday.h"

@implementation NSDate (XSBirthday)

//根据生日得到年龄
- (NSString *)ageForBirthday{
    
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSUInteger unitFlags = NSCalendarUnitYear;
    
    NSDateComponents *components = [gregorian components:unitFlags fromDate:self toDate:[NSDate  date] options:0];
    
    return [NSString stringWithFormat:@"%ld岁了",[components year]+1];
}

//根据生日得到星座
- (NSString *)constellationForBirthday{
    
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp1 = [myCal components:NSCalendarUnitMonth| NSCalendarUnitDay fromDate:self];
    
    NSInteger month = [comp1 month];
    
    
    NSInteger day = [comp1 day];
    
    return [self getAstroWithMonth:month day:day];
}

//根据生日得到生肖
- (NSString *)zodiacForBirthday{
    
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp1 = [myCal components:NSCalendarUnitYear fromDate:self];
    
    NSInteger year = [comp1 year];
    
    return [self  getZodiacWithYear:year];
}

//得到生肖的算法
- (NSString *)getZodiacWithYear:(NSInteger)y{
    if (y <0) {
        return @"错误日期格式!!!";
    }
    NSString *zodiacString = @"鼠牛虎兔龙蛇马羊猴鸡狗猪";
    
    NSRange range = NSMakeRange ((y+9)%12-1, 1);
    
    NSString *result = [zodiacString  substringWithRange:range];
    
    return [result stringByAppendingString:@"年"];
    
}

//得到星座的算法
- (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d{
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";

    if (m<1||m>12||d<1||d>31) {
        return @"错误日期格式!";
    }
    
    if (m==2 && d>29) {
        return @"错误日期格式!!";
    } else if (m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    
    NSString *result = [astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)];
    
    return [result stringByAppendingString:@"座"];
    
}

@end
