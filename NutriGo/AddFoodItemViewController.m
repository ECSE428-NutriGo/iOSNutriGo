//
//  AddFoodItemViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "AddFoodItemViewController.h"
#import "NewFoodItemViewController.h"
@import SVProgressHUD;

@interface AddFoodItemViewController ()

@property (nonatomic, retain) UITextField *search;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *addItem;
@property (nonatomic) NSDictionary *result;

@end

@implementation AddFoodItemViewController

@synthesize search, scrollView, addItem, result, ids, foodItemTitles;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:243.0/255.0 green:129.0/255.0 blue:147.0/255.0 alpha:1]];
    
    if (self.ids == nil)
    {
        self.ids = [NSMutableArray array];
    }
    
    if (self.foodItemTitles == nil)
    {
        self.foodItemTitles = [NSMutableArray array];
    }
    
    [self layout];
}

- (void) viewDidAppear:(BOOL)animated
{
    [SVProgressHUD show];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/nutri/fooditem/"]];
    [request setHTTPMethod:@"GET"];
    
    [request addValue:@"Token 3d505b29e14e580add1226ee474022210d9a9dd9" forHTTPHeaderField:@"Authorization"];
    
    
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
                [self refreshItems];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
        
    }];
    [task resume];
    [super viewDidAppear:animated];
}

- (void) layout
{
    CGFloat yStart = self.view.frame.size.height / 10;
    CGFloat height = self.view.frame.size.height / 8;
    CGFloat width = 4 * self.view.frame.size.width / 5;
    
    search = [[UITextField alloc] init];
    [search setFrame:CGRectMake(self.view.frame.size.width / 2 - width / 2, yStart, width, height / 2)];
    [self setTextFieldBorder:search];
    [self.view addSubview:search];
    
    yStart += height / 2;
    CGFloat scrollHeight = 5.4 * height;
    CGFloat xStart = self.view.frame.size.width / 10;
    CGFloat offset = self.view.frame.size.height / 30;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(xStart, yStart, width, scrollHeight)];
    [self.view addSubview:scrollView];

    
    addItem = [[UILabel alloc] init];
    [addItem setFrame:CGRectMake(self.view.frame.size.width / 4, 5 * self.view.frame.size.height / 6, self.view.frame.size.width / 2, self.view.frame.size.height / 12)];
    [addItem setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [addItem setText:@"NEW ITEM"];
    [addItem setTextAlignment:NSTextAlignmentCenter];
    [addItem setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:161.0/255.0 blue:172.0/255.0 alpha:1]];
    [addItem setTextColor:[UIColor whiteColor]];
    [addItem setUserInteractionEnabled:YES];
    [addItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewItem)]];
    [self.view addSubview:addItem];
}

- (void) refreshItems
{
    CGFloat height = self.view.frame.size.height / 8;
    CGFloat width = 4 * self.view.frame.size.width / 5;
    CGFloat offset = self.view.frame.size.height / 30;
    CGFloat yStart = 7;
    
    for (int i = 0; i < [[result valueForKey:@"fooditems"] count]; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, yStart, width, height)];
        yStart += offset + height;
        [view setBackgroundColor:[UIColor colorWithRed:178.0/255.0 green:88.0/255.0 blue:103.0/255.0 alpha:1]];
        [scrollView addSubview:view];
        
        UILabel *title = [[UILabel alloc] init];
        NSString *mealName = [[[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"name"] uppercaseString];
        [title setTextColor:[UIColor whiteColor]];
        [title setText:mealName];
        [title setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:20]];
        [title setFrame:CGRectMake(10, 5, view.frame.size.width - 10, view.frame.size.height / 2)];
        [view addSubview:title];
        
        UILabel *nutritionInfo = [[UILabel alloc] init];
        NSString *protein = [[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"protein"];
        NSString *fat = [[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"fat"];
        NSString *carb = [[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"carb"];
        NSString *display = [NSString stringWithFormat:@"PROTEIN: %@ G, FAT: %@ G, CARBS: %@ G", protein, fat,carb];
        [nutritionInfo setTextColor:[UIColor whiteColor]];
        [nutritionInfo setText:display];
        [nutritionInfo setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:16]];
        [nutritionInfo setNumberOfLines:2];
        [nutritionInfo setFrame:CGRectMake(10, view.frame.size.height / 2 - 10, view.frame.size.width - 10, view.frame.size.height / 2)];
        [view addSubview:nutritionInfo];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addFood:)];
        [tap setName:[[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"id"]];
        [view addGestureRecognizer:tap];
    }
    
    
    [scrollView setContentSize:CGSizeMake(width, yStart)];
}

- (IBAction) addFood: (UITapGestureRecognizer *) sender
{
    for (int i = 0; i < [[result valueForKey:@"fooditems"] count]; i++)
    {
        if ([[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"id"] == [sender name])
        {
            [ids addObject:[[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"id"]];
            [foodItemTitles addObject:[[[[result valueForKey:@"fooditems"] objectAtIndex:i] valueForKey:@"name"] uppercaseString]];
            break;
        }
    }
    
    NewMealViewController *vc = [[NewMealViewController alloc] init];
    vc.ids = self.ids;
    vc.foodItemTitles = self.foodItemTitles;
    [self.navigationController pushViewController:vc animated:YES];
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

- (void) addNewItem
{
    NewFoodItemViewController *vc = [[NewFoodItemViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
