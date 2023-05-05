//
//  Questions.swift
//  Quizz
//
//  Created by Мирас Асубай on 07.04.2023.
//

import Foundation

struct QuestionResponse: Codable {
    var results: [Question]
}

struct Question: Codable {
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}
