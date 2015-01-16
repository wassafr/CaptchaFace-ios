//
//  CaptchaFaceEvent+utilities.swift
//  CaptchaFace
//
//  Created by Dorothée DOUBLET on 12/01/2015.
//  Copyright (c) 2015 Peter Schaeffer. All rights reserved.
//

import Foundation

extension CaptchaFaceEvent
{
    class func faceEventsStrings() -> [AnyObject]
    {
        var eventsStrings = [NSLocalizedString("move_up", comment:""), NSLocalizedString("move_down", comment:""), NSLocalizedString("move_left", comment:""), NSLocalizedString("move_right", comment:""), NSLocalizedString("move_forward", comment:""), NSLocalizedString("move_backward", comment:""), NSLocalizedString("smile", comment:""), NSLocalizedString("yell", comment:"")]
        return eventsStrings
    }
    
    class func faceEvents(names:[AnyObject]) -> [AnyObject]
    {
        var events = Array<CaptchaFaceEvent>()
        
        for name in names
        {
            let stringName = name as String
            
            var event:CaptchaFaceEvent?
            
            switch stringName
            {
            case NSLocalizedString("move_up",comment:""):
                event = CaptchaFaceEvent.moveUp()
            case NSLocalizedString("move_down",comment:""):
                event = CaptchaFaceEvent.moveDown()
            case NSLocalizedString("move_left",comment:""):
                event = CaptchaFaceEvent.moveLeft()
            case NSLocalizedString("move_right",comment:""):
                event = CaptchaFaceEvent.moveRight()
            case NSLocalizedString("move_forward",comment:""):
                event = CaptchaFaceEvent.moveForward()
            case NSLocalizedString("move_backward",comment:""):
                event = CaptchaFaceEvent.moveBackward()
            case NSLocalizedString("smile",comment:""):
                event = CaptchaFaceEvent.smile()
            case NSLocalizedString("yell",comment:""):
                event = CaptchaFaceEvent.yell()
            default :
                event = nil
            }
            
            if let actualEvent = event?
            {
                events.append(actualEvent)
            }
            
        }
        return events
    }
}