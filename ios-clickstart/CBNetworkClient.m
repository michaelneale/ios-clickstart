#import "CBNetworkClient.h"

@implementation CBNetworkClient

+ (NSString *) httpGet:(NSString *)url {
    NSURL *site = [NSURL URLWithString:url];
    return [NSString stringWithContentsOfURL:site encoding:NSUTF8StringEncoding error:NULL];
}


@end
