//
//  CorrectionManager.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import Foundation
import Alamofire

class PromptManger {
	
	func getFeedback(question: String, answer: String, completionHandler: @escaping (String) -> Void) {
		let completionURL = "https://api.openai.com/v1/completions"
		
		let headers: HTTPHeaders = [
			"Content-Type": "application/json",
			"Authorization": "Bearer \(APIKeys.openAI)"
		]
		
		let parameters: [String: Any] = [
//			"model": "ada",
			"model": "text-davinci-003",
			"prompt": "\(Prompt(question: question, answer: answer).rawValue)",
			"temperature": 0.3,
			"max_tokens": 100
//			"max_tokens": 10
		]
		
		AF.request(completionURL,
				   method: .post,
				   parameters: parameters,
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
		
		
	} // func getFeedback()
	
		
	func parsePrompt(_ prompt: String) -> [Feedback] {
		let trimedPrompt = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
		
		var feedbacks = [Feedback]()
		
		print(trimedPrompt)
		let splitedByLinebreak = trimedPrompt.split(separator: "\n").map { (value) -> String in
			let trimed = String(value).trimmingCharacters(in: .whitespacesAndNewlines)
			return trimed
		}
		
		for component in splitedByLinebreak {
			
			var type: FeedbackType = .check
			
			var markRemoved: String = component
			
			if component.hasPrefix("**") {
				type = .check
				markRemoved = component.replacingOccurrences(of: "**", with: "")
			} else if component.hasPrefix("##") {
				type = .cross
				markRemoved = component.replacingOccurrences(of: "##", with: "")
			}
			
			
			
			let feedback = Feedback(feedbackString: markRemoved)
			feedbacks.append(feedback)
		}
		
//		print("-----")
//		print(splitedByLinebreak)
		
		
			
		
		return feedbacks
	}
	
	
}

//		var sentences: [String] = []
//		trimedPrompt.enumerateSubstrings(in: trimedPrompt.startIndex..., options: [.localized, .bySentences]) { (tag, _, _, _) in
//			sentences.append(tag ?? "")
//		}

