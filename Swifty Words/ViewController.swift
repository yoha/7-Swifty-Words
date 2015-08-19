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
                btn.addTarget(self, action: "letterTapped:", forControlEvents: UIControlEvents.TouchUpInside)
                self.letterButtons.append(btn)
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
        if let solutionPosition = self.solutions.indexOf(self.currentAnswerTextField.text!) {
            self.activatedButtons.removeAll()
            
            var splitClues = self.answersLabel.text!.componentsSeparatedByString("\n")
            splitClues[solutionPosition] = self.currentAnswerTextField.text!
            self.answersLabel.text = "\n".join(splitClues)
            
            self.currentAnswerTextField.text = ""
            ++self.gameScore
            
            if self.gameScore % 14 == 0 {
                let actionController = UIAlertController(title: "Congratulations!", message: "You've completed both levels!", preferredStyle: UIAlertControllerStyle.Alert)
                actionController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(actionController, animated: true, completion: nil)
                self.gameLevel = 1
                self.gameScore = 0
            }
            else if self.gameScore % 7 == 0 {
                let actionController = UIAlertController(title: "Easy as pie, right!", message: "Are you ready for the next level?", preferredStyle: UIAlertControllerStyle.Alert)
                actionController.addAction(UIAlertAction(title: "Let's go!!", style: UIAlertActionStyle.Default, handler: levelUp))
                self.presentViewController(actionController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func clearButtonTapped(sender: UIButton) {
        self.currentAnswerTextField.text = ""
        for button in self.activatedButtons {
            button.hidden = false
        }
        self.activatedButtons.removeAll()
    }
    
    // MARK: - Stored Properties
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = Array<String>()
    
    var gameScore: Int = 0 {
        didSet {
            self.scoreLabel.text = "Score: \(self.gameScore)"
        }
    }
    var gameLevel = 1
    
    // MARK: - Custom Methods
    
    func letterTapped(button: UIButton) {
        self.currentAnswerTextField.text! += button.titleLabel!.text!
        self.activatedButtons.append(button)
        button.hidden = true
    }
    
    func loadLevel() {
        var clueString = String()
        var solutionCharCount = ""
        var letterBits = [String]()
        var gameLevelContents: NSString!

        if let gameLevelFilePath = NSBundle.mainBundle().pathForResource("gameLevel\(self.gameLevel)", ofType: "txt") {
//            do {
//                gameLevelContents = try NSString(contentsOfFile: gameLevelFilePath, usedEncoding: nil)
//            }
//            catch {
//                print("Something awful has just happened.")
//            }
            gameLevelContents = try! NSString(contentsOfFile: gameLevelFilePath, usedEncoding: nil)
            var gameLevelContentsSeparated: [String] = gameLevelContents.componentsSeparatedByString("\n")
            gameLevelContentsSeparated.shuffle()
            
            for (index, eachGameLevelContentsSeparated) in gameLevelContentsSeparated.enumerate() {
                let answerAndClue = eachGameLevelContentsSeparated.componentsSeparatedByString(": ")
                let answer = answerAndClue[0]
                let clue = answerAndClue[1]
                clueString += "\(index + 1). \(clue)\n"
                
                let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                solutionCharCount += "\(solutionWord.characters.count) letters\n"
                self.solutions.append(solutionWord)
                
                letterBits += answer.componentsSeparatedByString("|")
            }
        }
        
        self.cluesLabel.text = clueString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        self.answersLabel.text = solutionCharCount.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        letterBits.shuffle()
        self.letterButtons.shuffle()
        if letterBits.count == self.letterButtons.count {
            for index in 0 ..< letterBits.count {
                self.letterButtons[index].setTitle(letterBits[index], forState: UIControlState.Normal)
            }
        }
    }
    
    func levelUp(action: UIAlertAction!) {
        ++self.gameLevel
        self.solutions.removeAll(keepCapacity: true)
        self.loadLevel()
        for button in self.letterButtons {
            button.hidden = false
        }
    }
    
    func resetGameLevel() {
        self.gameLevel = 1
    }
}

