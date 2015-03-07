//
//  AchievementDefinition.h
//  Scouting
//
//  Created by Doug Croft on 3/7/15.
//  Copyright (c) 2015 Doug Croft. All rights reserved.
//

#import <Parse/Parse.h>

@interface AchievementDefinition : PFObject <PFSubclassing>

#pragma mark - Parse Registration
+ (NSString *) parseClassName;

extern NSString * const PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION;
extern NSString * const PARSE_CLASS_PARAM_ACHIEVEMENT_DEFINITION_TITLE;

#pragma mark - Properties
@property (strong, nonatomic) NSString *title;

@end
