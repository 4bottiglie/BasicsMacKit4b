//
//  ViewHidder.swift
//  BasicsMacKit4b
//
//  Created by Sorin George Budescu on 24/02/18.
//  Copyright © 2018 Sorin George Budescu. All rights reserved.
//

import Foundation
import Cocoa

///If used in a viewcontroller, then init this class into the viewWillAppear
public class ViewHidder
{
    public let view: NSView
    
    private var constraints: [NSLayoutConstraint]
    
    public var width: SingleMeasureViewHidder!
    public var height: SingleMeasureViewHidder!
    
    private var _recordIsHiddenHeight: Bool = false
    
    public init(view: NSView)
    {
        self.view = view
        self.constraints = view.getAllTreeConstraints()
        
        width = SingleMeasureViewHidder(view: view, measure: .width, hidder: self)
        height = SingleMeasureViewHidder(view: view, measure: .height, hidder: self)
        
    }
    
    
    
    public class SingleMeasureViewHidder
    {
        public let hidder: ViewHidder
        
        public let view: NSView
        
        public var measure: Measure
        
        private let constraint: NSLayoutConstraint
        
        private var childs = [SingleMeasureViewHidder]()
        public private(set) var parent: SingleMeasureViewHidder? = nil
        
        
        public init(view: NSView, measure: Measure, hidder: ViewHidder)
        {
            self.view = view
            self.measure = measure
            self.hidder = hidder
            
            let constraintType: NSLayoutConstraint.Attribute = measure == .width ? .width : .height
            
            constraint = NSLayoutConstraint(item: view, attribute: constraintType, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        }
        
        private var _isVisible: Bool = true
        public var isVisible: Bool
        {
            get
            {
                return _isVisible
            }
            set(newVisibility)
            {
                self._isVisible = newVisibility
                if canChangeVisiblity()
                {
                    setVisible(newVisibility)
                }
            }
        }
        
        ///Set the view visible or gone
        private func setVisible(_ visible: Bool)
        {
            if visible
            {
                view.removeConstraint(constraint)
                hidder.constraints.allActivated = true
                
                for child in childs
                {
                    child.setVisible(child._isVisible)
                }
                
            }else
            {
                for child in childs
                {
                    child.setVisible(true)
                }
                
                hidder.constraints.allActivated = false
                view.addConstraint(constraint)
        
            }
            
            view.isHidden = !visible
        
            view.needsUpdateConstraints = true
            view.updateConstraintsForSubtreeIfNeeded()
        }
        
     
        
        /// - return true if the view can change visibility
        private func canChangeVisiblity() -> Bool
        {
            return parent == nil || parent!.isVisible
        }
        
        ///Add the view child
        public func addChild(_ child: SingleMeasureViewHidder)
        {
            if !childs.contains(where: { $0 === child})
            {
                childs.append(child)
                child.parent = self
            }else
            {
                fatalError("Child already contained")
            }
        }
        
        ///Remove the child if contained
        public func removeChild(_ child: SingleMeasureViewHidder)
        {
            if let index = childs.index(where: { $0 === child })
            {
                let child = childs[index]
                childs.remove(at: index)
                child.parent = nil
            }
            
        }
        
        
        public enum Measure
        {
            case width, height
        }
    }
}





















