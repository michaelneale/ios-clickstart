#import "CBAppDelegate.h"
#import "CBViewController.h"

@implementation CBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self.viewController = [[CBViewController alloc] initWithNibName:@"CBViewController_iPhone" bundle:nil];
  } else {
    self.viewController = [[CBViewController alloc] initWithNibName:@"CBViewController_iPad" bundle:nil];
  }
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
