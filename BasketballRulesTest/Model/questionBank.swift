//
//  questionBank.swift
//  BasketballRulesTest
//
//  Created by Sasho Stojchevski on 1/22/19.
//  Copyright © 2019 Sasho Stojchevski. All rights reserved.
//

import Foundation

class QuestionBank: Codable {
    let questions: [Question]
    
    init(questions: [Question]) {
        self.questions = questions
    }
}


