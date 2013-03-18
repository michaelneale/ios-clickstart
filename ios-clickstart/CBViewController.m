#import "CBViewController.h"
#import "CBNetworkClient.h"

@interface CBViewController ()
@property (weak, nonatomic) IBOutlet UITextView *theResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@end

@implementation CBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theResults.text = @"Initial value";
    [[self theResults] setEditable:FALSE];
}


- (IBAction)theButton:(UIButton *)sender {
    [[self theResults] setText:[[sender titleLabel] text]];
    [[self theResults] setText:@"Stuff goes in here"];
}

- (IBAction)callWeb:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *stuff = [CBNetworkClient httpGet:@"http://www.google.com"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self theResults] setText: stuff];
        });
    });

}

- (NSString *)hello:(NSString *)name and:(NSString *)more {
    return name;
}

@end
