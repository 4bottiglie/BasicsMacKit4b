//
//  NSLayoutConstraintsExtensions.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 23/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation
import Cocoa

public extension Array where Array.Element == NSLayoutConstraint
{
    /// Set all the elements activated / deactivated
    /// - return true if all the elements are activated
    /// - return true if the array is empty
    public var allActivated: Bool
    {
        get
        {
            for element in self
            {
                if !element.isActive
                {
                    return false
                }
            }
            
            return true
        }
        
        set(newActivationMode)
        {
            for element in self
            {
                element.isActive = newActivationMode
            }
        }
    }
}
