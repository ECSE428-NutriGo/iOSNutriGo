//
//  LoginSignUpViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "LoginSignUpViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"

@interface LoginSignUpViewController ()

@property (nonatomic, retain) UILabel *login;
@property (nonatomic, retain) UILabel *signIn;
@property (nonatomic, retain) UIImageView *logoView;
@property (nonatomic, retain) UILabel *titleView;

@end

@implementation LoginSignUpViewController

@synthesize login, signIn, logoView, titleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:121.0/255.0 green:193.0/255.0 blue:200.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout
{
    if (login == nil)
    {
        CGFloat width = self.view.frame.size.width / 2;
        CGFloat height = self.view.frame.size.height / 12;
        CGFloat offset = self.view.frame.size.height / 6;
        CGFloat xStart = self.view.frame.size.width / 2 - width / 2;
        CGFloat yStart = self.view.frame.size.height / 2 - 2 * height - offset;
        
        logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meal"]];
        [logoView setFrame:CGRectMake(xStart, yStart, width, 2 * height)];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:logoView];
        
        yStart += height + 2 * offset;
        
        login = [[UILabel alloc] init];
        [login setFrame:CGRectMake(xStart, yStart, width, height)];
        [login setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [login setText:@"LOGIN"];
        [login setTextAlignment:NSTextAlignmentCenter];
        [login setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:47.0/255.0 blue:51.0/255.0 alpha:1]];
        [login setTextColor:[UIColor whiteColor]];
        [login setUserInteractionEnabled:YES];
        [login addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToLogin)]];
        [self.view addSubview:login];
        
        yStart += offset;
        
        signIn = [[UILabel alloc] init];
        [signIn setFrame:CGRectMake(xStart, yStart, width, height)];
        [signIn setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [signIn setText:@"SIGN UP"];
        [signIn setTextAlignment:NSTextAlignmentCenter];
        [signIn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:47.0/255.0 blue:51.0/255.0 alpha:1]];
        [signIn setTextColor:[UIColor whiteColor]];
        [signIn setUserInteractionEnabled:YES];
        [signIn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSignIn)]];
        [self.view addSubview:signIn];
        
        UILabel *label = [[UILabel alloc] init];
        [label setFrame:CGRectMake(xStart, self.view.frame.size.height/ 3 + offset / 2, width, height)];
        [label setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:15]];
        [label setText:@"DEV-GO TO HOME PAGE"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:47.0/255.0 blue:51.0/255.0 alpha:1]];
        [label setTextColor:[UIColor whiteColor]];
        [label setUserInteractionEnabled:YES];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToHome)]];
        [self.view addSubview:label];
    }
}

- (void) goToLogin
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) goToSignIn
{
    SignUpViewController *vc = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) goToHome
{
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
