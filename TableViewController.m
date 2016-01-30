//
//  TableViewController.m
//  Simple
//
//  Created by vdemolombe on 29/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()


@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.salle=     [[Salle alloc] init];
    NSMutableArray *tmp=    [[NSMutableArray alloc] init];
    for(XYZEtudiant *toto in self.salle.etudiants) {
        [tmp addObject:toto];
    }
    for(XYZFormateur *toto in self.salle.formateurs) {
        [tmp addObject:toto];
    }
    self.personnes= [tmp copy];
    NSLog(@"check %lu, %lu", ([self.salle.etudiants count] + [self.salle.formateurs count]), [self.personnes count]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ([self.salle.etudiants count] + [self.salle.formateurs count]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellPerson" forIndexPath:indexPath];
    
    XYZPersonne *personne=  [self.personnes objectAtIndex:indexPath.row];
    cell.textLabel.text=    [NSString stringWithFormat:@"%@ %@", personne.nom, personne.prenom];
    // Configure the cell...
    if([personne isKindOfClass:[XYZEtudiant class]]) {
        cell.detailTextLabel.text=  @"Etudiant";
    }
    if([personne isKindOfClass:[XYZFormateur class]]) {
        cell.detailTextLabel.text=  @"Formateur";
    }
    NSString    *guid=  personne.photo;
    NSLog(@"image : %@", personne.photo);
    NSString *documentDirectory= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask , YES) lastObject];
    NSString    *filePath=  [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", guid]];
    cell.imageView.image=  [UIImage imageWithContentsOfFile:filePath];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if( [segue.identifier isEqualToString:@"segueTableDetail" ]) {
        
        NSIndexPath *ip=    [self.tableView indexPathForSelectedRow];
        TableViewController *detailVC= segue.destinationViewController;
        detailVC.person=    [self.personnes objectAtIndex:ip.row];
        
    }
}

@end
