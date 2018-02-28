//
//  StringUtils.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 09/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public extension String
{
    
    /// java-like trim of the string: remove the extra spaces and newLines
    public func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// java-like trim of the string: remove the extra spaces and newLines
    public var trimmed: String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
