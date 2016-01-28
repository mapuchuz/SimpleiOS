//
//  ViewController.m
//  Simple
//
//  Created by vdemolombe on 27/01/2016.
//  Copy/Users/vdemolombe/Desktop/Simple/Simple/ViewController.hright © 2016 vdemolombe. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"La vue est chargée");
    [self.maLabel setText:@"Hello from ViewDidLoad"];
    self.salle=     [[Salle alloc]init];
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
    [self.salle saveData];
}

@end
