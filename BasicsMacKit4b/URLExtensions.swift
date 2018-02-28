//
//  URLExtensions.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 26/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public extension URL
{
    // Convert the url to a cfurl
    public var cfURL: CFURL
    {
        return CFBridgingRetain(self) as! CFURL
    }
}
