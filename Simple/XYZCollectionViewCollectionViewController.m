//
//  XYZCollectionViewCollectionViewController.m
//  Simple
//
//  Created by vdemolombe on 02/02/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "XYZCollectionViewCollectionViewController.h"
#import "DetailViewController.h"



@interface XYZCollectionViewCollectionViewController ()

@end

@implementation XYZCollectionViewCollectionViewController

static NSString * const reuseIdentifier = @"imageCellule";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.etudiants= [[XYZSalle sharedSalle] getEtudiants];
    NSLog(@"coll did load") ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if( [segue.identifier isEqualToString:@"segueStudents" ]) {
        
        NSArray *ips=   [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *ip=    [ips objectAtIndex:0];
        
        //Controller destination retourné par le segue
        
        DetailViewController *detailVC= segue.destinationViewController;

        detailVC.personneAAfficher=      [self.etudiants objectAtIndex:ip.row];
    }
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return [self.etudiants count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellforitematidbednofzej");
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    XYZPersonne *personne= self.etudiants[indexPath.row]; //[[XYZSalle sharedSalle] getPersonneFromId:indexPath.row];
    // Configure the cell
    if( [personne isKindOfClass:[XYZEtudiant class]] ) {
        ((XYZCollCellCollectionViewCell *) cell).imageCellule.image= [UIImage imageWithContentsOfFile:[personne getPhoto]];
        
    }
        return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
