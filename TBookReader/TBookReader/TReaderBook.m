//
//  TReaderBook.m
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import "TReaderBook.h"

@interface TReaderBook ()

@end

@implementation TReaderBook

- (BOOL)haveNextChapter
{
    return _totalChapter > _curChpaterIndex;
}

- (BOOL)havePreChapter
{
    return _curChpaterIndex > 1;
}

- (void)resetChapter:(TReaderChapter *)chapter
{
    _curChpaterIndex = chapter.chapterIndex;
}

- (TReaderChapter *)openBookWithChapter:(NSInteger)chapter
{
    TReaderChapter *readerChapter = [[TReaderChapter alloc]init];
    readerChapter.chapterIndex = chapter;
    _curChpaterIndex = chapter;
    NSError *error = nil;

//    if (self.urlPath) {
//        readerChapter.chapterContent = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.urlPath] encoding:NSUTF8StringEncoding error:&error];
//
//        if (error) {
//            NSLog(@"open book chapter error:%@",error);
//            return nil;
//        }
//    }else
//    {
       NSString * bookPath = [XXTools getPath:self.bookName];
        readerChapter.chapterContent = [NSString stringWithContentsOfFile:bookPath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) {
            NSLog(@"open book chapter error:%@",error);
            return nil;
        }
//    }
    
    return readerChapter;
}

- (TReaderChapter *)openBookNextChapter
{
    return [self openBookWithChapter:_curChpaterIndex+1];
}

- (TReaderChapter *)openBookPreChapter
{
    return [self openBookWithChapter:_curChpaterIndex-1];
}

@end
