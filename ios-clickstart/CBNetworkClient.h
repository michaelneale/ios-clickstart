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

@end
