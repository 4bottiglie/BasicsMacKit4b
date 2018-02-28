//
//  ManualScrollableView.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 20/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation

public protocol ManualScrollableView
{
    var manualScrollableView: NSView { get }
    
    var onMouseDown: ((_ event: NSEvent) -> (Bool))? { get set }
    
    var onMouseUp: ((_ event: NSEvent) -> (Bool))? { get set }
    
    var onMouseDragged: ((_ event: NSEvent) -> (Bool))? { get set }
}
