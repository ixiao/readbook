//
//  XXTools.m
//  PersonCar
//
//  Created by cheBaidu on 2017/6/12.
//  Copyright © 2017年 车佰度. All rights reserved.
//

#import "XXTools.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation XXTools

+ (NSString *)getBaseURL
{
//    return @"http://192.168.0.111:8080";
//        return @"https://119.23.44.109:8443";//测试地址
        return @"https://xingwujie.net:8443/";//正式平台
//        return @"http://www.sxyht.com:8000";//老平台
}

+ (NSString *)getUploadImageUrlString
{
    //    return @"http://login.sxhalo.com/lamadm/imageUploadAPI.action";
    return @"http://172.16.99.199:8080/lamadm/imageUploadAPI.action";
    //    return @"http://139.129.195.113/lameiadm/imageUploadAPI.action";
}
+ (NSString *)getBaseHTML
{
    //    return @"http://login.sxhalo.com/lamadm/";
    //    return @"http://adm.sxhalo.com/lameiadm/";
    return @"http://172.16.99.199:8080/lamadm/";
}
//判断字符串为7～14位“字符”
+ (BOOL)isValidateName:(NSString *)name{
    NSUInteger  character = 0;
    for(int i=0; i< [name length];i++){
        int a = [name characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fa5){ //判断是否为中文
            character +=2;
        }else{
            character +=1;
        }
    }
    
    if (character >=2 && character <=30) {
        return YES;
    }else{
        return NO;
    }
    
}

//+ (void)callPhoneWithNumber:(NSString *)number
//{
//    if ([self isNull:number]) {
//        return;
//    }
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",[number stringByReplacingOccurrencesOfString:@" " withString:@""]];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
//}
//+ (UIImage *)getImageFromBundle:(NSString *)key
//{
//    NSString * imagePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",key]];
//    if (imagePath) {
//        return [UIImage imageWithContentsOfFile:imagePath];
//    }
//    return [UIImage imageNamed:@"user_icon"];
//}
//#pragma mark - 保存图片
//+ (void)saveImage:(UIImage *)currentImage forKey:(NSString *)key {
//    //设置照片的品质
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    // 获取沙盒目录
//    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",key]];
//    // 将图片写入文件
//    [imageData writeToFile:filePath atomically:NO];
//}
//


/**
 *  @return YES 就是为空
 */
+ (BOOL) isNull:(id )object {
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]]){
        return YES;
    }
    else if (object == nil){
        return YES;
    }
    else {
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@""] || [object isEqualToString:@"(null)"]||[object isEqualToString:@"<null>"]) {
                return YES;
            }
            return NO;
        }
        else if([object isKindOfClass:[NSArray class]]) {
            if ([object count] == 0) {
                return YES;
            }
        }else if ([object isKindOfClass:[NSDictionary class]]){
            if ([object count] == 0) {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}

//比较两个日期大小
+ (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH时ss分"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    XLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            XLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

//+ (UIImage*)convertViewToImage:(UIView*)v{
//    CGSize s = v.bounds.size;
//    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
//    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
//    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
+ (NSString *)changeStringFormSpace:(NSString *)string
{
    NSArray  *array = [string componentsSeparatedByString:@" "];
    return [NSString stringWithFormat:@"%@ %@",array[1],array[0]];
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    if (!(str == nil) ) {
        const char *cStr = [str UTF8String];
        unsigned char result[32];
        if(str == nil)
            return nil;
        CC_MD5(cStr, (CC_LONG)strlen(cStr), result );
        
        return [[NSString stringWithFormat:
                 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                 result[0], result[1], result[2], result[3],
                 result[4], result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11],
                 result[12], result[13], result[14], result[15]
                 ]lowercaseString];
    }else
        return @"0";

//    //要进行UTF8的转码
//    const char* input = [str UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(input, (CC_LONG)strlen(input), result);
//    
//    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
//        [digest appendFormat:@"%02x", result[i]];
//    }
//    
//    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}

#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
+ (NSString *)getPath:(NSString *)fileName{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * txtPath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",fileName]]; // 此时仅存在路径，文件并没有真实存在
    return txtPath;
}

+ (BOOL)fileExistsBook:(NSString *)bookName{
    NSFileManager * manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:[self getPath:bookName]];
}

@end
