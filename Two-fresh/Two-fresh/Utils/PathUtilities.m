

//
//  PathUtilities.m
//  TaiPing
//
//  Created by bbdtek on 11-8-31.
//  Copyright 2011 bbdtek. All rights reserved.
//

#import "PathUtilities.h"


@implementation PathUtilities


//创建或向已存在的Plist文件写数据
+(void)updatePlist:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ withDictionary:(NSDictionary *)infoDic_
{
    
    //获取Document或Library目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory_, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    ////获取文件路径
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename_]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //指定路径下的文件不存在先创建文件再向文件中写数据，如果文件存在直接向文件写数据
    if (![fileManager fileExistsAtPath: plistPath])
    {
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
    }
    
    [infoDic_ writeToFile: plistPath  atomically:YES];
    
}

//跟新Plist文件(根目录文件为NSDictionary)一级目录下得某一个字段的内容
+(void)updatePlist:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ wihtKey:(NSString*)key_ withValue:(id)value
{
    
    NSMutableDictionary *info_ = [self readDictionaryPlistForKey:searchPathDirectory_ withFile:filename_];
    if (!info_)
    {
        info_ = [NSMutableDictionary dictionary];
    }
    [info_ setObject:value forKey:key_];
    
    [self updatePlist:searchPathDirectory_ withFile:filename_ withDictionary:info_];
    
}

//跟新文件
+(void)updatePlist:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ withArray:(NSArray *)infoArray_
{
    //获取Document或Library目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory_, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    ////获取文件路径
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename_]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //指定路径下的文件不存在先创建文件再向文件中写数据，如果文件存在直接向文件写数据
    if (![fileManager fileExistsAtPath: plistPath])
    {
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
    }
    
    [infoArray_ writeToFile: plistPath  atomically:YES];
}

//获取Plist文件内容
+(NSMutableDictionary *)readDictionaryPlistForKey:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_
{
    //获取Document或Library目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory_, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/",[paths objectAtIndex:0]];
    
    //获取文件路径
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename_]];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithContentsOfFile : plistPath];
    return dictionary;
    
}

//获取Plist文件(根目录为NSDictionary)的一级目录下某一个字段
+(NSString *)readPlistForKey:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_ wihtKey:(NSString*)key_
{

    NSMutableDictionary *info_ = [self readDictionaryPlistForKey:searchPathDirectory_ withFile:filename_];
    
    NSString *readInfo_ = [info_ objectForKey:key_];
    
    return readInfo_;
    
}

//获取Plist文件内容
+(NSMutableArray *)readArrayPlistForKey:(NSSearchPathDirectory)searchPathDirectory_ withFile:(NSString*)filename_
{
    //获取Document或Library目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory_, NSUserDomainMask, YES);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/",[paths objectAtIndex:0]];
    
    //获取文件路径
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename_]];

    NSMutableArray *infoArray_ = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];

    return infoArray_;
}

+ (NSString *)documentFilePathWithFileName:(NSString*)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	return filePath;
}
//
+ (NSString *)libraryFilePathWithFileName:(NSString*)fileName{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                         NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
	NSString *filePath = [libraryDirectory stringByAppendingPathComponent:fileName];
	return filePath;
}

//创建文件夹
+ (BOOL)createDirectoryIfNotExistsAtPath:(NSString *)path{
    BOOL result = NO;
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL exists = [fileManger fileExistsAtPath:path];
    if (!exists) {
        result = [fileManger createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }else {
        result = YES;
    }
    
    return result;
}

//将资源文件的数据库文件写入沙盒中
+ (void) copyDatabaseIfNeededWithFileName:(NSString*)fileName  SearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory{
    //Using NSFileManager we can perform file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    //find file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:fileName];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
    
}

//将资源文件的数据库文件写入沙盒中
+ (void) copyDatabaseIfNeededWithFileName:(NSString*)fileName  withFileType:(NSString *)fileType SearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory{
    //Using NSFileManager we can perform file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    //find file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", fileName, fileType]];
    BOOL isExist_ = [fileManager fileExistsAtPath:dbPath];
    
    if(!isExist_)
    {
        NSString *defaultDBPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        BOOL isSuccess_ = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!isSuccess_)
        {
            NSLog(@"create appSetting info failed");
            /*
             NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
             */
        }
        
    }
    
}

//
//
+ (NSString *)writeToFile:(NSData *)data withFileName:(NSString *)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO){
        NSLog(@"file not exist,create it...");
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }else {
        NSLog(@"file exist!!!");
    }
    
    [data writeToFile:filePath atomically:YES];

    return filePath;
    
}

+(BOOL)fileExistsAtPath:(NSString *) filePath_
{
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath_])
        return  YES;
    
    else
        return  NO;
}

+ (void)deteleFileWithFilePath:(NSString*)filePath_
{
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager fileExistsAtPath:filePath_])
    {
        [defaultManager removeItemAtPath:filePath_ error:nil];
    }
    
}

//
//
////imgUrl 
//+(BOOL)downloadFileAndSaveWithURL:(NSString*)imgUrl withDocument:(NSString*)folderName renFileName:(NSString*)fileName
//{
//    NSURL *url = [NSURL URLWithString:imgUrl];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    
//    if (!([urlData length] > 0)) {
//        return NO;
//    }
//    
//    //创建文件管理器 
//    NSFileManager *fileManager = [NSFileManager defaultManager]; 
//    //获取路径 
//    //参数NSDocumentDirectory要获取那种路径 
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    //去处需要的路径
//    NSString *documentsDirectory = [paths objectAtIndex:0];   
//    
//    //创建一个目录
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:folderName];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; 
//    
//    //更改到待操作的目录下 
//    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]]; 
//    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil 
//    //获取文件路径 
//    [fileManager removeItemAtPath:fileName error:nil]; 
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/%@",folderName,fileName]];//@"/myFolder/username"]; 
//    
//    
//    
//    if([PathUtilities createDirectoryIfNotExistsAtPath:path]){
//        
//        path =[path stringByAppendingString:@".temp"];
//    }
//    
//    [urlData writeToFile:path atomically:NO];
//    
//    
//    
//    
//    
//    return YES;
//    
//    
//}
//

//
//
//
//+(void)updateFilesWithDocument:(NSString*)documents
//{
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:documents];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; 
//    
//    
//    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dataPath  error:nil];
//    
//    DLog(@"files array %@", filePathsArray);
//    for (int i = 0; i < [filePathsArray count]; i++) {
//        //＊.temp
//        NSString *filePath = [dataPath stringByAppendingPathComponent:[filePathsArray objectAtIndex:i]];
//        DLog(@"----- %@", filePath);
//        
//        
//        
//        
//        
//        if([filePath hasSuffix:@".temp"]){   //(filePath 匹配带.temp的文件)
//            
//            //删除旧的文件
//            
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//            [fileManager changeCurrentDirectoryPath:[dataPath stringByExpandingTildeInPath]];
//            [fileManager removeItemAtPath:filePath error:nil];
//            
//           DLog(@"%@",[fileManager contentsOfDirectoryAtPath:dataPath error:nil]);
//            
//            
//            
//            NSString *notTempFilePath = [filePath substringToIndex:[filePath length]-5];
//            
//            //重命名  
//            NSString *filePath2= [documentsDirectory
//                                  stringByAppendingPathComponent:notTempFilePath]; 
//            
//            
//            if ([fileManager moveItemAtPath:filePath toPath:filePath2 error:nil] != YES){
//                
//                DLog(@"NotSuccessed!");
//            }
//            
//            NSLog(@"Documentsdirectory: %@",
//                  [fileManager contentsOfDirectoryAtPath:dataPath error:nil]);
//            
//            
//            //重名完毕
//        }
//        
//        
//        
//    }
//    
//}
//
//
//
//+(void)unzipFile:(NSString*)fileName  toUnzipPath:(NSString*) unzipFile_ {
// 
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    NSString *downloadPath = [path stringByAppendingPathComponent:fileName];
//    
//    NSString *unzipPath;
//    unzipPath = [[path stringByAppendingPathComponent:@"Unzip"] retain];
//    
//    ZipArchive *unzip = [[ZipArchive alloc] init];
//    if ([unzip UnzipOpenFile:downloadPath]) {
//        BOOL result = [unzip UnzipFileTo:unzipPath overWrite:YES];
//        if (result) {
//            DLog(@"解压成功！");
//        }
//        else {
//            DLog(@"解压失败1");
//        }
//        [unzip UnzipCloseFile];
//    }
//    else {
//        DLog(@"解压失败2");
//    }
//    [unzip release];
//}
//
//
//+(void)unzipFile:(NSString*)fileName  SearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory toUnzipPath:(NSString*) unzipFile_ 
//{
//    
//    
//    //========
//    
//    //Using NSFileManager we can perform file system operations.
//    NSFileManager *fileManager = [NSFileManager defaultManager];
////    NSError *error;
//    //find file path
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(searchPathDirectory , NSUserDomainMask, YES);
//   
//    NSString *documentsDir = [paths objectAtIndex:0];
//    
//    NSString *path = [documentsDir stringByAppendingPathComponent:fileName];
//    
//    BOOL success = [fileManager fileExistsAtPath:path];
//    
//    if(!success) {
//        
//        
//        //    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//        //    
//        //    NSString *downloadPath = [path stringByAppendingPathComponent:@"1.zip"];
//        
//        NSString *downloadPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
//        
//        
//        
//
//        
//        NSString *unzipPath;
//        
//        unzipPath = [[path stringByAppendingPathComponent:@"Unzip"] retain];
//        
//        ZipArchive *unzip = [[ZipArchive alloc] init];
//        
//        
//        if ([unzip UnzipOpenFile:downloadPath]) {
//            
//            BOOL result = [unzip UnzipFileTo:unzipPath overWrite:YES];
//            
//            if (result) {
//                
//                DLog(@"解压成功！");
//                
//            }
//            
//            else {
//                
//                DLog(@"解压失败");
//            }
//            
//            [unzip UnzipCloseFile];
//        }
//        
//        else {
//            
//            DLog(@"解压失败2");
//        }
//        [unzip release];
//        
//
//    }
//    
//    //e==========
//
//    
//
//}
//
//
//
//+ (void)storeDataToDisk:(NSString *)dataStr_ withFilePath:(NSString *)filePath_
//{
//    [dataStr_ writeToFile:filePath_ atomically:YES encoding:NSUTF8StringEncoding error:nil];
//}
//

//
//+(void)createFolder:(NSString *)folderPath_
//{
//    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath_])
//    {
//        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath_
//                                  withIntermediateDirectories:YES
//                                                   attributes:nil
//                                                        error:NULL];
//    }
//}
//
//+(NSString *)queryDiskCache:(NSString *)filePath_
//{
//    //    NSData *data=[[[NSData alloc] initWithContentsOfFile:[self cachePathForFileName:@"NMediaFocus_4.xml"]] autorelease];
//    NSData *data=[[[NSData alloc] initWithContentsOfFile:filePath_] autorelease];
//    
//    return [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
//}
//
//+(BOOL)checkFileIsTimeOver:(NSString *)filePath_  withMaxAge:(NSInteger)maxAge_   //超时了返回NO， 不超时返回YES
//{
//    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:-maxAge_];
//    //    NSString *filePath = [diskCachePath stringByAppendingPathComponent:@"NMediaFocus_4.xml"];
//    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath_ error:nil];
//    if ([[attrs fileModificationDate] compare:expirationDate]==NSOrderedAscending)
//    {
//        return NO;
//    }
//    return YES;
//}
//
///**
// *	@brief	返回用户的头像路径
// *	@author	zhgz
// *
// *	@param 	accountName_
// *
// *	@return	返回用户的头像路径,如果不存在，则返回@“”
// */
//+(NSString *)userPathWithAccountName:(NSString *)accountName_
//{
//    if(!accountName_ || [accountName_ isEqualToString:@""])
//    {
//        return @"";
//    }
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    
//    NSString *diskCachePath;//磁盘路径
//    
//    NSString *photoPath;//照片路径
//    
//    diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"DataCache"] stringByAppendingPathComponent:[accountName_ MD5]];
//    
//    [PathUtilities createFolder:diskCachePath];
//    
//    photoPath= [[[[paths objectAtIndex:0] stringByAppendingPathComponent:@"DataCache"] stringByAppendingPathComponent:[accountName_ MD5]]stringByAppendingPathComponent:@"userPhoto.png"];
//    
//    
//    if ([PathUtilities fileExifileExistsAtPath:photoPath]) {
//        return photoPath;
//    }
//    else
//        return @"";
//    
////    return diskCachePath;
//}
//
///**
// *	@brief	生成用户头像截图
// *	@author	zhgz
// *
// *	@param 	accountName_ 	用户
// *	@param 	image_ 	用户选择的原图
// */
//+(void)storeUserPhotoWithUserName:(NSString *)accountName_ withImage_:(UIImage *)image_
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    
//    NSString *diskCachePath;//磁盘路径
//    
//    NSString *photoPath;//照片路径
//    
//    diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"DataCache"] stringByAppendingPathComponent:[accountName_ MD5]];
//    
//    [PathUtilities createFolder:diskCachePath];
//    
//    photoPath= [[[[paths objectAtIndex:0] stringByAppendingPathComponent:@"DataCache"] stringByAppendingPathComponent:[accountName_ MD5]]stringByAppendingPathComponent:@"userPhoto.png"];
//    
//    //生成缩略图
//    CGFloat scale = 0.4;
//    UIImage *tempSmallImage = [GlobalUtils generatePhotoThumbnail:image_ widthScale:scale heightScale:scale];
//    
//    [GlobalUtils writeImage:tempSmallImage toFileAtPath:photoPath];
//}
///**
// *	@brief	客户管理头像
// *	@author	xex
// *
// *	@param 	image_ 	用户选择的原图
// */
//+(void)storeCustomerPhotoWithImage_:(UIImage *)image_  withCustomerId:(NSString *)customerId_ withFolderString:(NSString *)folderString_ {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    
//    NSString *diskCachePath;//磁盘路径
//    
//    NSString *photoPath;//照片路径
//    
//    diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"customerPhoto"] stringByAppendingPathComponent:folderString_];
//    
//    [PathUtilities createFolder:diskCachePath];
//    
//    photoPath= [[[[paths objectAtIndex:0] stringByAppendingPathComponent:@"customerPhoto"] stringByAppendingPathComponent:folderString_]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",customerId_]];
//    
//    //生成缩略图
//    CGFloat scale = 0.4;
//    UIImage *tempSmallImage = [GlobalUtils generatePhotoThumbnail:image_ widthScale:scale heightScale:scale];
//    
//    [GlobalUtils writeImage:tempSmallImage toFileAtPath:photoPath];
//}
///**
// *	@brief	返回客户的头像路径
// *	@author	xex
// *
// *	@param 	customerId_
// *
// *	@return	用户的文件夹路径
// */
//+(NSString *)customerPathWithImageName:(NSString *)imageName_ withFolderString:(NSString *)folderString_{
//    if(!imageName_ || [imageName_ isEqualToString:@""])
//    {
//        return @"";
//    }
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    
//    NSString *diskCachePath;//磁盘路径
//    
//    NSString *photoPath;//照片路径
//    
//    diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"customerPhoto"] stringByAppendingPathComponent:folderString_];
//    
//    [PathUtilities createFolder:diskCachePath];
//    
//    photoPath= [[[[paths objectAtIndex:0] stringByAppendingPathComponent:@"customerPhoto"] stringByAppendingPathComponent:folderString_]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName_]];
//    
//    
//    if ([PathUtilities fileExifileExistsAtPath:photoPath]) {
//        return photoPath;
//    }
//    else
//        return @"";
//}
@end
