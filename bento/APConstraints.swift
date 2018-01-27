//
//  APConstraints.swift
//  Copyright (c) 2015 Appsidian. All rights reserved.
//

/*

CODE SNIPPETS: Select any of the following blocks of code and drag them into your code snippets drawer.

Title: APConstraints
Summary: Add multiple constraints.
Completion Shortcut: addConstraints
Completion Scope: All

addConstraints(
            Constraint.<#constraint#>.of(<#AnyObject#>),
            Constraint.<#constraint#>.of(<#AnyObject#>))

------------------

Title: APConstraint
Summary: Single APConstraint.
Completion Shortcut: Constraint
Completion Scope: All

    Constraint.<#constraint#>.of(<#AnyObject#>)

*/

import UIKit


// MARK: - Constraint Enum
// ----------------------------------------------------------------------------------------------------------------------------------------------
public enum Constraint {
    // X Axis
    case LeftToLeftRightToRight
    case LeftToLeft
    case LeftToRight
    case LeftToCenterX
    case RightToRight
    case RightToLeft
    case RightToCenterX
    case CenterXToCenterX
    case CenterXToLeft
    case CenterXToRight
    case Width
    case MaxWidth
    case MinWidth
    case IntrinsicContentWidth
    case WidthHeight
    // Y Axis
    case HeightWidth
    case TopToTopBottomToBottom
    case TopToTop
    case TopToBottom
    case TopToCenterY
    case BottomToBottom
    case BottomToTop
    case BottomToCenterY
    case CenterYToCenterY
    case CenterYToTop
    case CenterYToBottom
    case Height
    case MaxHeight
    case MinHeight
    case IntrinsicContentHeight
    case Baseline
    case Default
    
    // X Axis
    public static let llrr  = Constraint.LeftToLeftRightToRight
    public static let ll    = Constraint.LeftToLeft
    public static let lr    = Constraint.LeftToRight
    public static let lcx   = Constraint.LeftToCenterX
    public static let rr    = Constraint.RightToRight
    public static let rl    = Constraint.RightToLeft
    public static let rcx   = Constraint.RightToCenterX
    public static let cxcx  = Constraint.CenterXToCenterX
    public static let cxl   = Constraint.CenterXToLeft
    public static let cxr   = Constraint.CenterXToRight
    public static let w     = Constraint.Width
    public static let maxw  = Constraint.MaxWidth
    public static let minw  = Constraint.MinWidth
    public static let iw    = Constraint.IntrinsicContentWidth
    public static let wh    = Constraint.WidthHeight
    // Y Axis
    public static let hw    = Constraint.HeightWidth
    public static let ttbb  = Constraint.TopToTopBottomToBottom
    public static let tt    = Constraint.TopToTop
    public static let tb    = Constraint.TopToBottom
    public static let tcy   = Constraint.TopToCenterY
    public static let bb    = Constraint.BottomToBottom
    public static let bt    = Constraint.BottomToTop
    public static let bcy   = Constraint.BottomToCenterY
    public static let cycy  = Constraint.CenterYToCenterY
    public static let cyt   = Constraint.CenterYToTop
    public static let cyb   = Constraint.CenterYToBottom
    public static let h     = Constraint.Height
    public static let maxh  = Constraint.MaxHeight
    public static let minh  = Constraint.MinHeight
    public static let ih    = Constraint.IntrinsicContentHeight
    public static let bsln  = Constraint.Baseline
    
    init() {
        self = .Default
    }
    
    // Methods for buildling constraints
    
    public func of(of: UIView?, relation: NSLayoutRelation, offset: CGFloat, multiplier: CGFloat, priority: UILayoutPriority) -> APConstraint {
        return APConstraint(constraint: self, of: of, relation: relation, offset: offset, multiplier: multiplier, priority: priority)
    }
    
    public func of(of: UIView?, offset: CGFloat, priority: UILayoutPriority) -> APConstraint {
        return APConstraint(constraint: self, of: of, offset: offset, priority: priority)
    }
    
    public func of(of: UIView?, offset: CGFloat, multiplier: CGFloat) -> APConstraint {
        return APConstraint(constraint: self, of: of, offset: offset, multiplier: multiplier)
    }
    
    public func of(of: UIView?, multiplier: CGFloat) -> APConstraint {
        return APConstraint(constraint: self, of: of, offset: 0, multiplier: multiplier)
    }
    
    public func of(of: UIView?, offset: CGFloat) -> APConstraint {
        return APConstraint(constraint: self, of: of, offset: offset)
    }
    
    public func of(of: UIView?, priority: UILayoutPriority) -> APConstraint {
        return APConstraint(constraint: self, of: of, offset: 0, priority: priority)
    }
    
    public func of(offset: CGFloat, priority: UILayoutPriority) -> APConstraint {
        return APConstraint(constraint: self, of: nil, offset: offset, priority: priority)
    }
    
    public func of(offset: CGFloat) -> APConstraint {
        return APConstraint(constraint: self, offset: offset)
    }
    
    public func of(of: UIView?) -> APConstraint {
        return APConstraint(constraint: self, of: of, offset: 0)
    }
    
    // Methods for determining type of constraint
    fileprivate func isXAxisConstraint() -> Bool {
        return self == .llrr || self == .ll || self == .lr || self == .lcx || self == .rr || self == .rl || self == .rcx || self == .cxcx || self == .cxl || self == .cxr || self == .w || self == .iw || self == .wh // don't include maxw
    }
    
    fileprivate func isCenterXConstraint() -> Bool {
        return self == .cxcx || self == .cxl || self == .cxr
    }
    
    fileprivate func isYAxisConstraint() -> Bool {
        return  self == .hw || self == .ttbb || self == .tt || self == .tb || self == .tcy || self == .bb || self == .bt || self == .bcy || self == .cycy || self == .cyt || self == .cyb || self == .h || self == .ih || self == .bsln // don't include maxh
    }
    
    fileprivate func isCenterYConstraint() -> Bool {
        return  self == .cycy || self == .cyt || self == .cyb
    }
}


// MARK: - APConstraint
// ----------------------------------------------------------------------------------------------------------------------------------------------
/// To create APConstraints use the convenience `of` methods on the Constraint enum like so:
/// `subview.addConstraints(Constraint.ll.of(superview))`
/// Where `of(...)` returns an APConstraint which can be used to quickly add NSLayoutConstraints
public class APConstraint {
    var constraint: Constraint
    var of: UIView?
    var multiplier: CGFloat?
    var offset: CGFloat
    var priority: UILayoutPriority?
    var relation: NSLayoutRelation?
    
    fileprivate init(constraint: Constraint, of: UIView?, relation: NSLayoutRelation, offset: CGFloat, multiplier: CGFloat?, priority: UILayoutPriority?) {
        self.constraint = constraint
        self.of = of
        self.offset = offset
        self.relation = relation
        self.multiplier = multiplier
        self.priority = priority
    }
    
    fileprivate convenience init(constraint: Constraint, of: UIView?, offset: CGFloat, multiplier: CGFloat?) {
        self.init(constraint: constraint, of: of, relation: .equal, offset: offset, multiplier: multiplier, priority: UILayoutPriority.required)
    }
    
    fileprivate convenience init(constraint: Constraint, of: UIView?, offset: CGFloat, priority: UILayoutPriority) {
        self.init(constraint: constraint, of: of, relation: .equal, offset: offset, multiplier: 1.0, priority: priority)
    }
    
    fileprivate convenience init(constraint: Constraint, of: UIView?, offset: CGFloat) {
        self.init(constraint: constraint, of: of, relation: .equal, offset: offset, multiplier: 1.0, priority: UILayoutPriority.required)
    }
    
    fileprivate convenience init(constraint: Constraint, offset: CGFloat) {
        self.init(constraint: constraint, of: nil, relation: .equal, offset: offset, multiplier: 1.0, priority: UILayoutPriority.required)
    }
}


// MARK: - Magic
// ----------------------------------------------------------------------------------------------------------------------------------------------
public extension UIView {
    
    /// Instead of initializing `APConstraint` objects directly, use the convenience `of(...)` methods on the `Constraint` class like so:
    /// `subview.addConstraints(Constraint.ll.of(superview))`
    public func addConstraints(constraints: APConstraint...) {
        // Check for existence of superview before attempting to apply constraints.
        guard let superview = superview else {
            return print("Warning: \(self) has not been added to a superview. Constraints will not be applied.")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        removeAllConstraints()
        
        for constraint in constraints {
            let multiplier = constraint.multiplier ?? 1.0
            var priority = constraint.priority ?? UILayoutPriority.required
            let relation = constraint.relation ?? .equal
            
            var newConstraint: NSLayoutConstraint?
            var secondNewConstraint: NSLayoutConstraint?
            
            switch constraint.constraint {
                // X Axis ---------------------------------------------------------------------------------------------------------------------------
            case .LeftToLeftRightToRight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: constraint.of, attribute: .left, multiplier: multiplier, constant: constraint.offset)
                secondNewConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: relation, toItem: constraint.of, attribute: .right, multiplier: multiplier, constant: -constraint.offset)
            case .LeftToLeft:
                newConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: constraint.of, attribute: .left, multiplier: multiplier, constant: constraint.offset)
            case .LeftToRight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: constraint.of, attribute: .right, multiplier: multiplier, constant: constraint.offset)
            case .LeftToCenterX:
                newConstraint = NSLayoutConstraint(item: self, attribute: .left, relatedBy: relation, toItem: constraint.of, attribute: .centerX, multiplier: multiplier, constant: constraint.offset)
            case .RightToRight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: relation, toItem: constraint.of, attribute: .right, multiplier: multiplier, constant: constraint.offset)
            case .RightToLeft:
                newConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: relation, toItem: constraint.of, attribute: .left, multiplier: multiplier, constant: constraint.offset)
            case .RightToCenterX:
                newConstraint = NSLayoutConstraint(item: self, attribute: .right, relatedBy: relation, toItem: constraint.of, attribute: .centerX, multiplier: multiplier, constant: constraint.offset)
            case .CenterXToCenterX:
                newConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: constraint.of, attribute: .centerX, multiplier: multiplier, constant: constraint.offset)
            case .CenterXToLeft:
                newConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: constraint.of, attribute: .left, multiplier: multiplier, constant: constraint.offset)
            case .CenterXToRight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: relation, toItem: constraint.of, attribute: .right, multiplier: multiplier, constant: constraint.offset)
            case .Width:
                newConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: constraint.of, attribute: .width, multiplier: multiplier, constant: constraint.offset)
            case .MaxWidth:
                newConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .lessThanOrEqual, toItem: constraint.of, attribute: .width, multiplier: multiplier, constant: constraint.offset)
            case .MinWidth:
                newConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: constraint.of, attribute: .width, multiplier: multiplier, constant: constraint.offset)
            case .IntrinsicContentWidth:
                newConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: constraint.of, attribute: .width, multiplier: multiplier, constant: intrinsicContentSize.width + constraint.offset)
            case .WidthHeight:
                if constraint.of == nil {
                    // Constrain width and height to a constant (used if only a CGFloat is given)
                    newConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constraint.offset)
                    secondNewConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constraint.offset)
                } else {
                    // Constrain width to height of view2 (used if a UIView is given)
                    newConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: constraint.of, attribute: .height, multiplier: multiplier, constant: constraint.offset)
                }
            case .HeightWidth:
                if constraint.of == nil {
                    // Constrain width and height to a constant (used if only a CGFloat is given)
                    newConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constraint.offset)
                    secondNewConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multiplier, constant: constraint.offset)
                } else {
                    // Constrain height to width of view2 (used if a UIView is given)
                    newConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: constraint.of, attribute: .width, multiplier: multiplier, constant: constraint.offset)
                }
                
                // Y Axis ---------------------------------------------------------------------------------------------------------------------------
            case .TopToTopBottomToBottom:
                newConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: constraint.of, attribute: .top, multiplier: multiplier, constant: constraint.offset)
                secondNewConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: constraint.of, attribute: .bottom, multiplier: multiplier, constant: -constraint.offset)
            case .TopToTop:
                newConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: constraint.of, attribute: .top, multiplier: multiplier, constant: constraint.offset)
            case .TopToBottom:
                newConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: constraint.of, attribute: .bottom, multiplier: multiplier, constant: constraint.offset)
            case .TopToCenterY:
                newConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: constraint.of, attribute: .centerY, multiplier: multiplier, constant: constraint.offset)
            case .BottomToBottom:
                newConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: constraint.of, attribute: .bottom, multiplier: multiplier, constant: constraint.offset)
            case .BottomToTop:
                newConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: constraint.of, attribute: .top, multiplier: multiplier, constant: constraint.offset)
            case .BottomToCenterY:
                newConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: constraint.of, attribute: .centerY, multiplier: multiplier, constant: constraint.offset)
            case .CenterYToCenterY:
                newConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: constraint.of, attribute: .centerY, multiplier: multiplier, constant: constraint.offset)
            case .CenterYToTop:
                newConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: constraint.of, attribute: .top, multiplier: multiplier, constant: constraint.offset)
            case .CenterYToBottom:
                newConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: relation, toItem: constraint.of, attribute: .bottom, multiplier: multiplier, constant: constraint.offset)
            case .Height:
                newConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: constraint.of, attribute: .height, multiplier: multiplier, constant: constraint.offset)
            case .MaxHeight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .lessThanOrEqual, toItem: constraint.of, attribute: .height, multiplier: multiplier, constant: constraint.offset)
            case .MinHeight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: constraint.of, attribute: .height, multiplier: multiplier, constant: constraint.offset)
            case .IntrinsicContentHeight:
                newConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: constraint.of, attribute: .height, multiplier: multiplier, constant: intrinsicContentSize.height + constraint.offset)
            case .Baseline:
                newConstraint = NSLayoutConstraint(item: self, attribute: .lastBaseline, relatedBy: relation, toItem: constraint.of, attribute: .lastBaseline, multiplier: multiplier, constant: constraint.offset)
            case .Default:
                break
            }
            
            // Check to see if in the incoming array of constraints there exists either a Max/Min constraint, adjust priority accordingly
            if constraint.constraint.isXAxisConstraint() {
                if (constraints.filter { $0.constraint == .MaxWidth || $0.constraint == .MinWidth }).count > 0 {
                    priority = constraint.constraint.isCenterXConstraint() ? UILayoutPriority.defaultLow : UILayoutPriority.defaultHigh
                }
            }
            
            if constraint.constraint.isYAxisConstraint() {
                if (constraints.filter { $0.constraint == .MaxHeight || $0.constraint == .MinHeight }).count > 0 {
                    priority = constraint.constraint.isCenterYConstraint() ? UILayoutPriority.defaultLow : UILayoutPriority.defaultHigh
                }
            }
            
            guard let firstNewConstraint = newConstraint else {
                print("Warning: Invalid constraint given for \(self)")
                continue
            }
            
            firstNewConstraint.priority = priority
            superview.addConstraint(firstNewConstraint)
            
            if let secondNewConstraint = secondNewConstraint {
                secondNewConstraint.priority = priority
                superview.addConstraint(secondNewConstraint)
            }
        }
    }
    
    
    // MARK: - Updating Constraints
    // ------------------------------------------------------------------------------------------------------------------------------------------
    
    public func updateConstraint(constraint: Constraint, offset: CGFloat) {
        
        guard let superview = superview else {
            return print("Warning: \(self) has not been added to a superview. Constraints cannot be updated.")
        }
        
        var firstAttribute: NSLayoutAttribute?
        var secondAttribute: NSLayoutAttribute?
        
        // Alternates will be set if the Constraint is a mix of two Constraints, e.g. .llrr
        var alternateFirstAttribute: NSLayoutAttribute?
        var alternateSecondAttribute: NSLayoutAttribute?
        
        
        // TODO: Reorder these to match the pattern above
        switch constraint {
        case .LeftToLeftRightToRight:
            firstAttribute = .left; secondAttribute = .left
            alternateFirstAttribute = .right; alternateSecondAttribute = .right
        case .LeftToLeft:
            firstAttribute = .left; secondAttribute = .left
        case .LeftToRight:
            firstAttribute = .left; secondAttribute = .right
        case .LeftToCenterX:
            firstAttribute = .left; secondAttribute = .centerX
        case .RightToRight:
            firstAttribute = .right; secondAttribute = .right
        case .RightToLeft:
            firstAttribute = .right; secondAttribute = .left
        case .RightToCenterX:
            firstAttribute = .right; secondAttribute = .centerX
        case .TopToTopBottomToBottom:
            firstAttribute = .top; secondAttribute = .top
            alternateFirstAttribute = .bottom; alternateSecondAttribute = .bottom
        case .TopToTop:
            firstAttribute = .top; secondAttribute = .top
        case .TopToBottom:
            firstAttribute = .top; secondAttribute = .bottom
        case .TopToCenterY:
            firstAttribute = .top; secondAttribute = .centerY
        case .BottomToBottom:
            firstAttribute = .bottom; secondAttribute = .bottom
        case .BottomToTop:
            firstAttribute = .bottom; secondAttribute = .top
        case .BottomToCenterY:
            firstAttribute = .bottom; secondAttribute = .centerY
        case .CenterXToCenterX:
            firstAttribute = .centerX; secondAttribute = .centerX
        case .CenterXToLeft:
            firstAttribute = .centerX; secondAttribute = .left
        case .CenterXToRight:
            firstAttribute = .centerX; secondAttribute = .right
        case .CenterYToCenterY:
            firstAttribute = .centerY; secondAttribute = .centerY
        case .CenterYToTop:
            firstAttribute = .centerY; secondAttribute = .top
        case .CenterYToBottom:
            firstAttribute = .centerY; secondAttribute = .bottom
        case .Width:
            firstAttribute = .width; secondAttribute = .width
        case .IntrinsicContentWidth:
            print("Updating constraint .iw is not yet supported")
            return
        case .Height:
            firstAttribute = .height; secondAttribute = .height
        case .WidthHeight:
            firstAttribute = .width; secondAttribute = .width
            alternateFirstAttribute = .height; alternateSecondAttribute = .height
        case .HeightWidth:
            firstAttribute = .height; secondAttribute = .height
            alternateFirstAttribute = .width; alternateSecondAttribute = .width
        case .IntrinsicContentHeight:
            print("Updating constraint .ih is not yet supported")
            return
        case .Baseline:
            firstAttribute = .lastBaseline; secondAttribute = .lastBaseline
        case .MaxWidth:
            print("Updating constraint .maxw is not yet supported")
            return
        case .MinWidth:
            print("Updating constraint .minw is not yet supported")
            return
        case .MaxHeight:
            print("Updating constraint .maxh is not yet supported")
            return
        case .MinHeight:
            print("Updating constraint .minh is not yet supported")
            return
        case .Default:
            break
        }
        
        for existingConstraint in superview.constraints {
            if existingConstraint.firstAttribute == firstAttribute && existingConstraint.secondAttribute == secondAttribute {
                existingConstraint.constant = offset
            }
            
            if let alternateFirstAttribute = alternateFirstAttribute, let alternateSecondAttribute = alternateSecondAttribute {
                if existingConstraint.firstAttribute == alternateFirstAttribute && existingConstraint.secondAttribute == alternateSecondAttribute {
                    existingConstraint.constant = -offset
                }
            }
        }
        
        setNeedsUpdateConstraints()
    }
    
    public func setNeedsUpdateConstraintsOnAllSubviews() {
        setNeedsUpdateConstraints()
        for subview in subviews {
            subview.setNeedsUpdateConstraintsOnAllSubviews()
        }
    }
    
    // MARK: - Removing Constraints
    // ------------------------------------------------------------------------------------------------------------------------------------------
    
    /// Removes all NSLayoutConstraints from the receiver.
    public func removeAllConstraints() {
        if let superview = superview {
            for constraint in superview.constraints {
                if constraint.firstItem as? UIView == self {
                    superview.removeConstraint(constraint)
                }
            }
        }
    }
    
    
    // MARK: - Orientation Constraint Convenience Methods
    // ------------------------------------------------------------------------------------------------------------------------------------------
    
    /// Usage: landscapeConstraints { (Add Constraints) }
    /// Takes advantage of Swift's trailing closure syntax.
    /// The code you include in the closure will only be executed if the device is in
    /// one of the landscape orientations
    public func landscapeConstraints(constraints: () -> Void) {
        if UIDevice.current.orientation.isLandscape {
            constraints()
        }
    }
    
    /// Usage: portraitConstraints { (Add Constraints) }
    /// Takes advantage of Swift's trailing closure syntax.
    /// The code you include in the closure will only be executed if the device is in
    /// one of the portrait orientations
    public func portraitConstraints(constraints: () -> Void) {
        if UIDevice.current.orientation.isPortrait {
            constraints()
        }
    }
    
    
    // MARK: - Convenience Constraint Macros
    // ------------------------------------------------------------------------------------------------------------------------------------------
    
    /// Constrains the receiver to fill the bounds of its superview.
//    public func fillSuperview() {
//        // Check for existence of superview before attempting to apply constraints.
//        guard let superview = superview else {
//            return print("Warning: \(self) has not been added to a superview. fillSuperview() constraint will not be applied.")
//        }
//        addConstraints(
//            constraints: Constraint.llrr.of(superview),
//            Constraint.ttbb.of(superview))
//    }
//    
//    /// Centers the receiver in its superview.
//    public func centerInSuperview() {
//        // Check for existence of superview before attempting to apply constraints.
//        guard let superview = superview else {
//            return print("Warning: \(self) has not been added to a superview. centerInSuperview() constraint will not be applied.")
//        }
//        addConstraints(
//            constraints: Constraint.cxcx.of(superview),
//            Constraint.cycy.of(superview))
//    }
    
    
    // MARK: - Convenience UIView Methods
    // ------------------------------------------------------------------------------------------------------------------------------------------
    
    /// Adds multiple subviews to the receiver.
    public func addSubviews(subviews: UIView...) {
        for view in subviews {
            addSubview(view)
        }
    }
    
}


// MARK: - Banned Dark Magic
// -------------------------------------------------------------------------------
public extension UIView {
    
    @available(*, deprecated: 1.1, message: "Use addConstraints(APConstraint...) instead")
    /// Applies an array of NSLayoutConstraints to the view, using a multiplier and an offset
    public func constrainUsing(constraints: [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)]) {
        var parent = self.superview!
        
        // Checks if constraining within a TableView/CollectionView cell
// silence warning: //        if let superclass: AnyClass? = self.superview?.superview?.superclass {
        if let superclass = self.superview?.superview?.superclass {
            if superclass === UICollectionViewCell.self || superclass === UITableViewCell.self {
                parent = self.superview!.superview!
            }
        }
        
        // Remove all existing Constraints
        self.removeAllConstraints()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        for constraint in constraints {
            switch constraint.0 {
            case .LeftToLeftRightToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: constraint.1.of, attribute: .left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: constraint.1.of, attribute: .right, multiplier: constraint.1.multiplier, constant: -constraint.1.offset))
            case .LeftToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: constraint.1.of, attribute: .left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: constraint.1.of, attribute: .right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .LeftToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: constraint.1.of, attribute: .centerX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: constraint.1.of, attribute: .right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: constraint.1.of, attribute: .left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .RightToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: constraint.1.of, attribute: .centerX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToTopBottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: constraint.1.of, attribute: .top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: constraint.1.of, attribute: .bottom, multiplier: constraint.1.multiplier, constant: -constraint.1.offset))
            case .TopToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: constraint.1.of, attribute: .top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: constraint.1.of, attribute: .bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .TopToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: constraint.1.of, attribute: .centerY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: constraint.1.of, attribute: .bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: constraint.1.of, attribute: .top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .BottomToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: constraint.1.of, attribute: .centerY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToCenterX:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: constraint.1.of, attribute: .centerX, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToLeft:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: constraint.1.of, attribute: .left, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterXToRight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: constraint.1.of, attribute: .right, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToCenterY:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: constraint.1.of, attribute: .centerY, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToTop:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: constraint.1.of, attribute: .top, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .CenterYToBottom:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: constraint.1.of, attribute: .bottom, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Width:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: constraint.1.of, attribute: .width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .IntrinsicContentWidth:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: constraint.1.of, attribute: .width, multiplier: constraint.1.multiplier, constant: (constraint.1.of as! UIView).intrinsicContentSize.width + constraint.1.offset))
            case .Height:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: constraint.1.of, attribute: .height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .IntrinsicContentHeight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: constraint.1.of, attribute: .height, multiplier: constraint.1.multiplier, constant: (constraint.1.of as! UIView).intrinsicContentSize.height + constraint.1.offset))
            case .WidthHeight:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: constraint.1.of, attribute: .width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: constraint.1.of, attribute: .height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .HeightWidth:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: constraint.1.of, attribute: .height, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: constraint.1.of, attribute: .width, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .Baseline:
                parent.addConstraint(NSLayoutConstraint(item: self, attribute: .lastBaseline, relatedBy: .equal, toItem: constraint.1.of, attribute: .lastBaseline, multiplier: constraint.1.multiplier, constant: constraint.1.offset))
            case .MaxWidth:
                print("Max Width is not supported")
                break
            case .MinWidth:
                print("Min Width is not supported")
                break
            case .MaxHeight:
                print("Max Height is not supported")
                break
            case .MinHeight:
                print("Min Height is not supported")
                break
            case .Default:
                break
            }
        }
    }
    
    @available(*, deprecated: 1.1, message: "Use addConstraints(APConstraint...) instead")
    public func constrainUsing(constraints: [Constraint: (of: AnyObject?, offset: CGFloat)]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1.of, CGFloat(1), constraint.1.offset)
        }
        constrainUsing(constraints: constraintDictionary)
    }
    
    @available(*, deprecated: 1.1, message: "Use addConstraints(APConstraint...) instead")
    public func constrainUsing(constraints: [Constraint : AnyObject?]) {
        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
        for constraint in constraints {
            constraintDictionary[constraint.0] = (constraint.1, 1.0, 0)
        }
        constrainUsing(constraints: constraintDictionary)
    }
    
    @available(*, deprecated: 1.1, message: "Use APStackView instead")
    public func spaceHorizontalWithInset(views: [UIView], inset: UIEdgeInsets) {
        assert(inset.right == inset.left, "Error! Left and Right insets must be equal")
        let parent = self
        parent.layoutIfNeeded()
        var totalWidthOfViews: CGFloat = 0
        for view in views as [UIView] {
            totalWidthOfViews += view.intrinsicContentSize.width
        }
        let padding = (parent.frame.width - totalWidthOfViews - (inset.right + inset.left)) / CGFloat(views.count)
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: parent.frame.height))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: view.intrinsicContentSize.width + padding))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: parent, attribute: .centerY, multiplier: 1.0, constant: inset.top))
            
            if view == views.first! {
                parent.addConstraint(NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parent, attribute: .left, multiplier: 1.0, constant: inset.left))
            } else {
                parent.addConstraint(NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: views[index - 1], attribute: .right, multiplier: 1.0, constant: 0))
            }
        }
    }
    
    // TODO: Finish this method another time, constraints for specific devices
    //    @available(*, unavailable=1.1, message="Unifinished method")
    //    public func constrainUsing(constraints constraints: [Constraint: (of: AnyObject?, offset: CGFloat)], forDevices devices: [DeviceTypes]) {
    //        let currentDeviceType = UIDevice.currentDevice().deviceType
    //        var currentDeviceSupported = false
    //        for device in devices {
    //            if currentDeviceType == device { currentDeviceSupported = true }
    //        }
    //        if !currentDeviceSupported { return }
    //        var constraintDictionary : [Constraint : (of: AnyObject?, multiplier: CGFloat, offset: CGFloat)] = [Constraint() : (nil, 0, 0)]
    //        for constraint in constraints {
    //            constraintDictionary[constraint.0] = (constraint.1.of, CGFloat(1), constraint.1.offset)
    //        }
    //        constrainUsing(constraints: constraintDictionary)
    //    }
}
