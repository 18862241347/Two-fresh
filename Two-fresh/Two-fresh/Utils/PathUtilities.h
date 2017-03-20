//
//  PathUtilities.h
//  TaiPing
//
//  Created by bbdtek on 11-8-31.
//  Copyright 2011 bbdtek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PathUtilities : NSObject 

//创建或向已存在的Plist文件写数据
+(void)updatePlist:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ withDictionary:(NSDictionary *)infoDic_;

//跟新Plist文件(根目录文件为NSDictionary)一级目录下得某一个字段的内容
+(void)updatePlist:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ wihtKey:(NSString*)key_ withValue:(id)value;

//创建或向已存在的Plist文件写数据
+(void)updatePlist:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ withArray:(NSArray *)infoArray_;

//获取Plist文件内容(文件内容是Dictionary)
+(NSMutableDictionary *)readDictionaryPlistForKey:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_;

//读取Plist文件一级目录中的某一个字段
+(NSString *)readPlistForKey:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ wihtKey:(NSString*)key_;

//获取Plist文件内容(文件内容是array)
+(NSMutableArray *)readArrayPlistForKey:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_;

//获取document目录下文件路径
+ (NSString *)documentFilePathWithFileName:(NSString*)fileName;
//获取library目录下文件路径
+ (NSString *)libraryFilePathWithFileName:(NSString*)fileName;

//指定路径上如果不存在文件，就自动创建文件夹
+ (BOOL)createDirectoryIfNotExistsAtPath:(NSString *)path;

//
//将资源文件的数据库文件写入沙盒中
+ (void) copyDatabaseIfNeededWithFileName:(NSString*)fileName  SearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;
//将资源文件的数据库文件写入沙盒中
+ (void) copyDatabaseIfNeededWithFileName:(NSString*)fileName  withFileType:(NSString *)fileType SearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory;

//Wirte File
+ (NSString *)writeToFile:(NSData *)data  withFileName:(NSString *) fileName;


//判断文件是否存在
+(BOOL)fileExistsAtPath:(NSString *) filePath_;


//delete File
+ (void)deteleFileWithFilePath:(NSString*)filePath_;


//
////imgUrl :  folderName:docunent   renFileName:文件重命名
//+(BOOL)downloadFileAndSaveWithURL:(NSString*)imgUrl withDocument:(NSString*)folderName renFileName:(NSString*)fileName;
//
//
////update documents在appDelte中实现
////remove old file  move *.temp old name 
//+(void)updateFilesWithDocument:(NSString*)documents;
//
//
////unzip File
//+(void)unzipFile:(NSString*)fileName  toUnzipPath:(NSString*) unzipFile_ ;
//
////解压到制定目录
//+(void)unzipFile:(NSString*)fileName  SearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory toUnzipPath:(NSString*) unzipFile_ ;
//
////将string保存成文件
//+ (void)storeDataToDisk:(NSString *)dataStr_ withFilePath:(NSString *)filePath_;
//


//
////创建对应路径的文件夹
//+(void)createFolder:(NSString *)folderPath_;
//
////读取文件为string
//+(NSString *)queryDiskCache:(NSString *)filePath_;
//
////超时了返回NO， 不超时返回YES
//+(BOOL)checkFileIsTimeOver:(NSString *)filePath_  withMaxAge:(NSInteger)maxAge_ ;
//
///**
// *	@brief	返回用户的头像路径
// *	@author	zhgz
// *
// *	@param 	accountName_
// *
// *	@return	用户的文件夹路径
// */
//+(NSString *)userPathWithAccountName:(NSString *)accountName_;
//
///**
// *	@brief	生成用户头像截图
// *	@author	zhgz
// *
// *	@param 	accountName_ 	用户
// *	@param 	image_ 	用户选择的原图
// */
//+(void)storeUserPhotoWithUserName:(NSString *)accountName_ withImage_:(UIImage *)image_;
//
///**
// *	@brief	返回客户的头像路径
// *	@author	xex
// *
// *	@param 	customerId_
// *
// *	@return	用户的文件夹路径
// */
//+(NSString *)customerPathWithImageName:(NSString *)imageName_ withFolderString:(NSString *)folderString_ ;
//
///**
// *	@brief	客户管理头像
// *	@author	xex
// *
// *	@param 	image_ 	用户选择的原图
// */
//+(void)storeCustomerPhotoWithImage_:(UIImage *)image_ withCustomerId:(NSString *)customerId_ withFolderString:(NSString *)folderString_ ;
@end
