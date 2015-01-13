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
    class func faceEvents(names:[AnyObject]) -> [CaptchaFaceEvent]
    {
        var events:[CaptchaFaceEvent]?
        
        for name in names
        {
            let stringName = name as? String
            
            if let actualStringName = stringName
            {
                var event:CaptchaFaceEvent?
                
                switch actualStringName
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
                default :
                    event = nil
                }
                
                if let actualEvent = event
                {
                    events?.append(actualEvent)
                }
            }
        }
        return events!
    }
    
    class func faceEventsStrings() -> [AnyObject]
    {
        var events = [NSLocalizedString("move_up", comment:""), NSLocalizedString("move_down", comment:""), NSLocalizedString("move_left", comment:""), NSLocalizedString("move_right", comment:""), NSLocalizedString("move_forward", comment:""), NSLocalizedString("move_backward", comment:""), NSLocalizedString("smile", comment:""), NSLocalizedString("yell", comment:"")]
        return events
    }
}