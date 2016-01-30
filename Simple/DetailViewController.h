//
//  DetailViewController.h
//  Simple
//
//  Created by vdemolombe on 28/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZPersonne.h"
#import "XYZEtudiant.h"
#import "XYZFormateur.h"


@interface DetailViewController : UIViewController

- (IBAction)RetourBtn:(UIButton *)sender;

@property XYZPersonne *person;
@property (weak, nonatomic) IBOutlet UILabel *nomLabel;
@property (weak, nonatomic) IBOutlet UILabel *prenomLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageUIimage;

@end
