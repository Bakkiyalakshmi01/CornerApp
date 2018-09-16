//
//  SpeedView.swift
//  CornerApp
//
//  Created by Bakkiya on 14/09/2018.
//  Copyright © 2018 Bakkiya. All rights reserved.
//

import UIKit

class SpeedView: UIView {

    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var speedValue: UILabel!
    @IBOutlet weak var mph: UILabel!
    
    let nibName = "SpeedView"
    var contentView: UIView?
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
        
        backgroundColor = UIColor(red:0.09, green:0.09, blue:0.10, alpha:1.0)
        speed.textColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        speedValue.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        mph.textColor  = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        
        parseData.requestData { (data: WSBFvl_Round) in
            speedValue.text = String(data.avgSpeed)
        }
    }
    
}
