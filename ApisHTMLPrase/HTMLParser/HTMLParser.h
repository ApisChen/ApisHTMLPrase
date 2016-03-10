//
//  HTMLParser.h
//  StackOverflow
//
//  Created by Ben Reeves on 09/03/2010.
//  Copyright 2010 Ben Reeves. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>
#import "HTMLNode.h"

#define HTMLPraseVideo      @"videoUrl"
#define HTMLPrasePicture    @"pictureUrl"
#define HTMLPraseTitle      @"titleText"
#define HTMLPraseContent    @"contentText"
#define HTMLPraseSubText    @"subText"

@class HTMLNode;

@interface HTMLParser : NSObject 
{
	@public
	htmlDocPtr _doc;
}

-(id)initWithContentsOfURL:(NSURL*)url error:(NSError**)error;
-(id)initWithData:(NSData*)data error:(NSError**)error;
-(id)initWithString:(NSString*)string error:(NSError**)error;

//Returns the doc tag
-(HTMLNode*)doc;

//Returns the body tag
-(HTMLNode*)body;

//Returns the html tag
-(HTMLNode*)html;

//Returns the head tag
- (HTMLNode*)head;

//解析好的数据
+ (NSArray *)priseHTML:(NSString *)html;

@end
