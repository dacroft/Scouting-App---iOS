//
//  AchievementDefinitionsTableViewController.m
//  Scouting
//
//  Created by Doug Croft on 3/7/15.
//  Copyright (c) 2015 Doug Croft. All rights reserved.
//

#import "AchievementDefinitionsTableViewController.h"
#import "AchievementDefinition.h"
#include<unistd.h>
#include<netdb.h>

@interface AchievementDefinitionsTableViewController ()

@end

@implementation AchievementDefinitionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Get the achievement definitions from the network in case they have changed from what is pinned.  If we get something, pin them and request a reload of the data.
    // Configure Refresh Control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshAchievementDefinitions) forControlEvents:UIControlEventValueChanged];
//    [self refreshAchievementDefinitions];
//    PFQuery *queryFromParse = [PFQuery queryWithClassName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION];
//    [queryFromParse findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (error)
//        {
//            NSLog(@"Error in viewDidLoad (over network) - AchievementDefinitionsTableViewController");
//        }
//        else
//        {
//            [PFObject pinAllInBackground:objects];
//            [self.tableView reloadData];
//        }
//    }];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self refreshAchievementDefinitions];
}
- (PFQuery *)baseQuery
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    return query;
}

- (void)refreshAchievementDefinitions
{
    [[self baseQuery] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            [self.refreshControl endRefreshing];
        }
        else
        {
            
            [PFObject unpinAllObjectsInBackgroundWithName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION block:^(BOOL succeeded, NSError *error) {
                [PFObject pinAllInBackground:objects withName:PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION block:^(BOOL succeeded, NSError *error) {
                    [self.refreshControl endRefreshing];
                    [self loadObjects];
                }];
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

-(PFQuery *)queryForTable
{
    //PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    //if (![self isNetworkAvailable])
    //{
    return [[self baseQuery] fromLocalDatastore];
    //}
    //return query;
}
//-(BOOL)isNetworkAvailable
//{
//    char *hostname;
//    struct hostent *hostinfo;
//    hostname = "google.com";
//    hostinfo = gethostbyname (hostname);
//    if (hostinfo == NULL){
//        NSLog(@"-> no connection!\n");
//        return NO;
//    }
//    else{
//        NSLog(@"-> connection established!\n");
//        return YES;
//    }
//}
//    -(BOOL) isInternetReachable
//{
//    return [AFNetworkReachabilityManager sharedManager].reachable;
//}
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
