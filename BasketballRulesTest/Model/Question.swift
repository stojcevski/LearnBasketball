//
//  Question.swift
//  BasketballRulesTest
//
//  Created by Sasho Stojchevski on 1/22/19.
//  Copyright © 2019 Sasho Stojchevski. All rights reserved.
//

import Foundation

class Question: Codable {
    let questionText: String
    let answer: Int
    let interpretation: String
    let article: String
    let statementNo: String
    
    init(question: String, correctAnswer: Int, interpretation: String, article: String, statementNo: String) {
        self.questionText = question
        self.answer = correctAnswer
        self.interpretation = interpretation
        self.article = article
        self.statementNo = statementNo
    }
}

