//
//  APICaller.swift
//  Quizz
//
//  Created by Мирас Асубай on 07.04.2023.
//

import Foundation

struct Constants {
    static let baseURL = "https://opentdb.com/api.php?amount=10&type=multiple&category="
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()

    func getRandomQuestions(category id: String,completion: @escaping (Result<[Question], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(id)") else {
            return }
        
        let task = URLSession.shared.dataTask(with:  URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(QuestionResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
    
}

