//
//  CreateNoteViewController.m
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import "CreateNoteViewController.h"
#import "Note.h"

@interface CreateNoteViewController ()

@end

@implementation CreateNoteViewController{
    IBOutlet UITextField *detailTextField;
    IBOutlet UITextField *subjectTextField;
    IBOutlet UIView *errorView;
    IBOutlet UILabel *errorLabel;
}

@synthesize delegate;

-(IBAction)createNote:(id)sender{
    if([subjectTextField.text isEqualToString:@""]){
        [self showError:@"Please provide a subject for the note"];
        return;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    NSString *authHeader = @"Bearer Xzd7LAtiZZ6HBBjx0DVRqalqN8yjvXgzY5qaD15a";
    
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *params = @{@"note": @{@"detail": detailTextField.text, @"subject": subjectTextField.text, @"regarding": @{@"type":@"Matter", @"id": [NSString stringWithFormat:@"%i", self.matter.uid]}}};
    
    [manager POST:@"https://app.goclio.com/api/v2/notes" parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject){
             Note *note = [[Note alloc] initWithJSON:[responseObject objectForKey:@"note"]];
             [self.delegate createNote:self didCreateItem:note];
             
             [self.navigationController popViewControllerAnimated:YES];
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
             
             [self showError:@"Error creating note"];
         }];
}

-(void)showError:(NSString *)error{
    errorLabel.text = error;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         errorView.alpha = 1;
                     }
                     completion:^(BOOL finished){
                         [self performSelector:@selector(hideError) withObject:nil afterDelay:3.0];
                     }];
}

-(void)hideError{
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         errorView.alpha = 0;
                     }
                     completion:^(BOOL finished){}];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Create Note";
    errorView.alpha = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
