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

@interface Salle : NSObject

@property  NSMutableDictionary *dicoPersonnes;
@property  NSArray *etudiants;
@property  NSArray *formateurs;

-(void)addPerson : (XYZPersonne *)personne;

-(void)testFunc;

-(id)init;

-(int)effectifs;

-(void)saveData;

-(void)loadData;

-(void)showListOfPerson;

@end
