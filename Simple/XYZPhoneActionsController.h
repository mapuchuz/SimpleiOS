//
//  XYZPhoneActionsController.h
//  Simple
//
//  Created by vdemolombe on 04/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface XYZPhoneActionsController : UIViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *mailBtn;
@property (weak, nonatomic) IBOutlet UIButton *faceboucBtn;


- (IBAction)tappedTwitter:(UIButton *)sender;

@end
