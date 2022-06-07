//
//  TibberVM.swift
//  TibberProject
//
//  Created by Amir Nilsson on 2022-06-04.
//

import Foundation

//custom enum for descriptive errors
enum CustomErrorHandler {
    case jsonDecoderError
    case urlSessionError
    case responseDecoderError
    case noError
    
    var description:String {
        switch self {
        case .jsonDecoderError:
            return "Error encoding the query"
        case .urlSessionError:
            return "Error trying to pull the data in the URLSession"
        case .responseDecoderError:
            return "Error trying to decode fetched data"
        default:
            return ""
        }
    }
}


class TiberVM: ObservableObject {
    
    @Published var dataset:TibberModel?
    @Published var errorHandler:CustomErrorHandler = .noError
    @Published var errorUp:Bool = false
    
    
    init() {
        loadTibberData()
    }
    
    // function for setting up the POST request
    func request() -> URLRequest? {
        var request:URLRequest?
        
        let url = URL(string: "https://app.tibber.com/v4/gql")
        let query:Query = Query(query: "query{assignmentData{title,description,longDescription,connected,storeUrl,imageUrl}}")
        
        if let url = url {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            var data:Data?
//            try to encode the query for the post request
            do {
                data = try encoder.encode(query)
                
            } catch let error {
                print("error encoding the query : \(error.localizedDescription)")
                errorHandler = .jsonDecoderError
                self.errorUp = true
                return request
            }
            
            request = URLRequest(url: url)
            request?.httpMethod = "POST"
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                request?.httpBody = data
            }
        }
        
        
        return request
    }
    
    
    //load data and put them in the published var
    func loadTibberData() {
        guard let request = request() else {return}
        
        URLSession.shared.dataTask(with: request) {[weak self] data, _, error in
            // if there is an error set it and activate the alert dialog
            if error != nil {
                self?.errorHandler = .urlSessionError
                self?.errorUp = true
            }
            
            if let data = data {
                // we have data so we try to decode it into the observed variable and put in on main thread
                DispatchQueue.main.async {
                    do {
                        self?.dataset = try JSONDecoder().decode(TibberModel.self, from: data)
                    } catch {
                        self?.errorHandler = .responseDecoderError
                        self?.errorUp = true
                        print("error decoding data...")
                    }
                }
                
            }
        }.resume()
    }
}
