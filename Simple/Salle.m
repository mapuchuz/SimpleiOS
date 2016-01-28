//
//  Salle.m
//  Simple
//
//  Created by vdemolombe on 27/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "Salle.h"

@implementation Salle

-(void)addPerson : (XYZPersonne *)personne  {
    
    if ([personne isKindOfClass:[XYZFormateur class]])
    {
        NSMutableArray *tmpFormateurs = [NSMutableArray arrayWithArray:self.formateurs];
        [tmpFormateurs addObject:personne];
        self.formateurs =[tmpFormateurs copy];
    }
    if ([personne isKindOfClass:[XYZEtudiant class]])
    {
        NSMutableArray *tmpEtudiant = [NSMutableArray arrayWithArray:self.etudiants];
        [tmpEtudiant addObject:personne];
        self.etudiants =[tmpEtudiant copy];
    }
}

-(void)testFunc {
    NSLog(@"testfunc appelée");
}

-(id)init {
    self=   [super init];
    [self loadData];
    return self;
}

-(void)loadData {
    NSArray *paths=  [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentURL= [paths lastObject];
    NSString *path= [NSString stringWithFormat:@"%@/%@",documentURL.path,@"salle.txt"];

    NSData *data;
    NSKeyedUnarchiver *decoder;
    data=   [NSData dataWithContentsOfFile:path];
    decoder=    [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    int effectif=   [decoder decodeIntegerForKey:@"NombrePersonnes"];
    
    NSMutableArray *personnesSauvees=   [[NSMutableArray alloc] init];
    NSMutableArray *etudiantsSauvees=   [[NSMutableArray alloc] init];
    NSMutableArray *formateursSauvees=  [[NSMutableArray alloc] init];
    
    for(int i=1;i<=effectif;i++) {
        [personnesSauvees addObject:[decoder decodeObjectForKey:[NSString stringWithFormat:@"%i", i]]];
    }
    
    for(XYZPersonne* personne in personnesSauvees) {
        if([personne isKindOfClass:[XYZEtudiant class]]) {
            [etudiantsSauvees addObject:personne];
        }
        if([personne isKindOfClass:[XYZFormateur class]]) {
            [formateursSauvees addObject:personne];
        }
    }
    self.etudiants=     [etudiantsSauvees copy];
    self.formateurs=    [formateursSauvees copy];
    NSLog(@"il y a %lu étudiants", (unsigned long)self.etudiants.count);
    NSLog(@"il y a %lu formateurs", (unsigned long)self.formateurs.count);
    
}

-(void)saveData {
    NSMutableData *data=    [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver=  [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    int i=1;
    int nombre=     self.formateurs.count + self.etudiants.count;
    [archiver encodeInteger:nombre forKey:@"NombrePersonnes"];
    for(XYZPersonne* personne in self.formateurs) {
        NSLog(@"sauve formateur i:%ul", i);
        [archiver encodeObject:personne forKey:[NSString stringWithFormat:@"%i", i++]];
    }
    
    for(XYZPersonne* personne in self.etudiants) {
                NSLog(@"sauve etudiant i:%ul", i);
        [archiver encodeObject:personne forKey:[NSString stringWithFormat:@"%i", i++]];
    }

    [archiver finishEncoding];
    
    NSArray *paths=  [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentURL= [paths lastObject];
    NSString *path= [NSString stringWithFormat:@"%@/%@",documentURL.path,@"salle.txt"];
    BOOL result=    [data writeToFile:path atomically:YES];

}




-(int)effectifs {
    int nombre=0;
    for(NSString *clef in self.dicoPersonnes) {
        nombre += [self.dicoPersonnes[clef] count];
    }
    return nombre;
}
@end
