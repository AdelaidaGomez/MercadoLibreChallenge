//
//  NetworkingClass.swift
//  MercadoLibreChallenge
//
//  Created by Adelaida Gomez Vieco on 15/03/24.
//

import Foundation

class NetworkingClass: ObservableObject {
    
    func requestHttp<P: Encodable, T2xx: Decodable>(
        method: HTTPMethod,
        url: String,
        parameters: P?,
        responseType2xx: T2xx.Type,
        responseTypeNo2xx: ServidorResponseNo2xx.Type,
        completionHandler: @escaping (Result<T2xx, NetworkError>) -> Void
    ) {
        
        // We convert the endPoint, which is of type String, to the url variable, which is of type URL
        guard let url = URL(string: url) else {
            print("The url is not valid data")
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // We build the request object with which we will make the request
        var request = URLRequest(url: url)
        
        // We prepare the header
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // If the method is different from GET, we build the request body
        if method != .get {
            
            //  We build the body
            print("The body object that I am going to send with the request is: \(String(describing: parameters))")
            
            // Make sure that the request body parameter is not nill
            if let parameters = parameters  {
                
                do {
                    // Json encode the body object
                    let jsonData = try JSONEncoder().encode(parameters)
                    
                    let json = try? JSONSerialization.jsonObject(with: jsonData)
                    print("The body to send shown as a Json: \(String(describing: json))")
                    
                    // We prepare the body
                    request.httpBody = jsonData
                    
                } catch {
                    print("Could not Json encode the parameters received for the body of the request")
                    completionHandler(.failure(.encodingFailed))
                    return
                }
            } else {
                // we leave request.httpBody with no data, i.e. null. We will not send any bodysuit with the request
                print("The request body parameters are null, even though the request is with the method \(method) usually requires a non-null body. Anyway, we will send the request with a null body")
            }
            
        } else {
            // we leave request.httpBody without data, i.e. null
            print("The method is GET so no body is constructed or sent in the request")
        }
        
        // We define our task and make the request
        let session = URLSession.shared
        let tarea = session.dataTask(with: request) { (data, response, error) in
            
            // We check if an error occurred in the request
            if let error = error {
                print("Error. WE DID NOT RECEIVE ANY RESPONSE FROM THE SERVER")
                completionHandler(.failure(.errorInTask(error.localizedDescription)))
                return
            }
            
            // Since there were no errors, here we have a response from the server, which contains the metadata, including the status code and the header
            print("We have a response metadata from the server")
            
            // If response is not null and we can read it as data of type HTTPURLResponse, we do what is indicated within this if
            if let httpResponse = response as? HTTPURLResponse {
                print("status code in the header of the response: \(httpResponse.statusCode)")
                
                // If the status code of the response is not between 200 and 299, we do what is inside the if
                if !(200...299).contains(httpResponse.statusCode)  {
                    
                    print("status code is not 2xx")
                    
                    // Check if the server sent a body with the response different than 2xx
                    guard let data = data else {
                        // There is no body, which means that the server does not send a body when the response is different than 2xx
                        print("We do not receive a body from the server, it is empty")
                        completionHandler(.failure(.noBodyResponse))
                        return
                    }
                    
                    // Decode Body
                    do {
                        // We will decode using the previously defined data model ServerResponseNo2xx
                        let respuestaNo2xx = try JSONDecoder().decode(ServidorResponseNo2xx.self, from: data)
                        
                        print("The body No2xx response decoded within the function is: \(respuestaNo2xx)")
                        completionHandler(.failure(.statusCodeNo2xx(message: "The requested information is temporarily unavailable. Please try again later.")))
                        completionHandler(.failure(.statusCodeNo2xx(message: "Message: \(respuestaNo2xx.message)")))
                        
                    } catch {
                        print("Response body other than 2xx could not be decoded correctly")
                        
                        completionHandler(.failure(.statusCodeNo2xx(message: "The requested information is temporarily unavailable. Please try again later.")))
                    }
                    
                } else {
                    
                    print("The response status is from group 2xx")
                    
                    guard let data = data else {
                        // There is no body, it could be a bug or the response may not require body when it is 2xx
                        print("The server response does not have a body, it is empty, although the response status code is 2xx")
                        completionHandler(.failure(.noBodyResponse))
                        return
                    }

                    // Decode full body
                    do {
                        let respuesta2xx = try JSONDecoder().decode(responseType2xx.self, from: data)
                        
                        print("The status 2xx body response decoded within the function is: \(respuesta2xx)")
                        completionHandler(.success(respuesta2xx))
                        
                    } catch {
                        print("Status 2xx body response could not be decoded correctly")
                        completionHandler(.failure(.decodingFailed))
                    }
                }
                
                
            } else {
                // The program should never be here
                print("Even though we didn't receive an error, we also didn't receive a Response.")
                completionHandler(.failure(.otherError))
                fatalError()
            }
        }
        // Run task
        tarea.resume()
        
    }
}
