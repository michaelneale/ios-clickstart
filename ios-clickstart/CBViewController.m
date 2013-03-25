#import "CBViewController.h"
#import "CBNetworkClient.h"

@interface CBViewController ()
@property (weak, nonatomic) IBOutlet UITextView *theResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;

@end

@implementation CBViewController



//TODO: UPDATE ME TO YOUR REAL APP!
static NSString *const HOST = @"http://localhost:9000/api";

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




- (IBAction)saveUpdate:(id)sender {
    CBNetworkClient *client = [CBNetworkClient sharedNetworkClient];
    NSString *docText = [[self theResults] text];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL saved = [client saveDocument:docText withHost:HOST];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!saved) {
                [self showMessage: @"Unable to save" message:@"may not be able to connect to the server"];
            }
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
    
    CBNetworkClient *client = [CBNetworkClient sharedNetworkClient];
    NSString *searchText = [searchBar text];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *data = [client performSearch:searchText withHost:HOST];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data != nil) {
                [[self theResults] setText: [data valueForKeyPath:@"result"]];
            } else {
                [[self theResults] setText: @"Nothing found"];
            }
        });
    });    
    [searchBar resignFirstResponder];
}


/*
 * this is a placeholder for a method that you can unit tests
 * even if it is in a controller 
 */
- (NSString *)hello:(NSString *)name more:(NSString *)more {
    return name;
}




- (void) showMessage:(NSString *)heading message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:heading
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

@end
