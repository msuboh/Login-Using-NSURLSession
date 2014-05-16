//
//  MHSViewController.m
//  Login
//
//  Created by Maher Suboh on 5/10/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

#import "MHSViewController.h"
#include <CommonCrypto/CommonDigest.h>
#define kSalt @"adlfu3489tyh2jnkLIUGI&%EV(&0982cbgrykxjnk8855"

@interface MHSViewController ()
{
    CGPoint svos;
}

@property (strong, nonatomic)  NSString *userRecordID;

@end

/*
 
 Tasks are created in two Methods:
 1. System provided delegate method, you must provide a completion handler block that returns data to your app when a transfer finishes successfully or with an error.
 2. Custom delegate objects, the task objects call those delegates methods with data as it is received from the server.
 
    Data tasks exchange data using NSData.
    Note: NSURLSessionDataTask is not supported in Background Sessions.
 
 In this App, I will demonstrate how to send HTTP GET/POST requests using NSURLSessionDataTask.
 You need to follow the below steps for NSURLSession.
 a) Create Session Configuration
 b) Create a NSURLSession Object.
 c) Create a NSURLSession Task (Data, Download or Upload) (Download or Upload NOT Used Here, another App in my GITHub will demonstrate it)
 d) If you want to use system delegate methods, you need to implement them in your class. (NOT Used Here, another App in my GITHub will demonstrate it)
 e) Start the task by calling [resume] method.
 
*/


// Here in this App I am using the Second Method //
//
//
// In This App I am using two differnt ways to demonstrate the above Secound Method:
//
//    a.    - (void) updateWithCustomNSURLSession:(BOOL)loginOK withLoginCommand:(NSString *)loginCommand
//    b.    - (void) loginWithCustomNSURLSessionDelegate:(BOOL)loginOK withLoginCommand:(NSString *)loginCommand
//
// so as not to get confused, thinking it is a different way.


/*
    With the new NSURLSession, I was confused to get my hand on the right way to start, and didn't know which is which and for what to use
     and the credit goes to:
     1. Marin Todorov
     2. Ravishanker Kusuma
 
 
    This Implementation of this App and the following Apps related to NSURLSession, is inspired by the topic from the followin site:
    http://hayageek.com/ios-nsurlsession-example/    you can read more about it, it will keep you in track with NSURLSession or will give you a starter poit to understand the rest documentation of NSURLSession.
 
    and:
    http://www.raywenderlich.com/13511/how-to-create-an-app-like-instagram-with-a-web-service-backend-part-12  for great ideas.
 

 
*/


/*
 
    - The current Project include php and sql command files, that you can extract and take out from the project and build you localhost server and used it.
    You can use them as you wish for other needs!
 
    - The Current Project demonstrate other programming techniques, that you can use.
    These techniques is either I created and or took from other programmer sites and used in here.
    There are many different ways to do certain thing in IOS, so there isn't one good way or bad way, it all depend on how to achieve the task in  optimum performance way.
 
 
    - In this Project, I didn't used any OOP techniques, so as to explain my point on how to use the NSURLSession topic clearly with a real working example.
 
 
*/


@implementation MHSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _userID.delegate = self;
    _userPassword.delegate = self;
    _email.delegate = self;
    _firstName.delegate = self;
    _lastName.delegate = self;
    _address.delegate = self;
    _phoneNumber.delegate = self;
    
    _userRecordID = @"0";
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _address.inputAccessoryView = numberToolbar;

    [self frameIt:_welcomeMessage withBorderWinth:2.5f];
    [self frameIt:_updateView withBorderWinth:3.5f];
    [self frameIt:_address withBorderWinth:1.0f];

}


- (void) frameIt:(UIView *)thisControl withBorderWinth:(CGFloat)w
{
    thisControl.layer.cornerRadius = 15.0;
    thisControl.layer.masksToBounds = YES;
    thisControl.layer.borderColor = [UIColor colorWithHue:0.112 saturation:0.598 brightness:0.996 alpha:1.000].CGColor;
    thisControl.layer.borderWidth = w;
    
}

-(void)doneWithNumberPad
{
    [_address resignFirstResponder];
}

//- (void) viewDidAppear: (BOOL) animated
//{
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void)textViewDidBeginEditing:(UITextField *)textView {
    svos = _mainScrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:_mainScrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [_mainScrollView setContentOffset:pt animated:YES];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [_mainScrollView setContentOffset:svos animated:YES];

    [textField resignFirstResponder];
    return YES;
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    svos = _mainScrollView.contentOffset;
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_mainScrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [_mainScrollView setContentOffset:pt animated:YES];
}



- (NSString *) hashThePassword
{
    //salt the password
    NSString* saltedPassword = [NSString stringWithFormat:@"%@%@", _userPassword.text, kSalt];
    //prepare the hashed storage
    NSString* hashedPassword = nil;
    unsigned char hashedPasswordData[CC_SHA1_DIGEST_LENGTH];
    //hash the pass
    NSData *data = [saltedPassword dataUsingEncoding: NSUTF8StringEncoding];
    
    if (CC_SHA1([data bytes], [data length], hashedPasswordData))
    {
        hashedPassword = [[NSString alloc] initWithBytes:hashedPasswordData length:sizeof(hashedPasswordData) encoding:NSASCIIStringEncoding];
        
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Action Status" message:@"Password can't be sent!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
        NSLog(@"Password can't be sent!");
    }
    
    return hashedPassword;
}

- (void) updateWithCustomNSURLSession:(BOOL)loginOK withLoginCommand:(NSString *)loginCommand
{
    
    // I prefer this way, because it is clearer, easier to maintain, and can be used for upload and download images, and/or pdf file.
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSString *hashedPassword = [self hashThePassword];
    
    if (hashedPassword == nil)
    {
        NSLog(@"Password can't be sent");
        return;
    }
    
    
    //1.
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //2.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    // 3.
    NSString *urlString = @"http://localhost/iReporter/";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";

    NSMutableData *dataSend = [[NSMutableData alloc] init];

    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"command\"\r\n\r\n%@", loginCommand] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"username\"\r\n\r\n%@", _userID.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@", hashedPassword] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"firstname\"\r\n\r\n%@", _firstName.text] dataUsingEncoding:NSUTF8StringEncoding]];

    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"lastname\"\r\n\r\n%@", _lastName.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@", dateString);

    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"birthday\"\r\n\r\n%@", dateString] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address\"\r\n\r\n%@", _address.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"sex\"\r\n\r\n%@", @"Male"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"phonenumber\"\r\n\r\n%@", _phoneNumber.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n%@", _email.text] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"authorizationLevel\"\r\n\r\n%@", @"9"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"activeRecord\"\r\n\r\n%@", @"1"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataSend appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [dataSend appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"IdUser\"\r\n\r\n%@", _userRecordID] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    // POST
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:dataSend];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    
     _welcomeMessage.hidden = NO;
    _updateView.hidden = YES;
    
    // 4.
    //Data tasks exchange data using NSData.
    //Note:NSURLSessionDataTask is not supported in Background Sessions.
    NSURLSessionDataTask * dataTask =[session dataTaskWithRequest:request
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           
//                                                         NSLog(@"Response: %@ \n\n\n Error: %@\n\n\n", response, error);
                                                           [self updateServerDatabase:data retrunError:error];
                                                           
                                                       }];

    [dataTask resume];



    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}

-(void) loginWithCustomNSURLSessionDelegate:(BOOL)loginOK withLoginCommand:(NSString *)loginCommand
{
    
    // For simple use as login and logout, and depending in your php server file, you can this methods
    
    
    NSString *hashedPassword = [self hashThePassword];
    
    if (hashedPassword == nil)
    {
        NSLog(@"Password can't be sent");
        return;
    }
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/iReporter/"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params = [[NSString alloc] initWithFormat:@"username=%@&password=%@&command=%@&IdUser=%@",_userID.text, hashedPassword, loginCommand, _userRecordID];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    _welcomeMessage.hidden = NO;
    _updateView.hidden = YES;
    
    
    //Data tasks exchange data using NSData.
    //Note:NSURLSessionDataTask is not supported in Background Sessions.
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                           NSLog(@"Response:%@ %@\n", response, error);

                                                           [self updateServerDatabase:data retrunError:error];
                                                           
                                                           
                                                           
                                                       }];
    [dataTask resume];
    
}

- (void) updateServerDatabase:(NSData *)data retrunError:(NSError *) error
{
    
    if(error == nil)
    {
        //NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
        //NSLog(@"Text Data = %@", text);
        
         NSString *actionMessage = @"";
        
        NSError* jsonError;
        
        NSDictionary* json = [NSJSONSerialization  JSONObjectWithData:data    options:kNilOptions    error:&jsonError];
        NSLog(@"json Data = %@",json);
        
//        NSDictionary* res1 = [[json objectForKey:@"code"] objectAtIndex:0];
//        NSLog(@"json Data = %@",res1);
        
        NSDictionary* res = [[json objectForKey:@"result"] objectAtIndex:0];
        
        
        if ([[res objectForKey:@"status"] isEqualToString:@"register"])
        {
            actionMessage = @"Welcome!\nYou have successfully registered and logged in.";
        }
        else if ([[res objectForKey:@"status"] isEqualToString:@"update"])
        {
            actionMessage = @"Record Updated!\nYou have successfully updated your profile.";
        }
        else if ( [ [json objectForKey:@"logout"] isEqualToString:@"delete"]   )
        {
            actionMessage = @"You have deleted you record successfully and logged out completely from the system!\nTry to login with a different user ID and password, or Resiger again!";
        }
        else if ( [ [json objectForKey:@"logout"] isEqualToString:@"logout"]   )
        {
            actionMessage = @"Your are logged out completely!\nTry to login with a different user ID and password, or Resiger again!";
        }
        else
        {
            actionMessage = @"Welcome Back!\nYou have successfully logged in.\n";
        }

        
        
        
        if ([json objectForKey:@"error"]==nil && [[res objectForKey:@"IdUser"] intValue]>0)
        {
           
            
            
            //show message to the user
            [[[UIAlertView alloc] initWithTitle:@"Action Status" message:[NSString stringWithFormat:@"%@\n %@ - %@\n%@ %@", actionMessage, [res objectForKey:@"IdUser"],
                                                                      [res objectForKey:@"username"],
                                                                      ( ![ [res objectForKey:@"firstname"]  isEqual:[NSNull null] ] ? [res objectForKey:@"firstname"] : @""),
                                                                      ( ![ [res objectForKey:@"lastname"]  isEqual:[NSNull null] ] ? [res objectForKey:@"lastname"] : @"")
                                                                      ]
                                       delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
            
            _welcomeMessage.text = [NSString stringWithFormat:@"%@\n%@ - %@\n%@ %@", actionMessage, [res objectForKey:@"IdUser"],
                                    [res objectForKey:@"username"],
                                    ( ![ [res objectForKey:@"firstname"]  isEqual:[NSNull null] ] ? [res objectForKey:@"firstname"] : @""),
                                    ( ![ [res objectForKey:@"lastname"]  isEqual:[NSNull null] ] ? [res objectForKey:@"lastname"] : @"")
                                    ];
            
            
            _userRecordID = [res objectForKey:@"IdUser"];
            _firstName.text = ( ![ [res objectForKey:@"firstname"]  isEqual:[NSNull null] ] ? [res objectForKey:@"firstname"] : @"");
            _lastName.text = ( ![ [res objectForKey:@"lastname"]  isEqual:[NSNull null] ] ? [res objectForKey:@"lastname"] : @"");
            _address.text = ( ![ [res objectForKey:@"address"]  isEqual:[NSNull null] ] ? [res objectForKey:@"address"] : @"Address:") ;
            _phoneNumber.text = ( ![ [res objectForKey:@"phonenumber"]  isEqual:[NSNull null] ] ? [res objectForKey:@"phonenumber"] : @"");
            _email.text = ( ![ [res objectForKey:@"email"]  isEqual:[NSNull null] ] ? [res objectForKey:@"email"] : @"");
            
            
            _loginButton.hidden = YES;
            _registerButton.hidden = YES;
            _logoutButton.hidden = NO;
            
            _updateView.hidden = NO;
            _mainScrollView.contentSize =  CGSizeMake( _mainScrollView.bounds.size.width, 1200.0f);
            
            
        }
        else if ( [ [json objectForKey:@"logout"] isEqualToString:@"delete"] || [ [json objectForKey:@"logout"] isEqualToString:@"logout"] )
        {
            
            
            
            
            [[[UIAlertView alloc] initWithTitle:@"Action Status"
                                        message:actionMessage
                                       delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles: nil] show];
            _userRecordID = @"0";
            _welcomeMessage.text = actionMessage;
            _userID.text = @"";
            _userPassword.text = @"";
            _userRecordID = @"0";
            _updateView.hidden = YES;
            _mainScrollView.contentSize =  CGSizeMake( _mainScrollView.bounds.size.width, 850.0f);
            
            _loginButton.hidden = NO;
            _registerButton.hidden = NO;
            _logoutButton.hidden = YES;
            
            
        }
        else
        {
            //error
            NSLog(@"error = %@",[json objectForKey:@"error"]);
            _welcomeMessage.text = [NSString stringWithFormat:@"Sign in Failed!\n%@", [json objectForKey:@"error"]];
            
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[json objectForKey:@"error"]
                                       delegate:nil
                              cancelButtonTitle:@"Close"
                              otherButtonTitles: nil] show];
            _userRecordID =  @"0";
            
        }
        
    }

    
 
}



- (IBAction)loginAction:(UIButton *)sender
{

    NSString* command = @"";
    switch (sender.tag)
    {
        case 100:
            command = @"login";
            break;
        case 101:
            command = @"register";
            break;
        case 102:
            command = @"logout";
            break;
        default:
            command = @"login";
            break;
    }
    
    if( ([[_userID text] isEqualToString:@""] || [[_userPassword text] isEqualToString:@""]) && (![command isEqual:@"logout"]) )
    {
        _welcomeMessage.hidden = NO;
        _welcomeMessage.text = @"Sign in Failed!\nPlease Enter UseID and Password";
    }
    else
    {
        [self loginWithCustomNSURLSessionDelegate:true withLoginCommand:command];
    }
    
    [self.view endEditing:YES];
}

- (IBAction)updateRecordAction:(UIButton *)sender
{
    [self updateWithCustomNSURLSession:true withLoginCommand:@"update"];

}

- (IBAction)deleteRecordAction:(id)sender
{
    
    
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Deletion Configuration"
                                                     message:@"Are you sure you want delete you record!"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles: nil];
    [alert addButtonWithTitle:@"Delete"];
    [alert show];
    

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"Button Index =%ld",(long)buttonIndex);
    
    if (buttonIndex == 0)
    {
        NSLog(@"You have clicked Cancel");
    }
    else if(buttonIndex == 1)
    {
        _welcomeMessage.hidden = NO;
        _welcomeMessage.text = @"";
        if([ _userRecordID isEqualToString:@"0"]  )
        {
            _welcomeMessage.text = @"Deletion Failed!\nUser Record Id does not Exist!";
        }
        else
        {
            [self loginWithCustomNSURLSessionDelegate:true withLoginCommand:@"delete"];
        }

        NSLog(@"You have clicked Delete ...");
    }
}



@end
