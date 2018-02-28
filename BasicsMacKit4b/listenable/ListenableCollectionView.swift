//
//  ListenableCollectionVIew.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 16/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation
import Cocoa

public class ListenableCollectionView: NSCollectionView
{

    
    
    /// The mouse down event listened, returns true if the event was consumed ( will not be passed to parent ), false if not
    public var onMouseDown: ((_ event: NSEvent) -> Bool)? = nil
    
    
    public override func mouseDown(with event: NSEvent) {
        if onMouseDown == nil || !onMouseDown!(event)
        {
            super.mouseDown(with: event)
        }
    }
    
    
    /// The mouse up event listened, returns true if the event was consumed ( will not be passed to parent ), false if not
    public var onMouseUp: ((_ event: NSEvent) -> Bool)? = nil
    
    
    public override func mouseUp(with event: NSEvent) {
        if onMouseUp == nil || !onMouseUp!(event)
        {
            super.mouseUp(with: event)
        }
    }
    
    
    /// The mouse dragged event listened, returns true if the event was consumed ( will not be passed to parent ), false if not
    public var onMouseDragged: ((_ event: NSEvent) -> Bool)? = nil
    

    
    public override func mouseDragged(with event: NSEvent) {
        if onMouseDragged == nil || !onMouseDragged!(event)
        {
            super.mouseDragged(with: event)
        }
    }
    
    
    
}
