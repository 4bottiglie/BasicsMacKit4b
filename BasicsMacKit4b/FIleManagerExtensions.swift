//
//  FIleManagerExtensions.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 09/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public extension FileManager
{
    /// - return true if the path is leading to a file and exists
    public func isFileAndExists(atPath path: String) -> Bool
    {
        var isDir: ObjCBool = false
        if self.fileExists(atPath: path, isDirectory: &isDir)
        {
            return !isDir.boolValue
        }
        return false
    }
    
    /// - return true if the path is leading to a directory and exists
    public func isDirectoryAndExists(atPath path: String) -> Bool
    {
        var isDir: ObjCBool = false
        if self.fileExists(atPath: path, isDirectory: &isDir)
        {
            return isDir.boolValue
        }
        return false
    }
    
    /// - return the application documents directory URL
    public var appDocuments: URL
    {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    
    
}

///Images extensions
public extension FileManager
{
    public static func isImage(filePath: String) -> Bool
    {
        let url = URL(fileURLWithPath: filePath)
        let fileExtension = url.pathExtension
        if let fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as CFString, nil)?.takeUnretainedValue()
        {
            /// change  kUTTypeImage to kUTTypeMovie or kUTTypeText
            /// see https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html
            
            return UTTypeConformsTo(fileUTI, kUTTypeImage)
        }
        
        return false
    }
}
