//
//  ViewController.swift
//  Swifty Words
//
//  Created by Yohannes Wijaya on 8/15/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswerTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - IBAction Properties
    
    @IBAction func submitButtonTapped(sender: UIButton) {
    }
    
    @IBAction func clearButtonTapped(sender: UIButton) {
    }

}

