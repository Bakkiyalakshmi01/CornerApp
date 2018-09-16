//
//  ViewController.swift
//  CornerApp
//
//  Created by Karthik Lakshmanan on 14/09/2018.
//  Copyright © 2018 Bakkiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var typeGraphView: UIView!
    @IBOutlet weak var typeBreakdown: UILabel!
    @IBOutlet weak var chartView: UIView!
    
    override func viewDidLoad() {
        
        // Setting background colors
        self.view.backgroundColor = UIColor(red:0.00, green:0.00, blue:0.00, alpha:1.0)
        self.typeGraphView.backgroundColor =  UIColor(red:0.09, green:0.09, blue:0.10, alpha:1.0)
        self.chartView.backgroundColor = UIColor(red:0.09, green:0.09, blue:0.10, alpha:1.0)
        self.typeBreakdown.textColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

