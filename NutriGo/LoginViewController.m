//
//  LoginViewController.m
//  NutriGo
//
//  Created by Kyle Myers on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginSignUpViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"

@import SVProgressHUD;

@interface LoginViewController ()

@property (nonatomic, retain) UILabel *login;
@property (nonatomic, retain) UITextField *user;
@property (nonatomic, retain) UITextField *pass;
@property (nonatomic, retain) UILabel *home;
@property (nonatomic, retain) UILabel *createAccount;


@end

@implementation LoginViewController

@synthesize login, user, pass, home, createAccount;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:145.0/255.0 green:255.0/255.0 blue:170.0/255.0 alpha:1]];
    [self layout];
}

- (void) layout{
    
    if(login == nil){
        CGFloat width = self.view.frame.size.width / 2;
        CGFloat height = self.view.frame.size.height / 12;
        CGFloat offset = self.view.frame.size.height / 8;
        CGFloat xStart = self.view.frame.size.width / 2 - width / 2;
        CGFloat yStart = self.view.frame.size.height / 2 - 2 * height - offset;
    
        login = [[UILabel alloc] init];
        [login setFrame:CGRectMake(xStart, yStart, width, height)];
        [login setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:18]];
        [login setText:@"Please Login"];
        [login setTextAlignment:NSTextAlignmentCenter];
        [login setBackgroundColor:[UIColor colorWithRed:109.0/255.0 green:191.0/255.0 blue:128.0/255.0 alpha:1]];
        [login setTextColor:[UIColor whiteColor]];
        [self.view addSubview:login];
    
        yStart += height + offset/2;
        
        user = [[UITextField alloc] init];
        user.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [user setFrame: CGRectMake(xStart, yStart, width, height)];
        [user setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [user setPlaceholder:(@"Username")];
        [user setBackgroundColor:[UIColor colorWithRed: 155.0/255.0 green:255.0/255.0 blue:170.0/255.0 alpha:0.7]];
        [user setTextColor:[UIColor purpleColor]];
        [self.view addSubview:user];
        
        yStart += height + offset/2;
        
        pass = [[UITextField alloc] init];
        [pass setFrame: CGRectMake(xStart, yStart, width, height)];
        [pass setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [pass setPlaceholder:(@"Password")];
        [pass setSecureTextEntry:TRUE];
        [pass setBackgroundColor:[UIColor colorWithRed: 155.0/255.0 green:255.0/255.0 blue:170.0/255.0 alpha:0.7]];
        [pass setTextColor:[UIColor purpleColor]];
        [self.view addSubview:pass];
        
        yStart += height + offset/2;
        
        home = [[UILabel alloc] init];
        [home setFrame:CGRectMake(xStart, yStart, width, height/2)];
        [home setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
        [home setText:@"LOGIN"];
        [home setTextAlignment:NSTextAlignmentCenter];
        [home setBackgroundColor:[UIColor colorWithRed:109.0/255.0 green:191.0/255.0 blue:128.0/255.0 alpha:1]];
        [home setTextColor:[UIColor whiteColor]];
        [home setUserInteractionEnabled:YES];
        [home addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToHome)]];
        [self.view addSubview:home];
        
        yStart += height/1.5;

        createAccount = [[UILabel alloc] init];
        [createAccount setFrame:CGRectMake(xStart, yStart, width, height/2)];
        [createAccount setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:12]];
        [createAccount setText:@"Don't Have an Account?"];
        [createAccount setTextAlignment:NSTextAlignmentCenter];
        [createAccount setBackgroundColor:[UIColor colorWithRed:109.0/255.0 green:191.0/255.0 blue:128.0/255.0 alpha:1]];
        [createAccount setTextColor:[UIColor whiteColor]];
        [createAccount setUserInteractionEnabled:YES];
        [createAccount addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToSignUp)]];
        [self.view addSubview:createAccount];
        
    
    }
        
       
    
}

- (void) goToHome
{
    [SVProgressHUD show];
    NSInteger *anInt = 0;
    NSString *post = [NSString stringWithFormat:@"username=%@&email=%@&password=%@", [user text], [user text], [pass text]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/login/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
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
                [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"key"] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];  
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

- (void) goToSignUp
{
    SignUpViewController *vc = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
