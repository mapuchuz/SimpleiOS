//
//  Salle.h
//  Simple
//
//  Created by vdemolombe on 27/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYZPersonne.h"
#import "XYZFormateur.h"
#import "XYZEtudiant.h"
#import "XYZIntervenant.h"

@interface XYZSalle : NSObject

//@property  NSMutableDictionary *dicoPersonnes;
//@property  NSArray *etudiants;
//@property  NSArray *formateurs;
@property  NSArray *personnes;

+(id)sharedSalle;

-(void)addPerson : (XYZPersonne *)personne;

-(void)testFunc;

-(id)init;

-(void)saveData;

-(void)loadData;

-(void)showListOfPerson;

-(void)removeAtIndex: (NSUInteger)index;

-(NSArray *)getEtudiants;

-(XYZPersonne *)getPersonneFromId:(NSUInteger)index;

@end
