//
//  AchievementDefinitionsTableViewController.m
//  Scouting
//
//  Created by Doug Croft on 3/7/15.
//  Copyright (c) 2015 Doug Croft. All rights reserved.
//

#import "AchievementDefinitionsTableViewController.h"
#import "AchievementDefinition.h"

@interface AchievementDefinitionsTableViewController ()
@property (strong, nonatomic) NSMutableArray *achievementDefinitionsArray;

@end

@implementation AchievementDefinitionsTableViewController

#pragma mark - Lazy Instantiation
-(NSMutableArray *)achievementDefinitionsArray
{
    if (_achievementDefinitionsArray)
    {
        return _achievementDefinitionsArray;
    }
    else
    {
        _achievementDefinitionsArray = [@{} mutableCopy];
    }
    return _achievementDefinitionsArray;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated
{
    // Form the local datastore query for achievement definitions
    PFQuery *queryFromLocalDatastore = [PFQuery queryWithClassName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION];
    [queryFromLocalDatastore fromLocalDatastore];
    
    // Load the local list of achievement definitions
    [queryFromLocalDatastore findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"Error in viewDidAppear (from cached) - AchievementDefinitionsTableViewController");
        }
        else
        {
            if ([objects count]>0) {
                self.achievementDefinitionsArray = [objects mutableCopy];
                [self.tableView reloadData];
            }
            else
            {
                // Form the query for achievement definitions
                PFQuery *queryFromParse = [PFQuery queryWithClassName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION];
            
                // Load the list of achievement definitions
                [queryFromParse findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (error)
                    {
                        NSLog(@"Error in viewDidAppear (over network) - AchievementDefinitionsTableViewController");
                    }
                    else
                    {
                        self.achievementDefinitionsArray = [objects mutableCopy];
                        [PFObject pinAllInBackground:self.achievementDefinitionsArray];
                        [self.tableView reloadData];
                    }
                }];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.achievementDefinitionsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Obtain a cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"achievementDefinitionCell" forIndexPath:indexPath];
    
    // Obtain an AchievementDefinition
    AchievementDefinition *achievementDefinition = self.achievementDefinitionsArray[indexPath.row];
    
    // Configure the cell
    cell.textLabel.text = achievementDefinition.title;
    
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

@end
