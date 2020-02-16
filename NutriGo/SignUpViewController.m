//
//  SignUpViewController.m
//  NutriGo
//
//  Created by Sam Cattani on 2020-02-12.
//  Copyright © 2020 oweek.communications.mcgilleus.ca. All rights reserved.
//

#import "SignUpViewController.h"

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
        NSArray* jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (!jsonResult) {
            NSLog(@"Error parsing JSON: %@", jsonError);
        } else {
            for(NSDictionary *item in jsonResult) {
                NSLog(@"Item: %@", item);
            }
        }
        
    }];
    [task resume];
}

@end
