//
//  CBNetUtils.h
//  ios-clickstart
//
//  Created by Michael Neale on 15/03/13.
//  Copyright (c) 2013 Michael Neale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBNetworkClient : NSObject

+ (NSString *) httpGet:(NSString *)url;
+ (NSDictionary *) parseJSON:(NSString *)responseString;
+ (NSDictionary *) performSearch:(NSString *)terms withHost:(NSString *)url;
+ (NSString *) makeURL:(NSString *)url withPath:(NSString *)path;
+ (BOOL) saveDocument:(NSString *)doc withHost:(NSString *)host;

@end
