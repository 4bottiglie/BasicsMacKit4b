//
//  NSViewExtensions.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 12/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public extension NSView
{
    /// Convert the full window point into a local view point basing on self bounds
    /// X and/or Y value will result:
    /// - negative if the fullWindowPoint is out of bounds and before the view start
    /// - positive and less then the width/height if into the bounds
    /// - positive and more then the width/height if out of bounds and after the view end
    public func convertToLocalPoint(fullWindowPoint: NSPoint) -> NSPoint
    {
        return NSPoint(x: fullWindowPoint.x - self.frame.minX, y: fullWindowPoint.y - self.frame.minY)
    }
    
    
    /// - return the current view constraints and all teh subiew constraints
    public func getAllTreeConstraints() -> [NSLayoutConstraint]
    {
        var constraints = Set<NSLayoutConstraint>()
        
        constraints.insertAll(self.constraints)
        
        for subview in subviews
        {
            constraints.insertAll(subview.getAllTreeConstraints())
        }
        
        return Array(constraints)
        
    }
    
    /// Set the constraints enabled or disabled
    /// - param actived: true to activate all constraints, false to deactivate them
    /// - param includeSubviews: true to include the subviews constraints, false to include only this view's constraints
    public func setAllConstraintsActived(_ activated: Bool, includeSubviews: Bool = true)
    {
        var constraints = includeSubviews ? getAllTreeConstraints() : self.constraints
        
        constraints.allActivated = activated
    }
    
    
    
    
    /// Add the width constraint to self
    public func addWidthConstraint(width: Int, id: String? = nil)
    {
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        widthConstraint.identifier = id
        
        self.addConstraint(widthConstraint)
    }
    
    /// Add the height constraint to self
    public func addHeightConstraint(height: Int, id: String? = nil)
    {
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        heightConstraint.identifier = id
        
        self.addConstraint(heightConstraint)
    }
    
    
    
}

















