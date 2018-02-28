//
//  BookmarksManager.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 17/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation


public class BookmarksManager
{
    public let fileName: String
    
    public let filePath: URL
    
    public private(set) var bookmarks = [URL : Data]()
    
    /// True if the bookmarks are loaded, at least one time, false if need loading
    public private(set) var isLoaded = false
    
    public init(fileName: String)
    {
        self.fileName = fileName
        
        self.filePath = FileManager.default.appDocuments.appendingPathComponent(fileName)
    }
    
    /// Load the bookmarks
    public func load()
    {
        bookmarks = (NSKeyedUnarchiver.unarchiveObject(withFile: filePath.path) as? [URL: Data]) ?? [:]
        
        for bookmark in bookmarks
        {
            restore(bookmark: bookmark)
        }
        
    }
    
  
    /// Restore the bookmar
    private func restore(bookmark: (key: URL, value: Data))
    {
        var restoredURL: URL?
        var isStale = false
        
        do
        {
            restoredURL = try URL(resolvingBookmarkData: bookmark.value, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
            
        }catch
        {
            print(error)
            
            restoredURL = nil
        }
        
        if let url = restoredURL
        {
            if isStale
            {
                print("URL is stale")
            }else
            {
                if !url.startAccessingSecurityScopedResource()
                {
                    print("Couldn't access \(url.path)")
                }
            }
        }
    }
    
    
    
    /// Store the bookmark
    /// - return true if was successufully, false if not
    public func store(bookmarkURL: URL) -> Bool
    {
        do
        {
            let data = try bookmarkURL.bookmarkData(options: NSURL.BookmarkCreationOptions.withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            bookmarks[bookmarkURL] = data
            
            return true
        }catch
        {
            print("Error during storing bookmark: \(error)")
            
            return false
        }
    }
    
    /// Save the bookmarks
    public func save()
    {
        NSKeyedArchiver.archiveRootObject(bookmarks, toFile: filePath.path)
    }
    
    @discardableResult
    public func allowDirectory(_ directoryPath: URL, window: NSWindow, onFinish: ((_ isSuccess: Bool) -> ())?) -> URL?
    {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        
        panel.directoryURL = URL(fileURLWithPath: directoryPath.path, isDirectory: true)
        
        panel.beginSheetModal(for: window) { (result) in
            
            if result == NSApplication.ModalResponse.OK
            {
                //print()
                let result = self.store(bookmarkURL: panel.url!)
                if result
                {
                    self.save()
                }
                
                onFinish?(result)
            }else
            {
                onFinish?(false)
            }
            
        }
        
        return panel.url
        
    }
}














