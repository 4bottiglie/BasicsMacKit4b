//
//  SetExtensions.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 23/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public extension Set
{
    ///Insert all elements into the set
    public mutating func insertAll<C: Sequence>(_ newMembers: C) where C.Element == Set.Element
    {
        for element in newMembers
        {
            self.insert(element)
        }
    }
}
