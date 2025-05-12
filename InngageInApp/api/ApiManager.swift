import Foundation

struct CustomField: Codable {
    let empresa: String
    let nome: String
}

struct SubscribeRequest: Codable {
    let registerSubscriberRequest: Subscribe
}

public class ApiManager {
    func sendSubscriptionRequest(subscribe: Subscribe) {
        let subscribeRequest = SubscribeRequest(registerSubscriberRequest: subscribe)
        
        print(subscribeRequest)

        guard let url = URL(string: "https://api.inngage.com.br/v1/subscription/") else { return }

        var urlRequest = URLRequest(url: url)

        // Verificação para compatibilidade com iOS 15 e inferior
        if #available(iOS 16.0, *) {
            urlRequest.httpMethod = "POST" // Usando o httpMethod para iOS 16+
        } else {
            // Solução alternativa para iOS 15 e inferiores
            _ = "POST".data(using: .utf8)
            urlRequest.setValue("POST", forHTTPHeaderField: "X-HTTP-Method-Override")
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(subscribeRequest)
            urlRequest.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("No data or no response")
                return
            }

            if response.statusCode == 200 {
                // Process the response data
                print("Success")
            } else {
                print("HTTP Status Code: \(response.statusCode)")
                if let responseBody = String(data: data, encoding: .utf8) {
                    print("Response Body: \(responseBody)")
                }
            }
        }

        task.resume()
    }
}
