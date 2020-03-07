//
//  SettingsViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-03-04.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "SettingsViewController.h"
#import "ProfileViewController.h"
#import "HomeViewController.h"
#import "MealViewController.h"
#import "EditProfileAttriutesViewController.h"
#import "ChangePasswordViewController.h"
@import SVProgressHUD;

@interface SettingsViewController ()

@property (nonatomic, retain) UIImage *graph;
@property (nonatomic, retain) UIImageView *graphImage;
@property (nonatomic, retain) UIImage *meal;
@property (nonatomic, retain) UIImageView *mealView;
@property (nonatomic, retain) UIImage *profile;
@property (nonatomic, retain) UIImageView *profileView;
@property (nonatomic, retain) UIImage *settings;
@property (nonatomic, retain) UIImageView *settingsView;
@property (nonatomic, retain) UILabel *editInfo;
@property (nonatomic, retain) UILabel *changePass;

@end

@implementation SettingsViewController

@synthesize graph, graphImage, meal, mealView, profile, profileView, settings, settingsView, editInfo, changePass;

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self layout];
    [self.view setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:199.0/255.0 blue:255.0/255.0 alpha:1]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layout];
}

- (void) layout
{
    if (graph == nil)
    {
        
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 5;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        CGFloat spacing = self.view.frame.size.height / 50;
        
        graph = [UIImage imageNamed:@"graph"];
        graphImage = [[UIImageView alloc] initWithImage:graph];
        [graphImage setFrame:CGRectMake(offset, yStart, size, size)];
        [graphImage setUserInteractionEnabled:YES];
        [graphImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColour)]];
        [self.view addSubview:graphImage];
        
        meal = [UIImage imageNamed:@"meal"];
        mealView = [[UIImageView alloc] initWithImage:meal];
        [mealView setFrame:CGRectMake(offset * 2 + size, yStart, size, size)];
        [mealView setUserInteractionEnabled:YES];
        [mealView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMeal)]];
        [self.view addSubview:mealView];
        
        profile = [UIImage imageNamed:@"profile"];
        profileView = [[UIImageView alloc] initWithImage:profile];
        [profileView setFrame:CGRectMake(offset * 3 + 2 * size, yStart, size, size)];
        [profileView setUserInteractionEnabled:YES];
        [profileView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectProfile)]];
        [self.view addSubview:profileView];
        
        settings = [UIImage imageNamed:@"settings"];
        settingsView = [[UIImageView alloc] initWithImage:[self inverseColor:settings]];
        [settingsView setFrame:CGRectMake(offset * 4 + 3 * size, yStart, size, size)];
        [settingsView setUserInteractionEnabled:YES];
       // [settingsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSettings)]];
        [self.view addSubview:settingsView];
        
        CGFloat width = 2 * self.view.frame.size.width / 3;
        CGFloat xStart = self.view.frame.size.width / 6;
        CGFloat height = self.view.frame.size.height / 10;
        yStart = self.view.frame.size.height / 2 - offset / 2 - height;
        
        editInfo = [[UILabel alloc] init];
        [editInfo setFrame:CGRectMake(xStart, yStart, width, height)];
        [editInfo setBackgroundColor:[UIColor colorWithRed:132.0/255.0 green:106.0/255.0 blue:173.0/255.0 alpha:1]];
        [editInfo setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
        [editInfo setText:@"EDIT USER INFO"];
        [editInfo setTextColor:[UIColor whiteColor]];
        [editInfo setTextAlignment:NSTextAlignmentCenter];
        [editInfo setUserInteractionEnabled:YES];
        [editInfo addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToEditInfo)]];
        [self.view addSubview:editInfo];
        
        yStart += height + offset;
        
        changePass = [[UILabel alloc] init];
        [changePass setFrame:CGRectMake(xStart, yStart, width, height)];
        [changePass setBackgroundColor:[UIColor colorWithRed:132.0/255.0 green:106.0/255.0 blue:173.0/255.0 alpha:1]];
        [changePass setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
        [changePass setText:@"CHANGE PASSWORD"];
        [changePass setTextColor:[UIColor whiteColor]];
        [changePass setTextAlignment:NSTextAlignmentCenter];
        [changePass setUserInteractionEnabled:YES];
        [changePass addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToChangePass)]];
        [self.view addSubview:changePass];
        
    }
}

- (void) selectMeal
{
    [mealView setImage:[self inverseColor:mealView.image]];
    [settingsView setImage:[UIImage imageNamed:@"settings"]];
    MealViewController *vc = [[MealViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectProfile
{
    [profileView setImage:[self inverseColor:profileView.image]];
    [settingsView setImage:[UIImage imageNamed:@"settings"]];
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void) selectGraph
{
    [mealView setImage:[UIImage imageNamed:@"meal"]];
    [settingsView setImage:[UIImage imageNamed:@"settings"]];
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIImage *)inverseColor:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
}

- (void) goToEditInfo
{
    EditProfileAttriutesViewController *vc = [[EditProfileAttriutesViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) goToChangePass
{
    ChangePasswordViewController *vc = [[ChangePasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
