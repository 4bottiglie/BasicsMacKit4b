//
//  NSColorExtensions.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 09/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public extension NSColor
{
    
    
    /// parse the string into a color
    /// supports: RGB (12-bit) , RGB ( 24-bit ) RRGGBB, ARGB ( 30-bit ) AARRGGBB
    /// # start is supported
    /// - return the color parse or nil if a error occur
    public static func parseColor(_ hex: String) -> NSColor?
    {
        let hexArgbToConvert: String = hex.trimmed.replacingOccurrences(of: "#", with: "")
        
        var intVal: UInt32 = 0
        Scanner(string: hexArgbToConvert).scanHexInt32(&intVal)
        let a, r, g, b: UInt32
        
        switch hexArgbToConvert.count
        {
        case 3: // RGB ( 12-bit )
            (a, r, g, b) = (255, (intVal >> 8)*17, (intVal >> 4 & 0xF)*17, (intVal & 0xF) * 17)
        case 6: // RGB ( 24-bit )
            (a, r, g, b) = (255, intVal >> 16, intVal >> 8 & 0xFF , intVal & 0xFF)
        case 8: // ARGB ( 30-bit )
            (a, r, g, b) = (intVal >> 24, intVal >> 16 & 0xFF, intVal >> 8 & 0xFF , intVal & 0xFF)
        default:
            return nil
        }
        
        return NSColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a)/255.0)
    }
    
    /// parse the color from integer rappresentation
    public static func parseColorFromInt(_ int: Int) -> NSColor?
    {
        return parseColor(String(format: "#%08X",int))
    }
    
    
}
