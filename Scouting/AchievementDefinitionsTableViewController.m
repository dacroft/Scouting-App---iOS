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

@end

@implementation AchievementDefinitionsTableViewController

#pragma mark - View Creation

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        // The className to query on
        self.parseClassName = PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION;
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = PARSE_CLASS_PARAM_ACHIEVEMENT_DEFINITION_TITLE;
        
        // Enable Pull to refresh, but disable pagination
        self.pullToRefreshEnabled = NO;
        self.paginationEnabled = NO;
    }
    return self;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Configure Refresh Control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAchievementDefinitions) forControlEvents:UIControlEventValueChanged];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self refreshAchievementDefinitions];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh
- (PFQuery *)baseQuery
{
    // Return a query that finds all AchievementDefinitions.
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    return query;
}
- (void)refreshAchievementDefinitions
{
    // Look for AchievementDefinitions on the network
    [[self baseQuery] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            [self.refreshControl endRefreshing];
        }
        else
        {
            // Pin all the AchievementDefinitions obtained from the network on this device and trigger a reload of the table
            [PFObject unpinAllObjectsInBackgroundWithName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION block:^(BOOL succeeded, NSError *error) {
                [PFObject pinAllInBackground:objects withName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION block:^(BOOL succeeded, NSError *error) {
                    [self.refreshControl endRefreshing];
                    [self loadObjects];
                }];
            }];
        }
    }];
}
-(PFQuery *)queryForTable
{
    // Look at just AchievementDefinitions stored on the device locally for the canned loading done by this view
    return [[self baseQuery] fromLocalDatastore];
}

#pragma mark - Load the cells
-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    // Obtain a cell
    static NSString *cellIdentifier = @"achievementDefinitionCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Obtain an AchievementDefinition
    AchievementDefinition *achievementDefinition = (AchievementDefinition *)object;
    
    // Configure the cell
    cell.textLabel.text = achievementDefinition.title;
    
    return (PFTableViewCell *)cell;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
