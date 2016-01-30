//
//  ViewController.m
//  Simple
//
//  Created by vdemolombe on 27/01/2016.
//  Copy/Users/vdemolombe/Desktop/Simple/Simple/ViewController.hright © 2016 vdemolombe. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate>
@end

@implementation ViewController
    NSArray *tableData; //pour la tableView des personne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"La vue est chargée");
    [self.maLabel setText:@"Hello from ViewDidLoad"];
    self.salle=     [[Salle alloc]init];
}

-(void)loadView {
    [super loadView];
   self.VoirListePersonuibutton.layer.cornerRadius = 10; // this value vary as per your desire
    self.VoirListePersonuibutton.clipsToBounds = YES;
    self.VoirListePersonuibutton.backgroundColor=   [UIColor yellowColor] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"La vue a reçu un warning mémoire");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"La vue a disparu");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"La vue est apparue.");
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"La vue va apparaître.");
}



- (IBAction)typePersonne:(UISwitch *)sender {
    NSLog(@"Switch");
    if(sender.on) {
        [self.typePersonne2 setText:@"Participant"];
    } else {
        [self.typePersonne2 setText:@"Formateur"];
    }
}

- (IBAction)Valider:(UIButton *)sender {
    // vérifier nom et prénom sont renseignés
    if (self.lenom.text && self.lenom.text.length > 0
        && self.leprenom.text && self.leprenom.text.length > 0) {
        NSLog(@"Le nom et prenom  trouvés");
 
        // la personne
        XYZPersonne *unePersonne;
        // la personne est participant
        if(self.monSwitch.on) {
            unePersonne= [[XYZEtudiant alloc] init];
        } else {
        // la personne est formateur
            unePersonne= [[XYZFormateur alloc] init];
        }

        //  renseigner les champs de la personne
        [unePersonne setNom:     self.lenom.text];
        [unePersonne setPrenom:  self.leprenom.text];
        
        //  ajouter la personne dans la salle
        [self.salle addPerson: unePersonne];
        
    // user n'a pas renseigné le nom ou le prenom
    } else {
        [self.lenom setText:@"Entrez un nom"];
        [self.leprenom setText:@"Entrez un prénom"];
        NSLog(@"Pas de nom ou prenom");
    }
}

- (IBAction)sauver:(UIButton *)sender {
    NSLog(@"je clique d-save");
    [self.salle saveData];
}

- (IBAction)chargeImage:(UIButton *)sender {
    UIImagePickerController *picker=    [[UIImagePickerController alloc] init];
    picker.delegate=    self;
    picker.allowsEditing=   YES;
    picker.sourceType=  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *choosenImage=  info[UIImagePickerControllerEditedImage];
    self.monOmageImageView.image=   choosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
       [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)ViewListOfPerson:(UIButton *)sender {
    [self.salle showListOfPerson];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [segue.identifier isEqualToString:@"segueDetails" ]) {
        // la personne
        XYZPersonne *unePersonne;
        // la personne est participant
        if(self.monSwitch.on) {
            unePersonne= [[XYZEtudiant alloc] init];
        } else {
            // la personne est formateur
            unePersonne= [[XYZFormateur alloc] init];
        }
        
        //  renseigner les champs de la personne
        [unePersonne setNom:     self.lenom.text];
        [unePersonne setPrenom:  self.leprenom.text];
        
        // sauver image sur disque
        NSString *documentDirectory= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask , YES) lastObject];
        NSString    *guiid= [[NSUUID new] UUIDString];
        NSString    *filePath=  [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", guiid]];
        UIImage *choosenImage=   self.monOmageImageView.image;
        NSData *imageData=  UIImagePNGRepresentation(choosenImage);
        BOOL result=    [imageData writeToFile:filePath atomically:YES];
        [unePersonne setPhoto:guiid];
             
        //  ajouter la personne dans la salle
        [self.salle addPerson: unePersonne];
        [self.salle saveData];
        DetailViewController *detailVC= segue.destinationViewController;
        detailVC.person=    unePersonne;
        
    }
}

@end
