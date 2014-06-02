//
//  NotesViewController.m
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import "NotesViewController.h"
#import "Note.h"

@interface NotesViewController ()

@end

@implementation NotesViewController{
    NSMutableArray *notes;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [notes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = ((Note *)[notes objectAtIndex:indexPath.row]).subject;
    
    return cell;
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
    
    self.title = self.matter.name;
    UIBarButtonItem *createNoteButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(createNote)];
    self.navigationItem.rightBarButtonItem = createNoteButton;
    
    notes = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    NSString *authHeader = @"Bearer Xzd7LAtiZZ6HBBjx0DVRqalqN8yjvXgzY5qaD15a";
    
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [manager GET:[NSString stringWithFormat:@"https://app.goclio.com/api/v2/notes?regarding_type=Matter&regarding_id=%i", self.matter.uid] parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject){
             NSArray *notesJSON = [responseObject objectForKey:@"notes"];
             for(NSDictionary *noteJSON in notesJSON){
                 Note *note = [[Note alloc] initWithJSON:noteJSON];
                 [notes addObject:note];
             }
             [self.tableView reloadData];
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
         }];
}

-(void)createNote{
    NSLog(@"%@", @"Create Note");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
