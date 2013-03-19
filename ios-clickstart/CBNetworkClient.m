#import "CBNetworkClient.h"

@implementation CBNetworkClient

+ (NSString *) httpGet:(NSString *)url {
    NSURL *site = [NSURL URLWithString:url];
    return [NSString stringWithContentsOfURL:site encoding:NSUTF8StringEncoding error:NULL];
}

+ (NSString *) makeURL:(NSString *)url withPath:(NSString *)path {
    return [[url stringByAppendingString:@"/"] stringByAppendingString:path];
}

+ (NSDictionary *) performSearch:(NSString *)terms withHost:(NSString *)host {
    NSString *url = [CBNetworkClient makeURL: host withPath:[@"/search/" stringByAppendingString:terms]];
    NSString *data = [CBNetworkClient httpGet:url];
    return [self parseJSON:data];
}

+ (BOOL) saveDocument:(NSString *)doc withHost:(NSString *)host {
    NSString *path = [@"/store/" stringByAppendingString:doc];
    NSString *data = [CBNetworkClient httpGet:[CBNetworkClient makeURL:host withPath:path]];
    return [self parseJSON:data] != nil;
}


+ (NSDictionary *) parseJSON:(NSString *)responseString {
    if (responseString == nil) return nil;
    NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];    
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if([object isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *) object;
    } else {
        return nil;
    }
}


@end
