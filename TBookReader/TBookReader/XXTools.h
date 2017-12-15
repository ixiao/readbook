//
//  XXTools.h
//  PersonCar
//
//  Created by cheBaidu on 2017/6/12.
//  Copyright © 2017年 车佰度. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXTools : NSObject
// 获取URL路径
+ (NSString *)getBaseURL;
// 网页地址
+ (NSString *)getBaseHTML;

+ (BOOL)isValidateName:(NSString *)name;
/**
 * 确定不为空
 */
+ (BOOL)isNull:(id)object;

+ (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate;

//+ (UIImage*)convertViewToImage:(UIView*)v;
//
///** 打电话方法  */
//+ (void)callPhoneWithNumber:(NSString *)number;
//
///**  读取图片   */
//+ (UIImage *)getImageFromBundle:(NSString *)key;
//
///**  保存图片   */
//+ (void)saveImage:(UIImage *)currentImage forKey:(NSString *)key;


/**  交换空格两边的字符串 */
+ (NSString *)changeStringFormSpace:(NSString *)string;

/**
 *  MD5加密, 32位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5加密, 32位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5加密, 16位 小写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5加密, 16位 大写
 *
 *  @param str 传入要加密的字符串
 *
 *  @return 返回加密后的字符串
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

+ (NSString *)getPath:(NSString *)fileName;
+ (BOOL)fileExistsBook:(NSString *)bookName;
@end
