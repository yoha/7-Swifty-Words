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

        for subView in self.view.subviews {
            if subView.tag == 1001 {
                let btn = subView as! UIButton
                self.letterButtons.append(btn)
                btn.addTarget(self, action: "letterTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
        self.loadLevel()
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
    
    // MARK: - Stored Properties
    
    var letterButtons = [UIButton]()
    let activatedButtons = [UIButton]()
    var solutions = Array<String>()
    
    var gameScore = 0
    var gameLevel = 1
    
    // MARK: - Custom Methods
    
    func loadLevel() {
        var clueString = String()
        var solutionString = ""
        var letterBits = [String]()
        var gameLevelContents: NSString!

        if let gameLevelFilePath = NSBundle.mainBundle().pathForResource("gameLevel\(self.gameLevel)", ofType: "txt") {
            do {
                gameLevelContents = try NSString(contentsOfFile: gameLevelFilePath, usedEncoding: nil)
            }
            catch {
                print("Something awful has just happened.")
            }
            var gameLevelContentsSeparated: [String] = gameLevelContents.componentsSeparatedByString("\n")
            gameLevelContentsSeparated.shuffle()
            
            for (index, eachGameLevelContentsSeparated) in gameLevelContentsSeparated.enumerate() {
                let answerAndClue = eachGameLevelContentsSeparated.componentsSeparatedByString(": ")
                let answer = answerAndClue[0]
                let clue = answerAndClue[1]
                clueString += "\(index + 1). \(clue)\n"
                
                let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                solutionString += "\(solutionWord.characters.count) letters\n"
                self.solutions.append(solutionWord)
                
                let bits = answer.componentsSeparatedByString("|")
                letterBits += bits
            }
        }
        
        print("clueString: \(clueString)") // <--- to be erased
        print("solutionString: \(solutionString)") // <-- to be erased
        self.cluesLabel.text = clueString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.answersLabel.text = solutionString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        letterBits.shuffle()
        self.letterButtons.shuffle()
        if letterBits.count == self.letterButtons.count {
            for index in 0 ..< letterBits.count {
                self.letterButtons[index].setTitle(letterBits[index], forState: UIControlState.Normal)
            }
        }
    }
}

