#import "CBViewController.h"

@interface CBViewController ()
@property (weak, nonatomic) IBOutlet UILabel *theLabel;

@end

@implementation CBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theLabel.text = @"Initial value";
}


- (IBAction)theButton:(UIButton *)sender {
    [[self theLabel] setText:[[sender titleLabel] text]];
    //self.theLabel.text = sender.titleLabel.text;
}

- (IBAction)callWeb:(id)sender {
    NSURL *theSite = [NSURL URLWithString:@"http://www.google.com"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *stuff = [NSString stringWithContentsOfURL:theSite encoding:NSUTF8StringEncoding error:NULL];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self theLabel] setText: stuff];
        });
    });

}

- (NSString *)hello:(NSString *)name and:(NSString *)more {
    return name;
}

@end
