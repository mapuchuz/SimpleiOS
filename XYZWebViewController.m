//
//  XYZWebViewController.m
//  Simple
//
//  Created by vdemolombe on 04/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "XYZWebViewController.h"

@interface XYZWebViewController ()  <UIWebViewDelegate>

@end

@implementation XYZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSURL *url= [[NSURL alloc] initWithString:@"http://www.google.com"];
//    NSURLRequest *req=  [[NSURLRequest alloc] initWithURL:url];
//    self.maWebView.scalesPageToFit= YES;
//    [self.maWebView loadRequest:req];
    
    NSString *mapage=   [[NSBundle mainBundle] pathForResource:@"localhtml2" ofType:@"html" inDirectory:nil];
    NSString *inhtml=   [NSString stringWithContentsOfFile:mapage encoding:NSUTF8StringEncoding error:nil];
    
//    NSString *script=   @"<script>alert(\"mon titre\", \"coucou les petits loups\")</script>";
//    NSString *script=   @"<script>alert( 'coucou les petits renards')</script>";
//    inhtml= [inhtml stringByAppendingString:script];
    
    self.maWebView.delegate=self;
    
    [self.maWebView loadHTMLString:inhtml baseURL:nil];
    
}

-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *URL= [request URL];
    if([[URL scheme] isEqualToString:@"callmycode"]) {
        NSString *urlString=    [[request URL] absoluteString];
        NSArray *urlParts= [urlString componentsSeparatedByString:@":"];
        
        if([urlParts count]>1) {
            NSArray *parameters=    [urlParts[1] componentsSeparatedByString:@"&"];
            NSString    *methodName=    parameters[0];
            NSString    *varName=       parameters[1];
            
            NSString    *message=   [NSString stringWithFormat:@"Obj-c from js with methodName=%@ and variableName=%@", methodName, varName];
            
            UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Supèèère"  message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil, nil];
            [alert show];
        }
    }
    return YES;
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

@end
