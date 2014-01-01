//
//  OCAConnection.h
//  Objective-Chain
//
//  Created by Martin Kiss on 30.12.13.
//  Copyright © 2014 Martin Kiss. All rights reserved.
//

#import "OCAObject.h"

@class OCAProducer;
@protocol OCAConsumer;





/// Connection represents a data flow from a Provider to Consumer with customizable behavior.
@interface OCAConnection : OCAObject



- (instancetype)initWithProducer:(OCAProducer *)producer;
@property (OCA_atomic, readonly, weak) OCAProducer *producer;


@property (OCA_atomic, readonly, assign) BOOL closed;
- (void)close;


//TODO: Enabled
//TODO: Enabled Property object
//TODO: Queues
//TODO: Behavior


@property (OCA_atomic, readwrite, strong) NSValueTransformer *transformer;
@property (OCA_atomic, readwrite, strong) NSPredicate *predicate;


@property (OCA_atomic, readwrite, strong) id<OCAConsumer> consumer;



@end
