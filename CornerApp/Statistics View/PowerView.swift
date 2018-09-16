//
//  PowerView.swift
//  CornerApp
//
//  Created by Bakkiya on 14/09/2018.
//  Copyright © 2018 Bakkiya. All rights reserved.
//

import UIKit

class PowerView: UIView {

    @IBOutlet weak var power: UILabel!
    @IBOutlet weak var powerValue: UILabel!
    @IBOutlet weak var g: UILabel!
    
    let nibName = "PowerView"
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
        power.textColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        powerValue.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        g.textColor  = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        
        parseData.requestData { (data: WSBFvl_Round) in
            powerValue.text = String(data.avgPower)
        }    }
}

