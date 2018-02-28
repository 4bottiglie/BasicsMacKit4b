//
//  ListenableScrollView.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 16/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation
import Cocoa

public class ListenableScrollView: NSScrollView
{
    
    /// The wheel scroll event listened, returns true if the event was consumed ( will not be passed to parent ), false if not
    public var onWheelScrolled: ((_ event: NSEvent) -> Bool)? = nil
    
    public override func scrollWheel(with event: NSEvent)
    {
        if onWheelScrolled == nil || !onWheelScrolled!(event)
        {
            super.scrollWheel(with: event)
        }
        
        //print(event)
    }
    
}
