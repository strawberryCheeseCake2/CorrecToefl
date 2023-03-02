//
//  CorrectionManager.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import Foundation
import Alamofire

class PromptManger {
	
	private let completionURL = "https://api.openai.com/v1/completions"
	
	func getFeedback(question: String, answer: String, completionHandler: @escaping (String) -> Void) {
		
		let parameters: [String: Any] = [
//			"model": "ada",
			"model": "text-davinci-003",
			"prompt": "\(FeedbackPrompt(question: question, answer: answer).feedbackPrompt)",
			"temperature": 0.3,
			"max_tokens": 500
//			"max_tokens": 1
		]
		
		
		performRequest(params: parameters, completionHandler: completionHandler)
		
	} // func getFeedback()
	
	func getEndOfQuestion(ocrResult: String, completionHandler: @escaping (String) -> Void) {
		let parameters: [String: Any] = [
			"model": "text-davinci-003",
			"prompt": "Here's a pair of question and answer for toefl speaking question. Tell me the last sentence of the question.\(ocrResult). The last sentence of the question is:",
			"temperature": 0.3,
			"max_tokens": 10
		]
		
		performRequest(params: parameters, completionHandler: completionHandler)
	} // func getLastSentenceOfQuestion
	
	private func performRequest(params: [String: Any], completionHandler: @escaping (String) -> Void) {
		let headers: HTTPHeaders = [
			"Content-Type": "application/json",
			"Authorization": "Bearer \(APIKeys.openAI)"
		]
		
		AF.request(completionURL,
				   method: .post,
				   parameters: params,
				   encoding: JSONEncoding.default,
				   headers: headers
		).responseDecodable(of: CompletionData.self) { response in
			switch response.result {
			case .success(let data):
				print(data)
				guard let answer = data.choices?.first?.text else { return }
				
				completionHandler(answer)
				
			case .failure(let error):
				print(error)
				
			} // switch
		}
	}
	
		
	
	
}

// MARK: Processing Results
extension PromptManger {
	
	func parseFeedbackResult(_ prompt: String) -> [Feedback] {
		let trimedPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
		
		var feedbacks = [Feedback]()
		
		print(trimedPrompt)
		let splitedByLinebreak = trimedPrompt.split(separator: "\n").map { (value) -> String in
			let trimed = String(value).trimmingCharacters(in: .whitespacesAndNewlines)
			return trimed
		}
		
		for component in splitedByLinebreak {
			
//			var type: FeedbackType = .check
			
			var markRemoved: String = component
			
			if component.hasPrefix("**") {
//				type = .check
				markRemoved = component.replacingOccurrences(of: "**", with: "")
			} else if component.hasPrefix("##") {
//				type = .cross
				markRemoved = component.replacingOccurrences(of: "##", with: "")
			}
			
			
			let feedback = Feedback(feedbackString: markRemoved)
			feedbacks.append(feedback)
		}
		
		return feedbacks
	}
	
	func getSeperatedPrompt(text: String) -> FeedbackPrompt {
		
		// Seperate text by sentence
		var sentences: [String] = []
		text.enumerateSubstrings(in: text.startIndex..., options: [.localized, .bySentences]) { (tag, _, _, _) in
			sentences.append(tag ?? "")
		}
		
		// Get first two and process it as question
		let question = sentences[0] + sentences[1]
		var answer: String = ""
		
		for chunk in sentences[2...] {
			answer += chunk
		}
		
		let prompt = FeedbackPrompt(question: question, answer: answer)
		
		return prompt
	}
	

}

