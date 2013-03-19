#import "CBViewController.h"
#import "CBNetworkClient.h"

@interface CBViewController ()
@property (weak, nonatomic) IBOutlet UITextView *theResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBox;
@end

@implementation CBViewController

//TODO: UPDATE ME TO YOUR REAL APP!
NSString *const HOST = @"http://localhost:9000/api";

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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL saved = [CBNetworkClient saveDocument:[self.theResults text] withHost:HOST];
        if (!saved) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to save"
                                                            message:@"May not be able to connect to server."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *data = [CBNetworkClient performSearch:[searchBar text] withHost:HOST];
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
- (NSString *)hello:(NSString *)name and:(NSString *)more {
    return name;
}

@end
