//
//  DetailViewController.m
//  Simple
//
//  Created by vdemolombe on 28/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.nomLabel setText:self.personneAAfficher.nom];
    [self.prenomLabel setText:self.personneAAfficher.prenom];
    //  afficher la photo de la personne
    NSString    *guid=  self.personneAAfficher.photo;
    NSString *documentDirectory= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask , YES) lastObject];
    NSString    *filePath=  [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", guid]];
    self.imageUIimage.image=  [UIImage imageWithContentsOfFile:filePath];
    //  afficher le type de la personne(etudiant ou formateur)
    NSString *montype;
    if( [self.personneAAfficher isKindOfClass:[XYZEtudiant class]] ) { montype=  NSLocalizedString(@"key_etudiant", nil);}
    if( [self.personneAAfficher isKindOfClass:[XYZFormateur class]] ) { montype= NSLocalizedString(@"key_formateur", nil);}
    if( [self.personneAAfficher isKindOfClass:[XYZIntervenant class]] ) { montype=  NSLocalizedString(@"key_intervenant", nil);}
    [self.statusLabel setText:montype];
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

- (IBAction)RetourBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
