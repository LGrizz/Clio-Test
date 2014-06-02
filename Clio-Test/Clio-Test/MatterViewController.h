//
//  MatterViewController.h
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import <UIKit/UIKit.h>

@interface MatterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
