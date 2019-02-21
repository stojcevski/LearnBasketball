//
//  ViewController.swift
//  BasketballRulesTest
//
//  Created by Sasho Stojchevski on 1/22/19.
//  Copyright © 2019 Sasho Stojchevski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
//variables
    
    var allQuestions : [Question] = []
    var randomQuestions : [Question] = []
    var questionNumber: Int = 0
    var score: Int = 0
    var mistakes: Int = 0
    var correctAnswer: Int = 0
    
//main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readJSONFromFile(fileName: "questions")
        getRandomQuestions(Questions: allQuestions)
        updateQuestion()
    }
    
//Read local JSON
    func readJSONFromFile(fileName: String)
    {
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let JSONquestions = try JSONDecoder().decode(QuestionBank.self, from: data)
                allQuestions = JSONquestions.questions
                
            } catch {
                // Handle error here
            }
        }
    }
    
//Get random 25 questions
    func getRandomQuestions(Questions: [Question]) {
        randomQuestions = []
        var i: Int = 25
        var array : [Int] = []
        while i > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(Questions.count)))
            if(!array.contains(randomIndex)) {
                array.append(randomIndex)
                randomQuestions.append(Questions[randomIndex])
                i-=1
            }
        }
    }
    
    
//Answer button pressed
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            print("correct")
            score += 1
            questionNumber += 1
            updateQuestion()
        }else {
            print("wrong")
            mistakes += 1
            
            let alert = UIAlertController (title: "Wrong call!", message: "\n\(randomQuestions[questionNumber].article) \n\nInterpretation: \(randomQuestions[questionNumber].interpretation)", preferredStyle: .alert)
            let continueTestAction = UIAlertAction (title: "Thanks. Got it.", style: .default, handler: {action in self.continueTest()})
            alert.addAction(continueTestAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
//Update view with next question
    func updateQuestion () {
        if questionNumber <= randomQuestions.count - 1 {
            questionLabel.text = randomQuestions[questionNumber].questionText
            correctAnswer = randomQuestions[questionNumber].answer
        } else {
            let alert = UIAlertController (title: "End of the test.", message: "Questions answered: \(questionNumber) \n Score: \(score) \n Mistakes: \(mistakes) \n", preferredStyle: .alert)
            let restartAction = UIAlertAction (title: "Start new Test", style: .default, handler: {action in self.restartTest()})
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
        updateUI()
    }
    
//Update question number, score and progress bar
    func updateUI () {
        if questionNumber <= randomQuestions.count - 1 {
            questionCounter.text = "\(questionNumber + 1)/25"
        }
        scoreLabel.text = "\(score)"
        if questionNumber > 0 {
            progressView.frame.size.width = (view.frame.size.width / CGFloat(randomQuestions.count)) * CGFloat(questionNumber)
        } else {
            progressView.frame.size.width = 0
        }
    }
    
//Set new test
    func restartTest () {
        score = 0
        mistakes = 0
        questionNumber = 0
        getRandomQuestions(Questions: allQuestions)
        updateQuestion()
    }
    
//Continue test
    func continueTest () {
        questionNumber += 1
        updateQuestion()
    }
}

