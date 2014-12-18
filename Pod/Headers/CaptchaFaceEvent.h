//
//  CaptchaFaceEvent.h
//  CaptchaFace
//
//  Created by Peter Schaeffer on 03/12/2014.
//  Copyright (c) 2014 Wassa. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  Enum describing each possible event type
 */
typedef NS_ENUM(NSUInteger, CaptchaEventType){
    /**
     *  Move your Face to the top of the screen
     */
    MOVE_UP = 10,
    /**
     *  Move your face closer to the bottom of the screen
     */
    MOVE_DOWN = 11,
    /**
     *  Move your face closer to the left of the screen
     */
    MOVE_LEFT = 12,
    /**
     *  Move your face closer to the right of the screen
     */
    MOVE_RIGHT = 13,
    /**
     *  Move your face closer to the screen
     */
    MOVE_FORWARD = 20,
    /**
     *  Move your face further from the screen
     */
    MOVE_BACKWARD = 21,
    /**
     *  Smile
     */
    SMILE = 30,
    /**
     *  Be suprised ( mouth wide open and surprised eyebrow )
     */
    YELL = 31
};

/**
 *  Object representing a single event in a captcha scenario
 */
@interface CaptchaFaceEvent : NSObject
/**
 *  Instance factory to create en event with a specific type
 *
 *  @param eventType the event type
 *
 *  @return the instantiated object
 */
+ (instancetype)captchaEventWithType:(CaptchaEventType)eventType;
/**
 *  Instance factory for a move up event
 *
 *  @return the instantiated object
 */
+ (instancetype)moveUp;
/**
 *  Instance factory for a move Down event
 *
 *  @return the instantiated object
 */
+ (instancetype)moveDown;
/**
 *  Instance factory for a move left event
 *
 *  @return the instantiated object
 */
+ (instancetype)moveLeft;
/**
 *  Instance factory for a move right event
 *
 *  @return the instantiated object
 */
+ (instancetype)moveRight;
/**
 *  Instance factory for a move forward event
 *
 *  @return the instantiated object
 */
+ (instancetype)moveForward;
/**
 *  Instance factory for a move backward event
 *
 *  @return the instantiated object
 */
+ (instancetype)moveBackward;
/**
 *  Instance factory for a smile event
 *
 *  @return the instantiated object
 */
+ (instancetype)smile;
/**
 *  Instance factory for a yell event
 *
 *  @return the instantiated object
 */
+ (instancetype)yell;
@property(assign) CaptchaEventType eventType;
@end
