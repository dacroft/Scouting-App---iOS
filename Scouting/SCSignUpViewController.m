//
//  SCSignUpViewController.m
//  Scouting
//
//  Created by Doug Croft on 2/24/15.
//  Copyright (c) 2015 Doug Croft. All rights reserved.
//

#import "SCSignUpViewController.h"

@interface SCSignUpViewController ()

@end

@implementation SCSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Customize the look and feel
    UIImage *logoImage = [UIImage imageNamed:@"Logo.png"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    //logoImageView.contentMode = UIViewContentModeCenter;
    //if ((logoImageView.bounds.size.width > logoImage.size.width) && (logoImageView.bounds.size.height > logoImage.size.height))  {
        logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    //}
    [self.signUpView setLogo:logoImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
