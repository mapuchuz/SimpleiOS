//
//  Salle.m
//  Simple
//
//  Created by vdemolombe on 27/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "XYZSalle.h"

@implementation XYZSalle

+(id)sharedSalle {
    static XYZSalle *sharedMySalle = nil;
    if( sharedMySalle==nil ) {
        sharedMySalle=  [[self alloc] init];
    }
    return sharedMySalle;
}

-(void)addPerson : (XYZPersonne *)personne  {

    NSMutableArray *tmpPersonnes = [NSMutableArray arrayWithArray:self.personnes];
    [tmpPersonnes addObject:personne];
    self.personnes =[tmpPersonnes copy];
    
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
    
    // on ralentit pour tester les threads
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        for( int i=0; i<20; i++) {
            [NSThread sleepForTimeInterval:0.05];
            NSLog(@"Patience : %i", i);
        }
    
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            [self updateLabelWhenBackgroundDone];
//        });
//    });
        
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
    

    self.personnes=     [personnesSauvees copy];
    NSLog(@"LOAD : %lu", (unsigned long)[self.personnes count]);
    for(XYZPersonne *x in self.personnes) {
        NSLog(@"P: %@,%@", x.nom, x.prenom);
    }

    
}

-(void)saveData {
    NSMutableData *data=    [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver=  [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    int i=1;

    int nombre=     self.personnes.count;
    [archiver encodeInteger:nombre forKey:@"NombrePersonnes"];

    for(XYZPersonne* personne in self.personnes) {
        NSLog(@"sauve personne i:%ul", i);
        [archiver encodeObject:personne forKey:[NSString stringWithFormat:@"%i", i++]];
    }

    [archiver finishEncoding];
    
    NSArray *paths=  [[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentURL= [paths lastObject];
    NSString *path= [NSString stringWithFormat:@"%@/%@",documentURL.path,@"salle.txt"];
    BOOL result=    [data writeToFile:path atomically:YES];

}

-(void)showListOfPerson {
    NSLog(@" ");
    NSLog(@"----- Liste des Personnes ---------------");
    for(XYZPersonne *form in self.personnes) {
        NSLog(@"Personne : %@, %@", form.nom, form.prenom);
    }
}

-(void)removeAtIndex:(NSUInteger)index {
    NSMutableArray *tmp=   [NSMutableArray arrayWithArray:self.personnes];
    [tmp removeObjectAtIndex:index];
    self.personnes= [tmp copy];
    [self saveData];
}

-(NSArray *)getEtudiants {
    NSMutableArray *tmp=    [[NSMutableArray alloc] init];
    for(XYZPersonne *p in self.personnes) {
        if( [p isKindOfClass:[XYZEtudiant class]]) {
            [tmp addObject:p];
        }
    }
    NSArray *etudiants= [tmp copy];
    return etudiants;
}

-(XYZPersonne *)getPersonneFromId:(NSUInteger)index {
    XYZPersonne *personne=  [self.personnes objectAtIndex:index];
    return personne;
}



@end
