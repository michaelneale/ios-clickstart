#import "CBViewController.h"
#import "CBNetworkClient.h"

@interface CBViewController ()
@property (weak, nonatomic) IBOutlet UITextView *theResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@end

@implementation CBViewController

/*
 * Initialise the view on loading.
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBox.prompt = @"Quick Start ios app for CloudBees";
    self.searchBox.delegate = self;
    self.theResults.text = @"";
    [[self searchBox] setPlaceholder:@"Search the knowledgebase"];
    self.theResults.delegate = self;
    self.view.backgroundColor = [UIColor blackColor];
    [[self theResults] setReturnKeyType:UIReturnKeyDone];
}


- (IBAction)callWeb:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *stuff = [CBNetworkClient httpGet:@"http://www.google.com"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self theResults] setText: stuff];
        });
    });

}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //look for a enter key press - and then apply the change!
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.theResults.text = searchBar.text;
    [searchBar resignFirstResponder];
}

/*
 * this is a placeholder for a method that you can unit tests
 * even if it is in a controller 
 */
- (NSString *)hello:(NSString *)name and:(NSString *)more {
    return name;
}

@end
