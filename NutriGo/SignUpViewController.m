//
//  SignUpViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "SignUpViewController.h"
#import "HomeViewController.h"
@import SVProgressHUD;

@interface SignUpViewController ()

@property (nonatomic, retain) UIImageView *logoView;
@property (nonatomic, retain) UITextField *emailField;
@property (nonatomic, retain) UIView *emailView;
@property (nonatomic, retain) UITextField *pwdField;
@property (nonatomic, retain) UIView *pwdView;
@property (nonatomic, retain) UILabel *signIn;

@end

@implementation SignUpViewController

@synthesize logoView, emailField, emailView, pwdField, pwdView, signIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layout];
    [self.view setBackgroundColor:[UIColor colorWithRed:121.0/255.0 green:193.0/255.0 blue:200.0/255.0 alpha:1]];
}

- (void) layout {
    
    CGFloat width = self.view.frame.size.width / 2;
    CGFloat height = self.view.frame.size.height / 12;
    CGFloat offset = self.view.frame.size.height / 6;
    CGFloat xStart = self.view.frame.size.width / 2 - width / 2;
    CGFloat yStart = self.view.frame.size.height / 2 - 2 * height - offset;
    
    logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [logoView setFrame:CGRectMake(xStart, yStart, width, 2 * height)];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:logoView];
    
    width = self.view.frame.size.width / 1.3;
    xStart = self.view.frame.size.width / 2 - width / 2;
    offset = self.view.frame.size.height / 10;
    yStart = self.view.frame.size.height / 2 - offset;
    height = self.view.frame.size.height / 20;
    
    
    CGRect emailRect = CGRectMake(xStart, yStart, width, height);
    emailField = [[UITextField alloc] initWithFrame:emailRect];
    emailField.placeholder = @"email";
    emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    CALayer *bottomLine = [CALayer layer];
    bottomLine.frame = CGRectMake(0.0f, emailRect.size.height, width, 1.0f);
    bottomLine.backgroundColor = [UIColor whiteColor].CGColor;
    [emailField setBorderStyle:UITextBorderStyleNone];
    [emailField.layer addSublayer:bottomLine];
    
    [self.view addSubview:emailField];
    
    yStart = self.view.frame.size.height / 2;

    CGRect pwdRect = CGRectMake(xStart, yStart, width, height);
    pwdField = [[UITextField alloc] initWithFrame:pwdRect];
    pwdField.placeholder = @"password";
    [pwdField setSecureTextEntry:TRUE];
    pwdField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    bottomLine = [CALayer layer];
    bottomLine.frame = CGRectMake(0.0f, pwdRect.size.height, width, 1.0f);
    bottomLine.backgroundColor = [UIColor whiteColor].CGColor;
    [pwdField setBorderStyle:UITextBorderStyleNone];
    [pwdField.layer addSublayer:bottomLine];
    
    [self.view addSubview:pwdField];
    
    yStart += offset*2;
    
    signIn = [[UILabel alloc] init];
    [signIn setFrame:CGRectMake(xStart, yStart, width, height)];
    [signIn setFont:[UIFont fontWithName:@"SourceCodePro-Black" size:24]];
    [signIn setText:@"SIGN UP"];
    [signIn setTextAlignment:NSTextAlignmentCenter];
    [signIn setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:47.0/255.0 blue:51.0/255.0 alpha:1]];
    [signIn setTextColor:[UIColor whiteColor]];
    [signIn setUserInteractionEnabled:YES];
    [signIn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signUp)]];
    [self.view addSubview:signIn];
}

- (void) signUp {
    
    if (emailField.text.length == 0 || pwdField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Field"
                                                            message:@"Please fill out all fields before registering."
                                                            delegate:self
                                                            cancelButtonTitle:@"Dismiss"
                                                            otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [SVProgressHUD show];
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password1=%@&password2=%@&email=%@", emailField.text, pwdField.text, pwdField.text, emailField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://nutrigo-staging.herokuapp.com/rest-auth/registration/"]];
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
                if (dict[@"email"] != nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Error"
                                                                        message:dict[@"email"][0]
                                                                        delegate:self
                                                                        cancelButtonTitle:@"Dismiss"
                                                                        otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                else if (dict[@"password1"] != nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weak Password"
                                                                        message:dict[@"password1"][0]
                                                                        delegate:self
                                                                        cancelButtonTitle:@"Dismiss"
                                                                        otherButtonTitles:nil];
                    [alert show];
                    return;
                }
                else if (dict[@"key"] != nil) {
                    [[NSUserDefaults standardUserDefaults]setObject:[dict objectForKey:@"key"] forKey:@"token"];
                    [[NSUserDefaults standardUserDefaults] synchronize]; 
                    [self goToHome];
                }
            }
            else{
                NSLog(@"Not in main thread--completion handler");
            }
        });
    }];
    [task resume];
}

- (void) goToHome {
    HomeViewController *vc = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
