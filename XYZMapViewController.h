//
//  XYZMapViewController.h
//  Simple
//
//  Created by vdemolombe on 05/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface XYZMapViewController : UIViewController

@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *lattUIText;
@property (weak, nonatomic) IBOutlet UITextField *longoUIText;
@property (weak, nonatomic) IBOutlet UITextField *altiUIText;

@property (weak, nonatomic) IBOutlet UILabel *adresseLabel;
- (IBAction)geoBtn:(UIButton *)sender;
- (IBAction)markerBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *uneImageAMoi;

@property (weak, nonatomic) IBOutlet MKMapView *mappeViou;
@property   CLPlacemark *place;



@end
