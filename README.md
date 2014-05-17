Login-Using-NSURLSession
========================

Login Project for IOS.

This App Shows how to Use a custom Delegate for NSURLSession.

Showing how to Login, Register, Update, Delete, and Logout.

The current Project include php and sql command files, that you can extract and take out from the project and build you localhost server and used it. You can use them as you wish for other needs!

The Current Project demonstrate other programming techniques, that you can use. These techniques is either I created and or took from other programmer sites and used in here.

Tasks are created in two Methods:

System provided delegate method, you must provide a completion handler block that returns data to your app when a transfer finishes successfully or with an error.
Custom delegate objects, the task objects call those delegates methods with data as it is received from the server.

Data tasks exchange data using NSData. Note: NSURLSessionDataTask is not supported in Background Sessions.

In this App, I will demonstrate how to send HTTP GET/POST requests using NSURLSessionDataTask.

You need to follow the below steps for NSURLSession.

a) Create Session Configuration

b) Create a NSURLSession Object.

c) Create a NSURLSession Task (Data, Download or Upload) (Download or Upload NOT Used Here, another App in my GITHub will demonstrate it)

d) If you want to use system delegate methods, you need to implement them in your class. (NOT Used Here, another App in my GITHub will demonstrate it)

e) Start the task by calling [resume] method.

Here in this App I am using the Second Method

In This App I am using two differnt ways to demonstrate the above Secound Method:

a. - (void) updateWithCustomNSURLSession:(BOOL)loginOK withLoginCommand:(NSString *)loginCommand

b. - (void) loginWithCustomNSURLSessionDelegate:(BOOL)loginOK withLoginCommand:(NSString *)loginCommand

You can use either one to achieve any or all the operations (Login, Register, ..., etc.).
