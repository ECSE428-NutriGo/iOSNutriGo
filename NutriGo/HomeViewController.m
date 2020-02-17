//
//  HomeViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-03.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "HomeViewController.h"
#import "MealViewController.h"
#import "ProfileViewController.h"
@import SVProgressHUD;

@interface HomeViewController ()

@property (nonatomic, retain) UIImage *graph;
@property (nonatomic, retain) UIImageView *graphImage;
@property (nonatomic, retain) UIImage *meal;
@property (nonatomic, retain) UIImageView *mealView;
@property (nonatomic, retain) UIImage *profile;
@property (nonatomic, retain) UIImageView *profileView;
@property (nonatomic, retain) UIImage *settings;
@property (nonatomic, retain) UIImageView *settingsView;
@property (nonatomic, retain) UIView *calories;
@property (nonatomic, retain) UIView *fat;
@property (nonatomic, retain) UIView *carbs;
@property (nonatomic, retain) UIView *protein;
@property (nonatomic, retain) UILabel *today;
@property (nonatomic, retain) NSArray *macros;
@property (nonatomic) NSDictionary *result;
@property (nonatomic) NSDictionary *goals;

@end

@implementation HomeViewController

@synthesize graph, graphImage, meal, mealView, profile, profileView, settings, settingsView, calories, fat, carbs, protein, today, macros, result, goals;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    [self.view setBackgroundColor:[UIColor colorWithRed:121.0/255.0 green:193.0/255.0 blue:200.0/255.0 alpha:1]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self resetFrames];
    [super viewWillAppear:animated];
}

- (void) layout
{
    if (graph == nil)
    {
        
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 5;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        
        graph = [UIImage imageNamed:@"graph"];
        graphImage = [[UIImageView alloc] initWithImage:[self inverseColor:graph]];
        [graphImage setFrame:CGRectMake(offset, yStart, size, size)];
        [graphImage setUserInteractionEnabled:YES];
        //[graphImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeColour)]];
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
        settingsView = [[UIImageView alloc] initWithImage:settings];
        [settingsView setFrame:CGRectMake(offset * 4 + 3 * size, yStart, size, size)];
        [settingsView setUserInteractionEnabled:YES];
        [settingsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSettings)]];
        [self.view addSubview:settingsView];
        
        yStart = self.view.frame.size.height / 12;
        
        today = [[UILabel alloc] init];
        [today setFrame:CGRectMake(0, yStart, self.view.frame.size.width, self.view.frame.size.height / 7)];
        [today setText:@"TODAY"];
        [today setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:self.view.frame.size.height / 12]];
        [today setTextColor:[UIColor whiteColor]];
        [today setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:today];
        
        
        CGFloat xStart = self.view.frame.size.width / 10;
        CGFloat section = (2 * self.view.frame.size.height / 3) / 9;
        CGFloat end = xStart + 4 * self.view.frame.size.width / 5;
        CGFloat width = 4 * self.view.frame.size.width / 5;
        yStart = self.view.frame.size.height / 4;
        
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        [line setFrame:CGRectMake(xStart + width - 40, yStart, 40, section)];
        [self.view addSubview:line];
        
        calories = [[UIView alloc] initWithFrame:CGRectMake(xStart, yStart, 0, section)];
        [calories setBackgroundColor:[UIColor colorWithRed:0/255.0 green:47.0/255.0 blue:51.0/255.0 alpha:1]];
        [self.view addSubview:calories];
        
        yStart += 2 * section;
        
        UIImageView *line2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        [line2 setFrame:CGRectMake(xStart + width - 40, yStart, 40, section)];
        [self.view addSubview:line2];
        
        fat = [[UIView alloc] initWithFrame:CGRectMake(xStart, yStart, 0, section)];
        [fat setBackgroundColor:[UIColor colorWithRed:0/255.0 green:87.0/255.0 blue:95.0/255.0 alpha:1]];
        [self.view addSubview:fat];
        
        yStart += 2 * section;
        
        UIImageView *line3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        [line3 setFrame:CGRectMake(xStart + width - 40, yStart, 40, section)];
        [self.view addSubview:line3];
        
        carbs = [[UIView alloc] initWithFrame:CGRectMake(xStart, yStart, 0, section)];
        [carbs setBackgroundColor:[UIColor colorWithRed:0/255.0 green:115.0/255.0 blue:126.0/255.0 alpha:1]];
        [self.view addSubview:carbs];
        
        yStart += 2 * section;
        
        UIImageView *line4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
        [line4 setFrame:CGRectMake(xStart + width - 40, yStart, 40, section)];
        [self.view addSubview:line4];
        
        protein = [[UIView alloc] initWithFrame:CGRectMake(xStart, yStart, 0, section)];
        [protein setBackgroundColor:[UIColor colorWithRed:0/255.0 green:154.0/255.0 blue:170.0/255.0 alpha:1]];
        [self.view addSubview:protein];
    }
}

- (void) resetFrames
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/nutri/daily/"]];
    [request setHTTPMethod:@"GET"];
    
    NSString *string = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    [request addValue:string forHTTPHeaderField:@"Authorization"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *jsonError = nil;
        NSArray* jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        macros = jsonResult;
        
        if (jsonError) {
            NSLog(@"error is %@", [jsonError localizedDescription]);
            return;
        }
        
        else
        {
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
            
            [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/user/"]];
            [request setHTTPMethod:@"GET"];
            
            NSString *string = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
            
            [request addValue:string forHTTPHeaderField:@"Authorization"];
            
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSError *jsonError = nil;
                NSArray* jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                goals = jsonResult;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[NSThread currentThread] isMainThread]){
                        [SVProgressHUD dismiss];
                        [self setBars];
                    }
                    else{
                        NSLog(@"Not in main thread--completion handler");
                    }
                });
            }];
            [task resume];
        }
        
    }];
    [task resume];
    
}

- (void) selectMeal
{
    [mealView setImage:[self inverseColor:mealView.image]];
    [graphImage setImage:[UIImage imageNamed:@"graph"]];
    MealViewController *vc = [[MealViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectProfile
{
    [profileView setImage:[self inverseColor:profileView.image]];
    [graphImage setImage:[UIImage imageNamed:@"graph"]];
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectSettings
{
    [settingsView setImage:[self inverseColor:settingsView.image]];
    [graphImage setImage:[UIImage imageNamed:@"graph"]];
}

- (UIImage *)inverseColor:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
}

- (void) setBars
{
    CGFloat xStart = self.view.frame.size.width / 10;
    CGFloat section = (2 * self.view.frame.size.height / 3) / 9;
    CGFloat end = xStart + 4 * self.view.frame.size.width / 5;
    CGFloat width = 4 * self.view.frame.size.width / 5;
    CGFloat yStart = self.view.frame.size.height / 4;
    
    CGFloat carbsVal = ((CGFloat) [[self.macros valueForKey:@"carb"] integerValue]);
    CGFloat fatVal = (CGFloat) [[self.macros valueForKey:@"fat"] integerValue];
    CGFloat proteinVal = (CGFloat) [[self.macros valueForKey:@"protein"] integerValue];
    CGFloat calVal = (4 * carbsVal + 4 * proteinVal + 9 * fatVal) / 2000.0;
    
    [calories setFrame:CGRectMake(xStart, yStart, calVal * width, section)];
    
    yStart += 2 * section;
    
    if ([[goals valueForKey:@"fat_target"] integerValue] == 0)
    {
        [fat setFrame:CGRectMake(xStart, yStart, width, section)];
    }
    else
    {
        [fat setFrame:CGRectMake(xStart, yStart, (fatVal / ((CGFloat) [[goals valueForKey:@"fat_target"] integerValue])) * width, section)];
    }
    
    yStart += 2 * section;
    
    if ([[goals valueForKey:@"carb_target"] integerValue] == 0)
    {
        [carbs setFrame:CGRectMake(xStart, yStart, width, section)];
    }
    else
    {
        [carbs setFrame:CGRectMake(xStart, yStart, (carbsVal / ((CGFloat) [[goals valueForKey:@"carb_target"] integerValue])) * width, section)];
    }
    
    yStart += 2 * section;
    
    if ([[goals valueForKey:@"protein_target"] integerValue] == 0)
    {
        [protein setFrame:CGRectMake(xStart, yStart, width, section)];
    }
    else
    {
        [protein setFrame:CGRectMake(xStart, yStart, (proteinVal / ((CGFloat) [[goals valueForKey:@"protein_target"] integerValue])) * width, section)];
    }
}

@end
