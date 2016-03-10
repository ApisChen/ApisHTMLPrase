//
//  HTMLParser.m
//  StackOverflow
//
//  Created by Ben Reeves on 09/03/2010.
//  Copyright 2010 Ben Reeves. All rights reserved.
//

#import "HTMLParser.h"


@implementation HTMLParser

-(HTMLNode*)doc
{
	if (_doc == NULL)
		return NULL;
	
	return [[HTMLNode alloc] initWithXMLNode:(xmlNode*)_doc];
}

-(HTMLNode*)html
{
	if (_doc == NULL)
		return NULL;
	
	return [[self doc] findChildTag:@"html"];
}

-(HTMLNode*)head
{
	if (_doc == NULL)
		return NULL;

	return [[self doc] findChildTag:@"head"];
}

-(HTMLNode*)body
{
	if (_doc == NULL)
		return NULL;
	
	return [[self doc] findChildTag:@"body"];
}

-(id)initWithString:(NSString*)string error:(NSError**)error
{ 
	if (self = [super init])
	{
		_doc = NULL;
		
		if ([string length] > 0)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
			// _doc = htmlParseDoc((xmlChar*)[string UTF8String], enc);
			int optionsHtml = HTML_PARSE_RECOVER;
			optionsHtml = optionsHtml | HTML_PARSE_NOERROR; //Uncomment this to see HTML errors
			optionsHtml = optionsHtml | HTML_PARSE_NOWARNING;
			_doc = htmlReadDoc ((xmlChar*)[string UTF8String], NULL, enc, optionsHtml);
		}
		else 
		{
			if (error) {
				*error = [NSError errorWithDomain:@"HTMLParserdomain" code:1 userInfo:nil];
			}
		}
	}
	
	return self;
}

-(id)initWithData:(NSData*)data error:(NSError**)error
{
	if (self = [super init])
	{
		_doc = NULL;

		if (data)
		{
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
			//_doc = htmlParseDoc((xmlChar*)[data bytes], enc);
			
			_doc = htmlReadDoc((xmlChar*)[data bytes],
							 "",
							enc,
							XML_PARSE_NOERROR | XML_PARSE_NOWARNING);
		}
		else
		{
			if (error) 
			{
				*error = [NSError errorWithDomain:@"HTMLParserdomain" code:1 userInfo:nil];
			}

		}
	}
	
	return self;
}

-(id)initWithContentsOfURL:(NSURL*)url error:(NSError**)error
{
	
	NSData * _data = [[NSData alloc] initWithContentsOfURL:url options:0 error:error];

	if (_data == nil || *error)
	{
		return nil;
	}
	
	self = [self initWithData:_data error:error];
	
	return self;
}


-(void)dealloc
{
	if (_doc)
	{
		xmlFreeDoc(_doc);
	}

}

+ (NSArray *)priseHTML:(NSString *)html {
    
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode children];
    
    for (HTMLNode *node in inputNodes) {
        
        if (node.nodetype == HTMLIFrame) {
            NSString *videoUrl = [node getAttributeNamed:@"src"];
            if (videoUrl.length>0) {
                [array addObject:@{
                                   HTMLPraseVideo:videoUrl
                                   }
                 ];
            }
        }
        
        NSArray *childNodes = [node children];
        if (childNodes.count > 0) {
            if (childNodes.count == 1) {
                HTMLNode *theNode = [childNodes objectAtIndex:0];
                if (theNode.nodetype == HTMLImageNode) {
                    NSString *picUrl = [theNode getAttributeNamed:@"src"];
                    if (picUrl.length>0) {
                        [array addObject:@{
                                            HTMLPrasePicture:picUrl
                                            }
                         ];
                    }
                }
                if (theNode.nodetype == HTMLStrongNode) {
                    if (theNode.contents.length>0) {
                        [array addObject:@{
                                            HTMLPraseTitle:theNode.contents
                                            }];
                    }
                }
                if (theNode.nodetype == HTMLTextNode) {
                    if (theNode.rawContents.length>0) {
                        [array addObject:@{
                                            HTMLPraseContent:theNode.rawContents
                                            }];
                    }
                }
                
            }else{
                if (node.nodetype == HTMLBlockQuoteNode) {
                    for (HTMLNode *node1 in childNodes) {
                        if (node1.nodetype == HTMLPNode) {
                            if (node1.contents.length>0) {
                                [array addObject:@{
                                                    HTMLPraseSubText:node1.contents
                                                    }];
                            }
                        }
                    }
                }else{
                    NSMutableString *contentString = [[NSMutableString alloc]init];
                    for (HTMLNode *node1 in childNodes) {
                        if (node1.nodetype == HTMLTextNode) {
                            [contentString appendString:node1.rawContents];
                            if (node1.nextSibling.nodetype != HTMLHrefNode) {
                                [contentString appendString:@"\n"];
                            }
                        }
                        if (node1.nodetype == HTMLHrefNode) {
                            [contentString appendString:node1.contents];
                        }
                    }
                    if (contentString.length>0) {
                        [array addObject:@{
                                            HTMLPraseSubText:contentString
                                            }];
                    }
                }
                
            }
        }
    }
    
    return [array copy];
}

@end
