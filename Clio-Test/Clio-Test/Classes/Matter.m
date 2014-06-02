//
//  Matters.m
//  Clio-Test
//
//  Created by Kyle Langille on 2014-06-02.
//
//

#import "Matter.h"

@implementation Matter

- (id)initWithJSON:(NSDictionary *)json {
    if ((self = [super init])) {
        self.uid = [[json objectForKey:@"id"] intValue];
        self.name = [json objectForKey:@"display_number"];
    }
    return self;
}

@end
