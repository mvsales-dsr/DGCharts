//
//  ChartDataEntry.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import UIKit

open class ChartDataEntry: ChartDataEntryBase
{
    /// the x value
    open var x = 0.0
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    public init(x: Double, y: Double)
    {
        super.init(y: y)
        self.x = x
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - data: Space for additional data this Entry represents.
    
    public convenience init(x: Double, y: Double, data: Any?)
    {
        self.init(x: x, y: y)
        self.data = data
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - icon: icon image
    
    public convenience init(x: Double, y: Double, icon: UIImage?)
    {
        self.init(x: x, y: y)
        self.icon = icon
    }
    
    /// An Entry represents one single entry in the chart.
    ///
    /// - Parameters:
    ///   - x: the x value
    ///   - y: the y value (the actual value of the entry)
    ///   - icon: icon image
    ///   - data: Space for additional data this Entry represents.
    
    public convenience init(x: Double, y: Double, icon: UIImage?, data: Any?)
    {
        self.init(x: x, y: y)
        self.icon = icon
        self.data = data
    }
        
    // MARK: NSObject
    
    open override var description: String
    {
        return "ChartDataEntry, x: \(x), y \(y)"
    }
    
    public static func == (lhs: ChartDataEntry, rhs: ChartDataEntry) -> Bool {
        if lhs === rhs {
            return true
        }
        return lhs.y == rhs.y && lhs.x == rhs.x
    }
}
