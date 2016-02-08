//
//  TableViewController.m
//  Simple
//
//  Created by vdemolombe on 29/01/2016.
//  Copyright © 2016 vdemolombe. All rights reserved.
//

#import "TableViewController.h"
#import "XYZCellCustomeTableViewCell.h"
#import "DetailViewController.h"


@interface TableViewController ()


@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    UIActivityIndicatorView *av =   [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    av.center=self.view.center;
    av.color=   [UIColor blueColor];
    [av startAnimating];
    [self.view addSubview:av];
    
    #pragma mark - threader un bout de code
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{

                    self.salle=   [XYZSalle sharedSalle];//  [[XYZSalle alloc] init];
   
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"Pépé a fait.");
            [av stopAnimating];
            [self.tableView reloadData];
        });
    });

    
    self.refreshControl=    [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor=    [UIColor purpleColor];
    self.refreshControl.tintColor=          [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshMe) forControlEvents:UIControlEventValueChanged];
    
    
}

-(void)refreshMe {
    
     self.salle=  [XYZSalle sharedSalle];
   
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void)viewWillAppear:(BOOL)totoYES {
//    self.salle=     [XYZSalle sharedSalle];
   [self.tableView reloadData];
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
    return self.salle.personnes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    XYZPersonne *personne=  [self.salle.personnes objectAtIndex:indexPath.row];
    XYZPersonne *personne= [[XYZSalle sharedSalle] getPersonneFromId:indexPath.row];
    
    
    //  si étudiant
    if([personne isKindOfClass:[XYZEtudiant class]]) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellCustome" forIndexPath:indexPath];

        ((XYZCellCustomeTableViewCell *)cell).texteCellCustom.text=
            [NSString stringWithFormat:@"%@ %@", personne.nom, personne.prenom];
        
         ((XYZCellCustomeTableViewCell *)cell).imageCellCustom.image=  [UIImage imageWithContentsOfFile:personne.getPhoto];
        
        ((XYZCellCustomeTableViewCell *)cell).typeCustomUILabel.text=
                NSLocalizedString(@"key_etudiant",nil);
        
        return cell;
        
    } else {
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellPerson" forIndexPath:indexPath];
    
    cell.textLabel.text=    [NSString stringWithFormat:@"%@ %@", personne.nom, personne.prenom];
    // Configure the cell...
    if([personne isKindOfClass:[XYZEtudiant class]]) {
        cell.detailTextLabel.text= NSLocalizedString(@"key_etudiant",nil);
    }
    if([personne isKindOfClass:[XYZFormateur class]]) {
        cell.detailTextLabel.text=  NSLocalizedString(@"key_formateur",nil);
    }
    if([personne isKindOfClass:[XYZIntervenant class]]) {
        cell.detailTextLabel.text=  NSLocalizedString(@"key_intervenant",nil);
    }

    cell.imageView.image=  [UIImage imageWithContentsOfFile:personne.getPhoto];
        
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     XYZPersonne *personne=  [self.salle.personnes objectAtIndex:indexPath.row];
    if([personne isKindOfClass:[XYZEtudiant class]]) {
        return 150;
    } else {
        return 50;
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        //[self.salle removeAtIndex:indexPath.row];
        [[XYZSalle sharedSalle] removeAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
        
        //Destination du segue
        DetailViewController *detailVC= segue.destinationViewController;
        detailVC.personneAAfficher=    [self.salle.personnes objectAtIndex:ip.row];
        
    }
}

@end
