//
//  MatterViewController.m
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import "MatterViewController.h"
#import "NotesViewController.h"
#import "Matter.h"

@interface MatterViewController ()

@end

@implementation MatterViewController{
    NSMutableArray *matters;
    
    IBOutlet UIView *errorView;
    IBOutlet UITableView *tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [matters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = ((Matter *)[matters objectAtIndex:indexPath.row]).name;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NotesViewController *notesViewController = [[NotesViewController alloc] initWithNibName:@"NotesViewController" bundle:nil];
    notesViewController.matter = [matters objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:notesViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
    
    self.title = @"Matters";
    errorView.alpha = 0;
    
    matters = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    NSString *authHeader = @"Bearer Xzd7LAtiZZ6HBBjx0DVRqalqN8yjvXgzY5qaD15a";
    
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [manager GET:@"https://app.goclio.com/api/v2/matters" parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject){
             NSArray *mattersJSON = [responseObject objectForKey:@"matters"];
             for(NSDictionary *matterJSON in mattersJSON){
                 Matter *matter = [[Matter alloc] initWithJSON:matterJSON];
                 [matters addObject:matter];
             }
             [tableView reloadData];
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [UIView animateWithDuration:0.5
                                   delay:0.0
                                 options: UIViewAnimationOptionCurveEaseInOut
                              animations:^{
                                  errorView.alpha = 1;
                              }
                              completion:^(BOOL finished){}];
         }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
