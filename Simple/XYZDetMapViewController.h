//
//  XYZDetMapViewController.h
//  Simple
//
//  Created by vdemolombe on 05/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface XYZDetMapViewController : UIViewController

@property   CLPlacemark *place;

@property (weak, nonatomic) IBOutlet UILabel *ville;

@property (weak, nonatomic) IBOutlet UILabel *pays;

@property (weak, nonatomic) IBOutlet UILabel *codePostal;

@end



