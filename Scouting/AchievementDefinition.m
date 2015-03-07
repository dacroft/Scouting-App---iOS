//
//  AchievementDefinition.m
//  Scouting
//
//  Created by Doug Croft on 3/7/15.
//  Copyright (c) 2015 Doug Croft. All rights reserved.
//

#import "AchievementDefinition.h"
#import <Parse/PFObject+Subclass.h>



@implementation AchievementDefinition

#pragma mark - Parse Registration
NSString * const PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION = @"AchievementDefinition";
+ (NSString *) parseClassName
{
    return PARSE_CLASS_NAME_ACHIEVEMENT_DEFINITION;
}
+ (void)load
{
    [self registerSubclass];
}

#pragma mark - Properties
NSString * const PARSE_CLASS_PARAM_ACHIEVEMENT_DEFINITION_TITLE = @"title";
@dynamic title;
@end
