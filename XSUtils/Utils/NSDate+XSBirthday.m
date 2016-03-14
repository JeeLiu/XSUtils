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

- (NSString*)chineseCalendar{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    NSLog(@"%zd_%zd_%zd",localeComp.year,localeComp.month,localeComp.day);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return chineseCal_str;  
}

@end
