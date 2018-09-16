//
//  RightHandPunchesView.swift
//  CornerApp
//
//  Created by Karthik Lakshmanan on 14/09/2018.
//  Copyright © 2018 Bakkiya. All rights reserved.
//

import UIKit

class RightHandPunchesView: UIView {
    
    private let nibName = "RightHandPunchesView"
    private var contentView: UIView?
    private var frameWidth = 0
    private var onePart = 0.00
    private var cPunchValue = 0
    private var hPunchValue = 0
    private var uPunchValue = 0
    private var lineValue = ""
    private let parseData = ParseData()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView?.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.10, alpha:1.0)
        //To draw the bar chart
        
        parseData.requestData { (data: WSBFvl_Round) in
            
            frameWidth = (Int((contentView?.frame.width)!) - 40)
            onePart = Double(frameWidth) / Double(100)
            for id in data.punch_type_id {
                if(id == 3){
                    lineValue = "C"
                    cPunchValue = cPunchValue + 1
                } else if(id == 4){
                    lineValue = "H"
                    hPunchValue = hPunchValue + 1
                }else if(id == 5){
                    lineValue = "U"
                    uPunchValue = uPunchValue + 1
                }
            }
            if(lineValue == "C" || lineValue == "H" || lineValue == "U") {
                drawlines(lineNumber:1, punchVal: cPunchValue, linename: "C")
                drawlines(lineNumber:2, punchVal: hPunchValue, linename: "H")
                drawlines(lineNumber:3, punchVal: uPunchValue, linename: "U")
            }
        }
    }
    
    // To draw bar chart
    func drawLine(startpoint start:CGPoint, endpoint end:CGPoint, linecolor color: CGColor , linewidth widthline:CGFloat){
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = widthline
        contentView?.layer.addSublayer(shapeLayer)
    }
    
    func drawlines (lineNumber num : Int , punchVal val : Int, linename name : String){
        
        let startpoint = 10
        let distance = 50
        let start = CGPoint(x : 30, y : Int(num * distance) + startpoint)
        let end = CGPoint(x : (Int(onePart) * val * 2) + 30, y : Int(num * distance) + startpoint)
        
        //Punch Type Name label settings
        let punchType = UILabel()
        punchType.frame = CGRect(x: start.x - 20, y: start.y - 7, width: 20, height: 15)
        punchType.font = punchType.font.withSize(15)
        punchType.textColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        punchType.text = name
        contentView?.addSubview(punchType)
        
        // Punch type value settings
        let value = UILabel()
        value.frame = CGRect(x: 140, y: start.y - 8, width: 20, height: 15)
        value.font = value.font.withSize(15)
        value.text = String(val)
        value.textColor = UIColor(red:0.10, green:0.60, blue:0.90, alpha:1.0)
        contentView?.addSubview(value)
        
        //Setting color to draw line
        drawLine(startpoint: start, endpoint: end, linecolor: UIColor(red:0.10, green:0.60, blue:0.90, alpha:1.0).cgColor, linewidth: 4)
        
        let verticalStart = CGPoint(x : 30 , y : 59)
        let verticalEnd = CGPoint(x: 30 , y : 162)
        //Setting color to draw line
        drawLine(startpoint: verticalStart, endpoint: verticalEnd, linecolor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0).cgColor, linewidth: 1.0)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        contentView?.setNeedsDisplay()
        
    }
    
}


