//
//  Notes.m
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import "Note.h"

@implementation Note

- (id)initWithJSON:(NSDictionary *)json {
    if ((self = [super init])) {
        self.uid = [[json objectForKey:@"id"] intValue];
        self.subject = [json objectForKey:@"subject"];
        self.detail = [json objectForKey:@"detail"];
    }
    return self;
}

@end
