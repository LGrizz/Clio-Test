//
//  CreateNoteViewController.h
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import <UIKit/UIKit.h>
#import "Matter.h"
#import "Note.h"

@class CreateNoteViewController;

@protocol CreateNoteViewControllerDelegate <NSObject>

-(void)createNote:(CreateNoteViewController *)controller didCreateItem:(Note *)note;

@end

@interface CreateNoteViewController : UIViewController

@property (nonatomic, strong) Matter *matter;
@property (nonatomic, weak) id <CreateNoteViewControllerDelegate> delegate;

-(IBAction)createNote:(id)sender;

@end
