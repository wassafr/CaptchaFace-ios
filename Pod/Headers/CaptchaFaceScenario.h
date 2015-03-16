//
//  CaptchaFaceScenario.h
//  CaptchaFace
//
//  Created by Peter Schaeffer on 01/12/2014.
//  Copyright (c) 2014 Wassa. All rights reserved.
//
#import "CaptchaFaceEvent.h"

@interface CaptchaFaceScenario : NSObject

/**
 *  Instance factory to create a scenario with default parameters
 *
 *  @return a scneario with between 3 and 5 random events with an interval of 1.5 second between events and 10.0 seconds of failure time
 */
+ (instancetype)defaultScenario;

/**
 *  Instance factory to creata a scenario with specified number of events and interval / failure times
 *
 *  @param countRange            A range describing the number of events required. a random number of event between countRange.location and countRange.location + countRange.length
 *  @param intervalBetweenEvents The interval in second between consecutive events ( max 10 seconds)
 *  @param failureTimeInterval   The time in seconds allowed to complete an event ( max 60 seconds)
 *
 *  @return the instantiated object
 */
+ (instancetype)scenarioWithRandomEvents:(NSRange)countRange intervalBetweenEvents:(NSTimeInterval)intervalBetweenEvents failureTimeInterval:(NSTimeInterval)failureTimeInterval;
/**
 *  Insatance factory to create
 *
 *  @param CaptchaFaceEvents      an array containing 
 *  @param intervalBetweenEvents The interval in second between consecutive events ( max 10 seconds)
 *  @param failureTimeInterval   The time in seconds allowed to complete an event ( max 60 seconds)
 *
 *  @return the instantiated object
 */
+ (instancetype)scenarioWithEvents:(NSArray*)CaptchaFaceEvents intervalBetweenEvents:(NSTimeInterval)intervalBetweenEvents failureTimeInterval:(NSTimeInterval)failureTimeInterval;


@property (assign, nonatomic) NSTimeInterval intervalBetweenEvents;
@property (assign, nonatomic) NSTimeInterval failureTimeInterval;
@property (assign, nonatomic) NSRange randomRange;
@property (strong, nonatomic) NSArray *events;


@end