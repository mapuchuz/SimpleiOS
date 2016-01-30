//
//  TableViewController.h
//  Simple
//
//  Created by vdemolombe on 29/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Salle.h"

@interface TableViewController : UITableViewController

@property (strong, nonatomic) Salle *salle;

@property (strong, nonatomic) NSArray *personnes;

@property XYZPersonne *person;

@end
