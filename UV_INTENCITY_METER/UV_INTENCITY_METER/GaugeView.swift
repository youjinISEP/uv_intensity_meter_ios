//
//  GaugeView.swift
//  UV_INTENCITY_METER
//
//  Created by youjin on 29/09/2019.
//  Copyright © 2019 youjin. All rights reserved.
//

import UIKit

class GaugeView: UIView{
    
    var outerBezelColor = UIColor.black
    var outerBezelWidth: CGFloat = 0
    
    var innerBezelColor = UIColor.black
    var innerBezelWidth: CGFloat = 0
    
    var insideColor = UIColor.black
    
    func drawBackground(in rect: CGRect, context ctx: CGContext){
        outerBezelColor.set()
        ctx.fillEllipse(in: rect)
        
        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        innerBezelColor.set()
        ctx.fillEllipse(in: innerBezelRect)
        
        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        insideColor.set()
        ctx.fillEllipse(in: insideRect)
    }
    
    override func draw(_ rect: CGRect){
        guard let ctx = UIGraphicsGetCurrentContext() else {return}
        drawBackground(in: rect, context: ctx)
        drawSegments(in: rect, context: ctx)
        drawTicks(in: rect, context: ctx)
        drawCenterDisc(in: rect, context: ctx)
        
    }
    
    //adding gauge segments
    var segmentWidth: CGFloat = 35
    var segmentColors = [UIColor.darkGray]
    
    var totalAngle: CGFloat = 270
    var rotation: CGFloat = -135
    
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    func drawSegments(in rect: CGRect, context ctx: CGContext) {
        // 1: Save the current drawing configuration
        ctx.saveGState()
        
        // 2: Move to the center of our drawing rectangle and rotate so that we're pointing at the start of the first segment
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
        
        // 3: Set up the user's line width
        ctx.setLineWidth(segmentWidth)
        
        // 4: Calculate the size of each segment in the total gauge
        let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))
        
        // 5: Calculate how wide the segment arcs should be
        let segmentRadius = (((rect.width - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth
        
        // 6: Draw each segment
        for (index, segment) in segmentColors.enumerated() {
            // figure out where the segment starts in our arc
            let start = CGFloat(index) * segmentAngle
            
            // activate its color
            segment.set()
            
            // add a path for the segment
            ctx.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + segmentAngle, clockwise: false)
            
            // and stroke it using the activated color
            ctx.drawPath(using: .stroke)
        }
        
        // 7: Reset the graphics state
        ctx.restoreGState()
    }
    
    //adding tick lines
    var majorTickColor = UIColor.darkGray
    var majorTickWidth: CGFloat = 0
    var majorTickLength: CGFloat = 25
    
    var minorTickColor = UIColor.white
    var minorTickWidth: CGFloat = 3
    var minorTickLength: CGFloat = 10
    var minorTickCount = 8
    
    var numberTickColor = UIColor.white
    
    func drawTicks(in rect: CGRect, context ctx: CGContext) {
        // save our clean graphics state
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
        
        let segmentAngle = deg2rad(totalAngle / CGFloat(segmentColors.count))
        
        let segmentRadius = (((rect.width - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth
        
        // save the graphics state where we've moved to the center and rotated towards the start of the first segment
        ctx.saveGState()
        
        // draw major ticks
        ctx.setLineWidth(majorTickWidth)
        majorTickColor.set()
        
        let majorEnd = segmentRadius + (segmentWidth/2)
        let majorStart = majorEnd - majorTickLength
        
        for _ in 0 ... segmentColors.count {
            ctx.move(to: CGPoint(x: majorStart, y: 0))
            ctx.addLine(to: CGPoint(x: majorEnd, y: 0))
            ctx.drawPath(using: .stroke)
            ctx.rotate(by: segmentAngle)
        }
        
        // go back to the state we had before we drew the major ticks
        ctx.restoreGState()
        
        // save it again, because we're about to draw the minor ticks
        ctx.saveGState()
        
        // draw minor ticks
        ctx.setLineWidth(minorTickWidth)
        minorTickColor.set()
        
        let minorEnd = segmentRadius + (segmentWidth / 2)
        let minorStart = minorEnd - minorTickLength
        
        let minorTickSize = segmentAngle / CGFloat(minorTickCount + 1)
        
        for _ in 0 ..< segmentColors.count {
            ctx.rotate(by: minorTickSize)
            
            for _ in 0 ..< minorTickCount {
                ctx.move(to: CGPoint(x: minorStart, y: 0))
                ctx.addLine(to: CGPoint(x: minorEnd, y: 0))
                ctx.drawPath(using: .stroke)
                ctx.rotate(by: minorTickSize)
            }
        }
        
        // go back to the graphics state where we've moved to the center and rotated towards the start of the first segment
        ctx.restoreGState()
        
        
       
        // go back to the original graphics state
        ctx.restoreGState()
    }
    
    //showing a value
    var outerCenterDiscColor = UIColor(white: 0.9, alpha: 1)
    var outerCenterDiscWidth: CGFloat = 35
    var innerCenterDiscColor = UIColor(white: 0.7, alpha: 1)
    var innerCenterDiscWidth: CGFloat = 25
    
    func drawCenterDisc(in rect: CGRect, context ctx: CGContext) {
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)
        
        let outerCenterRect = CGRect(x: -outerCenterDiscWidth / 2, y: -outerCenterDiscWidth / 2, width: outerCenterDiscWidth, height: outerCenterDiscWidth)
        outerCenterDiscColor.set()
        ctx.fillEllipse(in: outerCenterRect)
        
        let innerCenterRect = CGRect(x: -innerCenterDiscWidth / 2, y: -innerCenterDiscWidth / 2, width: innerCenterDiscWidth, height: innerCenterDiscWidth)
        innerCenterDiscColor.set()
        ctx.fillEllipse(in: innerCenterRect)
        ctx.restoreGState()
        
    }
    
    var needleColor = UIColor.red
    var needleWidth: CGFloat = 4
    let needle = UIView()
    
    func setUp() {
        
     
        
        needle.backgroundColor = needleColor
        needle.translatesAutoresizingMaskIntoConstraints = false
        
        // make the needle a third of our height
        needle.bounds = CGRect(x: 0, y: 0, width: needleWidth, height: bounds.height / 3)
        
        // align it so that it is positioned and rotated from the bottom center
        needle.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        // now center the needle over our center point
        needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
        addSubview(needle)
        
        valueLabel.font = valueFont
        valueLabel.text = "0 mW/cm2"
        valueLabel.textColor = valueColor
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
            ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    let valueLabel = UILabel()
    var valueFont = UIFont.systemFont(ofSize: 40)
    var valueColor = UIColor.cyan
    let valueUnit = "mW/cm2"
    
    var value: Double = 0.0 {
        didSet {
            // update the value label to show the exact number
            valueLabel.text = String(value)
            
            // figure out where the needle is, between 0 and 1
            let needlePosition = CGFloat(value) / 45
            
            // create a lerp from the start angle (rotation) through to the end angle (rotation + totalAngle)
            let lerpFrom = rotation
            let lerpTo = rotation + totalAngle
            
            // lerp from the start to the end position, based on the needle's position
            let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
            needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
