//
//  MealViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "MealViewController.h"
#import "HomeViewController.h"
#import "NewMealViewController.h"
#import "ProfileViewController.h"
@import SVProgressHUD;

@interface MealViewController ()

@property (nonatomic, retain) UIImage *graph;
@property (nonatomic, retain) UIImageView *graphImage;
@property (nonatomic, retain) UIImage *meal;
@property (nonatomic, retain) UIImageView *mealView;
@property (nonatomic, retain) UIImage *profile;
@property (nonatomic, retain) UIImageView *profileView;
@property (nonatomic, retain) UIImage *settings;
@property (nonatomic, retain) UIImageView *settingsView;
@property (nonatomic, retain) UITextField *search;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *addMeal;
@property (nonatomic) NSDictionary *result;

@end

@implementation MealViewController

@synthesize graph, graphImage, meal, mealView, profile, profileView, settings, settingsView, search, scrollView, addMeal, result;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:129.0/255.0 blue:147.0/255.0 alpha:1]];
    [self layoutBottom];
}

- (void) viewDidAppear:(BOOL)animated
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/nutri/meal/"]];
    [request setHTTPMethod:@"GET"];
    
    NSString *string = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    [request addValue:string forHTTPHeaderField:@"Authorization"];
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSError *jsonError = nil;
        NSDictionary* jsonUsers = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        self.result = jsonUsers;
        
        if (jsonError) {
            NSLog(@"error is %@", [jsonError localizedDescription]);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[NSThread currentThread] isMainThread]){
                [SVProgressHUD dismiss];
                [self layout];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
        
    }];
    [task resume];
    [super viewDidAppear:animated];
}

- (void) layoutBottom
{
    [SVProgressHUD show];
    
    CGFloat size = self.view.frame.size.width / 8;
    CGFloat offset = self.view.frame.size.width / 2 / 5;
    CGFloat yStart = 17 * self.view.frame.size.height / 20;
    
    graph = [UIImage imageNamed:@"graph"];
    graphImage = [[UIImageView alloc] initWithImage:graph];
    [graphImage setFrame:CGRectMake(offset, yStart, size, size)];
    [graphImage setUserInteractionEnabled:YES];
    [graphImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectGraph)]];
    [self.view addSubview:graphImage];
    
    meal = [UIImage imageNamed:@"meal"];
    mealView = [[UIImageView alloc] initWithImage:[self inverseColor:meal]];
    [mealView setFrame:CGRectMake(offset * 2 + size, yStart, size, size)];
    [mealView setUserInteractionEnabled:YES];
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
    
    size = self.view.frame.size.width / 8;
    offset = self.view.frame.size.width / 2 / 5;
    yStart = 17 * self.view.frame.size.height / 20;
    
    yStart = self.view.frame.size.height / 10;
    CGFloat height = self.view.frame.size.height / 8;
    CGFloat width = 4 * self.view.frame.size.width / 5;
    
    search = [[UITextField alloc] init];
    [search setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart, width, height / 2)];
    [self setTextFieldBorder:search];
    [self.view addSubview:search];
    
    yStart += height / 2;
    CGFloat scrollHeight = 4.8 * height;
    CGFloat xStart = self.view.frame.size.width / 10;
    offset = self.view.frame.size.height / 30;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(xStart, yStart, width, scrollHeight)];
    [self.view addSubview:scrollView];
    
    addMeal = [[UILabel alloc] init];
    [addMeal setFrame:CGRectMake(self.view.frame.size.width / 4, 3 * self.view.frame.size.height / 4, self.view.frame.size.width / 2, self.view.frame.size.height / 12)];
    [addMeal setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [addMeal setText:@"NEW MEAL"];
    [addMeal setTextAlignment:NSTextAlignmentCenter];
    [addMeal setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
    [addMeal setTextColor:[UIColor whiteColor]];
    [addMeal setUserInteractionEnabled:YES];
    [addMeal addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewMeal)]];
    [self.view addSubview:addMeal];
}

- (void) layout
{
        
        CGFloat size = self.view.frame.size.width / 8;
        CGFloat offset = self.view.frame.size.width / 2 / 8;
        CGFloat yStart = 17 * self.view.frame.size.height / 20;
        
        yStart = self.view.frame.size.height / 10;
        CGFloat height = self.view.frame.size.height / 8;
        CGFloat width = 4 * self.view.frame.size.width / 5;
        
        yStart = 7;
    
    if ([[result valueForKey:@"meals"] count] == 0) {
        UILabel *noMealLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 50)];
        [noMealLabel setText: @"No Meals Exist"];
        [noMealLabel setTextColor:[UIColor whiteColor]];
        [noMealLabel setBackgroundColor:[UIColor clearColor]];
        [noMealLabel setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:25]];
        [scrollView addSubview:noMealLabel];
    }
    
        for (int i = 0; i < [[result valueForKey:@"meals"] count]; i++)
        {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, yStart, width, height)];
            yStart += offset + height;
            [view setBackgroundColor:[UIColor colorWithRed:178.0/255.0 green:88.0/255.0 blue:103.0/255.0 alpha:1]];
            [scrollView addSubview:view];
            
            UILabel *title = [[UILabel alloc] init];
            NSString *mealName = [[[[result valueForKey:@"meals"] objectAtIndex:i] valueForKey:@"name"] uppercaseString];
            [title setTextColor:[UIColor whiteColor]];
            [title setText:mealName];
            [title setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
            [title setFrame:CGRectMake(10, 5, view.frame.size.width - 10, view.frame.size.height / 2)];
            [view addSubview:title];
            
            UILabel *nutritionInfo = [[UILabel alloc] init];
            NSString *protein = [[[result valueForKey:@"meals"] objectAtIndex:i] valueForKey:@"protein"];
            NSString *fat = [[[result valueForKey:@"meals"] objectAtIndex:i] valueForKey:@"fat"];
            NSString *carb = [[[result valueForKey:@"meals"] objectAtIndex:i] valueForKey:@"carb"];
            NSString *display = [NSString stringWithFormat:@"PROTEIN: %@ G, FAT: %@ G, CARBS: %@ G", protein, fat,carb];
            [nutritionInfo setTextColor:[UIColor whiteColor]];
            [nutritionInfo setText:display];
            [nutritionInfo setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:16]];
            [nutritionInfo setNumberOfLines:2];
            [nutritionInfo setFrame:CGRectMake(10, view.frame.size.height / 2 - 10, view.frame.size.width - 10, view.frame.size.height / 2)];
            [view addSubview:nutritionInfo];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eatMeal:)];
            [tap setName:[[[result valueForKey:@"meals"] objectAtIndex:i] valueForKey:@"id"]];
            [view addGestureRecognizer:tap];
        }
        
        
        [scrollView setContentSize:CGSizeMake(width, yStart)];
}

- (UIImage *)inverseColor:(UIImage *)image {
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorInvert"];
    [filter setValue:coreImage forKey:kCIInputImageKey];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    return [UIImage imageWithCIImage:result];
}

- (void) setTextFieldBorder :(UITextField *)textField{
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 4;
    border.borderColor = [UIColor whiteColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
}

- (void) addNewMeal
{
    NewMealViewController *vc = [[NewMealViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectGraph
{
    [mealView setImage:[UIImage imageNamed:@"meal"]];
    [graphImage setImage:[self inverseColor:graphImage.image]];
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectProfile
{
    [profileView setImage:[self inverseColor:profileView.image]];
    [mealView setImage:[UIImage imageNamed:@"meal"]];
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) selectSettings
{
    [settingsView setImage:[self inverseColor:settingsView.image]];
    [mealView setImage:[UIImage imageNamed:@"meal"]];
}

- (IBAction) eatMeal: (UITapGestureRecognizer *) sender
{
    NSString *string = [sender name];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSMutableString *dateString = [[dateFormatter stringFromDate:currentDate] mutableCopy];
    
    NSString *post = [NSString stringWithFormat:@"meal=%d&timestamp=%@", [string intValue], dateString];
       NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

       NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

       NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
       [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/nutri/mealentry/"]];
       [request setHTTPMethod:@"POST"];
       [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
       [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
       [request setHTTPBody:postData];
    
    NSString *string1 = [NSString stringWithFormat:@"Token %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    
    [request addValue:string1 forHTTPHeaderField:@"Authorization"];
       
       NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
       NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
           NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
           NSError *jsonError = nil;
           NSData *dataUTF8 = [responseString dataUsingEncoding:NSUTF8StringEncoding];

           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dataUTF8 options:0 error:&jsonError];

           if (jsonError) {
               NSLog(@"Error parsing JSON: %@", jsonError);
           }
           NSLog(@"%@", dict);
           
           dispatch_sync(dispatch_get_main_queue(), ^{
               if ([[NSThread currentThread] isMainThread]){
                   [SVProgressHUD dismiss];
                   HomeViewController *vc = [[HomeViewController alloc] init];
                   [self.navigationController pushViewController:vc animated:YES];
               }
               else{
                   NSLog(@"Not in main thread--completion handler");
               }
           });
       }];
       [task resume];
    
}

@end
