//
//  XYZDetMapViewController.m
//  Simple
//
//  Created by vdemolombe on 05/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "XYZDetMapViewController.h"

@interface XYZDetMapViewController ()

@end

@implementation XYZDetMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"place: %@ ", self.place.country);
    self.pays.text= self.place.country;
    self.ville.text=    self.place.locality;
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
