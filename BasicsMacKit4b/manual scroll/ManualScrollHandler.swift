//
//  ManualScrollHandler.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 16/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation
import Cocoa

///This a handler for the mouse events to make it able to scroll the internal handledView
/// The user must call mouseDown, mouseUp and mouseDragged from the handled view
public class ManualScrollHandler
{

    ///Drag components
    public private(set) var mouseDragged = false
    private var lastDragPosition: NSPoint? = nil
    private var speedDraggingX: CGFloat = 0
    private var speedDraggingY: CGFloat = 0
    private var lastTimeDragged: TimeInterval = 0
    
    public var continueDraggingWithSpeed = true
    
    private var handledView: NSView
    
    /// Supports the zoom coefficient to make the user able to scroll less if the scrollview is zoomed
    public var zoomCoefficient: CGFloat = 1
    
    public var changeDraggingIcon = true
    
    
    ///Init a new manual scroll handler
    /// - handledView: the view to be handled and must be basing on the case:
    ///    @NSScrollView: the clipview
    public init(handledView: NSView)
    {
        self.handledView = handledView
    }
    
    
    public func mouseDown(with event: NSEvent)
    {
        mouseDragged = false
        
        lastDragPosition = event.locationInWindow
    }
    
    
    public func mouseUp(with event: NSEvent)
    {
        if mouseDragged
        {
            if changeDraggingIcon
            {
                NSCursor.pop()
            }
            
            
            if continueDraggingWithSpeed
            {
                DispatchQueue.main.async
                    {
                        self.startDragSpeedAnimation()
                }
            }
            
        }
        
        mouseDragged  = false
        
        lastDragPosition = nil
        
        lastTimeDragged = 0
        
        
    }
    
    ///Continue the drag animation basing on the dragging speed detected
    private func startDragSpeedAnimation()
    {
        NSAnimationContext.runAnimationGroup({ context in
            
            let newMinX = handledView.bounds.minX + speedDraggingX
            
            let newMinY = handledView.bounds.minY + speedDraggingY
            
            let newBounds = CGRect(x: newMinX , y: newMinY, width: handledView.bounds.width, height: handledView.bounds.height)
            
            handledView.animator().bounds = newBounds
            
        }) {
            //onFinish
        }
    }
    
    
    
    public func mouseDragged(with event: NSEvent)
    {
        if changeDraggingIcon
        {
            NSCursor.closedHand.push()
        }
        mouseDragged = true
        
         let nowTime = Date().timeIntervalSince1970
        
        if lastDragPosition != nil
        {
            let deltaX = (lastDragPosition!.x - event.locationInWindow.x) * zoomCoefficient
            let deltaY = (lastDragPosition!.y - event.locationInWindow.y) * zoomCoefficient
            
            scrollBy(xOffset: deltaX, yOffset: deltaY)
            
            if lastTimeDragged > 0
            {
                var timeDragged = nowTime - lastTimeDragged
                if timeDragged < 0.1
                {
                    timeDragged = 0.1
                }
                
                speedDraggingX = (deltaX / CGFloat(timeDragged))
                speedDraggingY = deltaY / CGFloat(timeDragged)
            }
        }
        
        
        
        
        lastDragPosition = event.locationInWindow
        lastTimeDragged = nowTime
        
        
    }
    
    
    ///Scroll the image with the x and y offsets
    /// - param xOffset: the offset of the x axis to be moved ( added )
    /// - param yOffset: the offset of the y axis to be moved ( added )
    public func scrollBy(xOffset: CGFloat, yOffset: CGFloat)
    {
        let visibleRect = handledView.visibleRect
        
        handledView.scroll(NSPoint(x: visibleRect.minX + xOffset, y: visibleRect.minY + yOffset))
    }
    
    
    ///Scroll the image to possibly center the x and the y leaving ( possibily ), equal space from left and right border
    public func scrollToCenter(xCenter: CGFloat, yCenter: CGFloat)
    {
        let visibleRect = handledView.visibleRect
        
        let x = xCenter - visibleRect.width / 2
        let y = yCenter - visibleRect.height / 2
        
        handledView.scroll(NSPoint(x: x, y: y))
    }
        
    

}







