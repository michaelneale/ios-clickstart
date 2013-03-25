#import "CBNetworkClient.h"

@implementation CBNetworkClient


- (NSString *) stringHttpGetContentsAtURL:(NSString *)url {
    NSURL *site = [NSURL URLWithString:url];    
    return [NSString stringWithContentsOfURL:site encoding:NSUTF8StringEncoding error:NULL];
}


- (NSString *) makeURL:(NSString *)url withPath:(NSString *)path {
    return [url stringByAppendingPathComponent:path];
}



- (NSDictionary *) performSearch:(NSString *)terms withHost:(NSString *)host {
    NSString *url = [self makeURL: host withPath:[@"search/" stringByAppendingString:[terms stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    NSString *data = [self stringHttpGetContentsAtURL:url];
    return [self parseJSON:data];
}



- (BOOL) saveDocument:(NSString *)doc withHost:(NSString *)host {
    
    NSString *path = [@"store/" stringByAppendingString:[doc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *data = [self stringHttpGetContentsAtURL:[self makeURL:host withPath:path]];
    return [self parseJSON:data] != nil;
}






- (NSDictionary *) parseJSON:(NSString *)responseString {
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


+ (CBNetworkClient *)sharedNetworkClient {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



@end
