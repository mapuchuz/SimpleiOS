//
//  XYZPhoneActionsController.m
//  Simple
//
//  Created by vdemolombe on 04/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "XYZPhoneActionsController.h"

@interface XYZPhoneActionsController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation XYZPhoneActionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tappedMail:(UIButton *)sender {
    MFMailComposeViewController *mailComposer=  [[MFMailComposeViewController alloc] init];
    mailComposer.delegate= self;
    [mailComposer setSubject:@"mon sujet"];
    [mailComposer setMessageBody:@"Ici le corps du message." isHTML:NO];
    [mailComposer setToRecipients:@[@"mapuchuz@gmail.com"]];
    [self presentViewController:mailComposer animated:YES completion:nil];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch(result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
            break;
        case MessageComposeResultSent:
            break;
    }
    NSLog(@"[self dismissViewControllerAnimated:YES completion:nil];");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)tappedTwitter:(UIButton *)sender {
    SLComposeViewController *social;
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        social= [[SLComposeViewController alloc] init];
        social= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [self presentViewController:social animated:YES completion:nil];
    }
    
//    [social setCompletionHandler:<#(SLComposeViewControllerCompletionHandler()completionHandler#>]
}
@end
