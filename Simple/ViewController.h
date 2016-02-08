//
//  ViewController.h
//  Simple
//
//  Created by vdemolombe on 27/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZSalle.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *maLabel;

@property (weak, nonatomic) IBOutlet UILabel *typePersonne2;

@property (weak, nonatomic) IBOutlet UITextField *lenom;

@property (weak, nonatomic) IBOutlet UITextField *leprenom;

@property (weak, nonatomic) IBOutlet UISwitch *monSwitch;

@property (strong, nonatomic) XYZSalle *salle;

@property (weak, nonatomic) IBOutlet UIButton *VoirListePersonuibutton;

@property (weak, nonatomic) IBOutlet UITableView *maTable;
@property (weak, nonatomic) IBOutlet UIImageView *monOmageImageView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *typePersonneSegmentUI;
- (IBAction)typePersonneUISegments:(UISegmentedControl *)sender;

- (IBAction)typePersonne:(UISwitch *)sender;
- (IBAction)Valider:(UIButton *)sender;

- (IBAction)sauver:(UIButton *)sender;
- (IBAction)chargeImage:(UIButton *)sender;

- (IBAction)ViewListOfPerson:(UIButton *)sender;
@end

