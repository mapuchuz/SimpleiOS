//
//  XYZMapViewController.m
//  Simple
//
//  Created by vdemolombe on 05/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "XYZMapViewController.h"
#import "XYZDetMapViewController.h"

@interface XYZMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end

@implementation XYZMapViewController
CLLocation *currentLocaZion;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"ici localisation");
    self.locationManager=   [[CLLocationManager alloc] init];
    self.locationManager.delegate=  self;
    self.locationManager.desiredAccuracy=   kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=    kCLDistanceFilterNone;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
    
    self.mappeViou.delegate=self;
    [self.mappeViou setZoomEnabled:YES];
    [self.mappeViou setScrollEnabled:YES];
    self.mappeViou.showsUserLocation=   YES;
    
    //markers
    CLLocationCoordinate2D coord=  self.locationManager.location.coordinate;
    MKPointAnnotation *annot=   [[MKPointAnnotation alloc] init];
    annot.title=     self.adresseLabel.text;
    annot.coordinate=   coord;
    [self.mappeViou addAnnotation:annot];
    
    MKMapPoint annotPoint=  MKMapPointForCoordinate(coord);
    MKMapRect pointRect=    MKMapRectMake(annotPoint.x,annotPoint.y ,0.1 , 0.1);

    //    [self.mappeViou setVisibleMapRect:pointRect animated:YES];
//    NSLog(@"PATH: %@", [NSBundle pathForResource:ofType:inDirectory]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *loc = locations.lastObject;
    CLLocationDegrees lat= loc.coordinate.latitude;
    CLLocationDegrees lon= loc.coordinate.longitude;
    CLLocationDegrees alt=  loc.altitude;
    
    self.lattUIText.text= [NSString stringWithFormat:@"%.6f", lat];
    self.longoUIText.text= [NSString stringWithFormat:@"%.6f", lon];
    self.altiUIText.text= [NSString stringWithFormat:@"%.6f", alt];
    
    currentLocaZion=    loc;
//NSLog(@"local: %@ et %@", [NSString stringWithFormat:@"%.6f", lat],   [NSString stringWithFormat:@"%.6f", lon] );
 
      }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)geoBtn:(UIButton *)sender {
    CLGeocoder *geoc;
    NSString *maGeoc;
    if(!geoc) {
        geoc=   [[CLGeocoder alloc] init];
        [geoc reverseGeocodeLocation:currentLocaZion completionHandler: ^(NSArray *placeMarks, NSError *error) {
            if(error==nil && [placeMarks count]>0) {
                CLPlacemark *placeMark;
                placeMark=  [placeMarks lastObject];
                 self.adresseLabel.text =[NSString stringWithFormat:@"%@ %@\n %@ %@\n %@ %@",
                                        placeMark.subThoroughfare,
                                        placeMark.thoroughfare,
                                        placeMark.postalCode,
                                        placeMark.locality,
                                        placeMark.administrativeArea,
                                        placeMark.country
                                        ];
                self.place=  placeMark;
            }
        }];
        
    }
}

- (IBAction)markerBtn:(UIButton *)sender {
    //markers
    CLLocationCoordinate2D coord=  self.locationManager.location.coordinate;
    MKPointAnnotation *annot=   [[MKPointAnnotation alloc] init];
    annot.title=     self.place.locality;
    annot.coordinate=   coord;
    [self.mappeViou addAnnotation:annot];
    
    MKMapPoint annotPoint=  MKMapPointForCoordinate(coord);
    MKMapRect pointRect=    MKMapRectMake(annotPoint.x,annotPoint.y ,0.1 , 0.1);

        self.uneImageAMoi.image= [UIImage imageNamed:@"images.jpg"];
         NSLog(@"place in markBTN: %@", self.place.country);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView;
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];

            UIButton *rightButton=  [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            [rightButton addTarget:self
                            action:@selector(popo:) forControlEvents:UIControlEventTouchUpInside];
            
            pinView.rightCalloutAccessoryView=  rightButton;
            pinView.animatesDrop = YES;
            pinView.pinColor=   MKPinAnnotationColorPurple;
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"images.jpg"];
     //       pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

-(void)popo:(id)sender{
    NSLog(@"Annotation Click");
    [self performSegueWithIdentifier:@"segueMap" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if( [segue.identifier isEqualToString:@"segueMap" ]) {
            NSLog(@"place: %@", self.place.country);
        //Controller destination retourné par le segue
        XYZDetMapViewController *detailVC= segue.destinationViewController;
        detailVC.place=  self.place;
        
    }
    
}
@end
