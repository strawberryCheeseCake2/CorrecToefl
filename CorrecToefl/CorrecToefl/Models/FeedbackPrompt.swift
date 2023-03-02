//
//  QuestionForm.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import Foundation

struct FeedbackPrompt {
	
	var question: String
	var answer: String
	var feedbackPrompt: String
	
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
		
		self.feedbackPrompt = "Here's the TOEFL a pair of speaking question and answer. Question is '\(question)' and Answer is '\(answer)'. You must include a feedback about if the answer gets to of the question. Total feedback count must be at least 3 and each of them should start with ** and it should be provided in Korean. Your feedbacks are:"
	}
}
