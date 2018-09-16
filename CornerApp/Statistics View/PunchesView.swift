//
//  PunchesView.swift
//  CornerApp
//
//  Created by Bakkiya on 14/09/2018.
//  Copyright © 2018 Bakkiya. All rights reserved.
//

import UIKit

class PunchesView: UIView {

    @IBOutlet weak var punches: UILabel!
    @IBOutlet weak var punchesValue: UILabel!
    
    let nibName = "PunchesView"
    var contentView: UIView?
    var wsbfvl_Round = WSBFvl_Round()
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
        punches.textColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
        punchesValue.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        parseData.requestData { (data: WSBFvl_Round) in
            punchesValue.text = String(data.totalPunches)
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        contentView?.setNeedsDisplay()
    }
    
}
