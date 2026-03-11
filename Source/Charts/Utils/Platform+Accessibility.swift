//
//  Platform+Accessibility.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import UIKit

internal func accessibilityPostLayoutChangedNotification(withElement element: Any? = nil)
{
    UIAccessibility.post(notification: .layoutChanged, argument: element)
}

internal func accessibilityPostScreenChangedNotification(withElement element: Any? = nil)
{
    UIAccessibility.post(notification: .screenChanged, argument: element)
}

/// A simple abstraction over UIAccessibilityElement and NSAccessibilityElement.
open class NSUIAccessibilityElement: UIAccessibilityElement
{
    private weak var containerView: UIView?

    final var isHeader: Bool = false
    {
        didSet
        {
            accessibilityTraits = isHeader ? .header : .none
        }
    }

    final var isSelected: Bool = false
        {
        didSet
        {
            accessibilityTraits = isSelected ? .selected : .none
        }
    }

    override public init(accessibilityContainer container: Any)
    {
        // We can force unwrap since all chart views are subclasses of UIView
        containerView = container as? UIView
        super.init(accessibilityContainer: container)
    }

    override open var accessibilityFrame: CGRect
    {
        get
        {
            return super.accessibilityFrame
        }

        set
        {
            guard let containerView = containerView else { return }
            super.accessibilityFrame = containerView.convert(newValue, to: UIScreen.main.coordinateSpace)
        }
    }
}

extension ChartViewBase
{
    // MARK: - Accessibility
    
    /// An array of accessibilityElements that is used to implement UIAccessibilityContainer internally.
    /// Subclasses **MUST** override this with an array of such elements.
    @objc open func accessibilityChildren() -> [Any]?
    {
        return renderer?.accessibleChartElements
    }

    public final override var isAccessibilityElement: Bool
    {
        get { return false } // Return false here, so we can make individual elements accessible
        set { }
    }

    open override func accessibilityElementCount() -> Int
    {
        return accessibilityChildren()?.count ?? 0
    }

    open override func accessibilityElement(at index: Int) -> Any?
    {
        return accessibilityChildren()?[index]
    }

    open override func index(ofAccessibilityElement element: Any) -> Int
    {
        guard let axElement = element as? NSUIAccessibilityElement else { return NSNotFound }
        return (accessibilityChildren() as? [NSUIAccessibilityElement])?.firstIndex(of: axElement) ?? NSNotFound
    }
}

extension MarkerView
{
    // MARK: - Accessibility
    
    /// An array of accessibilityElements that is used to implement UIAccessibilityContainer internally.
    /// Subclasses **MUST** override this with an array of such elements.
    @objc open func accessibilityChildren() -> [Any]?
    {
        return nil
    }

    public final override var isAccessibilityElement: Bool
    {
        get { return false } // Return false here, so we can make individual elements accessible
        set { }
    }

    open override func accessibilityElementCount() -> Int
    {
        return accessibilityChildren()?.count ?? 0
    }

    open override func accessibilityElement(at index: Int) -> Any?
    {
        return accessibilityChildren()?[index]
    }

    open override func index(ofAccessibilityElement element: Any) -> Int
    {
        guard let axElement = element as? NSUIAccessibilityElement else { return NSNotFound }
        return (accessibilityChildren() as? [NSUIAccessibilityElement])?.firstIndex(of: axElement) ?? NSNotFound
    }
}
