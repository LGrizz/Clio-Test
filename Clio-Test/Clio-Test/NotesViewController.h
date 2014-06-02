//
//  NotesViewController.h
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import <UIKit/UIKit.h>
#import "Matter.h"

@interface NotesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Matter *matter;

@end
