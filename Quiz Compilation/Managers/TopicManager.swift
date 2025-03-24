//
//  TopicManager.swift
//  Quiz Compilation
//
//  Created by Мирсаит Сабирзянов on 14.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

final class TopicManager {
    
    var defaultTopics: [Topic] = []
    
    init() {
        self.defaultTopics = [
            Topic(name: "Football Questions", description: "Test your knowledge about football, its history, players, and major tournaments.", image: "https://surl.li/bwvqvj", questions: footballQuestions),
            Topic(name: "Math Questions", description: "Challenge yourself with various math problems ranging from basic arithmetic to advanced concepts.", image: "https://surl.li/cachoj", questions: mathQuestions),
            Topic(name: "Country Questions", description: "Explore interesting facts and trivia about countries around the world.", image: "https://surl.li/zsixwe", questions: countryQuestions),
        ]
    }
    
    func loadTopics() async -> [Topic] {
        guard let user = Auth.auth().currentUser else { return defaultTopics }
        
        let userId = user.uid
        var topics: [Topic] = []
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(userId).collection("topics").getDocuments()
            
            topics = snapshot.documents.compactMap { document in
                let data = document.data()
                
                guard let name = data["name"] as? String,
                      let description = data["description"] as? String,
                      let image = data["image"] as? String,
                      let questionsData = data["questions"] as? [[String: Any]] else { return nil }
                
                let questions = questionsData.compactMap { qData -> Question? in
                    guard let text = qData["text"] as? String,
                          let answer = qData["answer"] as? String,
                          let variants = qData["variants"] as? [String] else { return nil }
                    
                    let hint = qData["hint"] as? String
                    return Question(text: text, hint: hint, answer: answer, variants: variants)
                }
                
                return Topic(name: name, description: description, image: image, questions: questions)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return defaultTopics + topics
    }
    
    let footballQuestions: [Question] = [
        Question(text: "Who won the FIFA World Cup in 2018?", hint: nil, answer: "France", variants: ["Germany", "France", "Brazil", "Argentina"]),
        Question(text: "Which player scored the most goals in La Liga history?", hint: nil, answer: "Lionel Messi", variants: ["Cristiano Ronaldo", "Lionel Messi", "Raul", "Ronaldinho"]),
        Question(text: "Which club has the most UEFA Champions League titles?", hint: nil, answer: "Real Madrid", variants: ["Barcelona", "Bayern Munich", "Real Madrid", "AC Milan"]),
        Question(text: "Who is the all-time top scorer for the Brazil national team?", hint: nil, answer: "Ronaldo", variants: ["Pelé", "Ronaldo", "Neymar", "Romário"]),
        Question(text: "In what year was the first FIFA World Cup held?", hint: nil, answer: "1930", variants: ["1920", "1930", "1940", "1950"]),
        Question(text: "What is the home stadium of Manchester United?", hint: nil, answer: "Old Trafford", variants: ["Etihad Stadium", "Anfield", "Old Trafford", "Wembley"]),
        Question(text: "Who won the Ballon d'Or in 2021?", hint: nil, answer: "Lionel Messi", variants: ["Cristiano Ronaldo", "Lionel Messi", "Robert Lewandowski", "Kylian Mbappé"]),
        Question(text: "Which player is known as the 'King of Football'?", hint: nil, answer: "Pelé", variants: ["Maradona", "Pelé", "Messi", "Ronaldo"]),
        Question(text: "What is the main competition for European national teams?", hint: nil, answer: "European Championship (Euro)", variants: ["World Cup", "European Championship (Euro)", "Copa America", "AFCON"]),
        Question(text: "Who is the captain of the Italy national team?", hint: nil, answer: "Giorgio Chiellini", variants: ["Giorgio Chiellini", "Leonardo Bonucci", "Marco Verratti", "Andrea Pirlo"]),
        Question(text: "Which club won the Champions League in 2020?", hint: nil, answer: "Bayern Munich", variants: ["Manchester City", "Liverpool", "Bayern Munich", "Chelsea"]),
        Question(text: "Which player is considered the best goalkeeper in football history?", hint: nil, answer: "Lev Yashin", variants: ["Gianluigi Buffon", "Lev Yashin", "Peter Schmeichel", "Iker Casillas"]),
        Question(text: "What rule was introduced by FIFA in 1997 regarding offside?", hint: nil, answer: "The 'two players' rule", variants: ["The 'last player' rule", "The 'two players' rule", "The 'goalkeeper' rule", "The 'corner' rule"]),
        Question(text: "What stadium has the largest capacity in the world?", hint: nil, answer: "Rungrado 1st of May Stadium", variants: ["Camp Nou", "Wembley", "Rungrado 1st of May Stadium", "FNB Stadium"]),
        Question(text: "Which player scored the fastest goal in World Cup history?", hint: nil, answer: "Hakan Şükür", variants: ["Cristiano Ronaldo", "Hakan Şükür", "Lionel Messi", "David Beckham"]),
        Question(text: "What is the main rival club of Liverpool?", hint: nil, answer: "Everton", variants: ["Manchester United", "Everton", "Chelsea", "Arsenal"]),
        Question(text: "Which player scored 100 goals in the Champions League by 2021?", hint: nil, answer: "Cristiano Ronaldo", variants: ["Lionel Messi", "Cristiano Ronaldo", "Raúl", "Robert Lewandowski"]),
        Question(text: "In what year was the FIFA World Cup held in Russia?", hint: nil, answer: "2018", variants: ["2014", "2018", "2022", "2010"]),
        Question(text: "Which football club was founded in 1903 in Madrid?", hint: nil, answer: "Atletico Madrid", variants: ["Real Madrid", "Atletico Madrid", "Barcelona", "Sevilla"]),
        Question(text: "Which player is considered the symbol of FC Barcelona?", hint: nil, answer: "Lionel Messi", variants: ["Ronaldinho", "Xavi", "Andrés Iniesta", "Lionel Messi"])
    ]
    
    let mathQuestions: [Question] = [
        Question(text: "What is the value of π (pi) to two decimal places?", hint: nil, answer: "3.14", variants: ["3.14", "3.15", "3.13", "3.16"]),
        Question(text: "What is the area of a circle with a radius of 5 cm?", hint: nil, answer: "78.54 cm²", variants: ["78.54 cm²", "31.42 cm²", "25.00 cm²", "50.24 cm²"]),
        Question(text: "What is the square root of 64?", hint: nil, answer: "8", variants: ["6", "7", "8", "9"]),
        Question(text: "How many angles does a triangle have?", hint: nil, answer: "3", variants: ["2", "3", "4", "5"]),
        Question(text: "What is 2 raised to the power of 10?", hint: nil, answer: "1024", variants: ["512", "1024", "2048", "256"]),
        Question(text: "What is 100 divided by 4?", hint: nil, answer: "25", variants: ["20", "25", "30", "35"]),
        Question(text: "How many degrees are in a circle?", hint: nil, answer: "360", variants: ["180", "270", "360", "400"]),
        Question(text: "What is the perimeter of a square with a side length of 4 cm?", hint: nil, answer: "16 cm", variants: ["12 cm", "16 cm", "20 cm", "24 cm"]),
        Question(text: "Which number is prime: 9, 11, or 15?", hint: nil, answer: "11", variants: ["9", "11", "15", "21"]),
        Question(text: "How many seconds are in an hour?", hint: nil, answer: "3600", variants: ["1800", "3600", "7200", "360"]),
    ]
    
    let countryQuestions: [Question] = [
        Question(text: "Which country is the largest by area?", hint: nil, answer: "Russia", variants: ["Canada", "USA", "China", "Russia"]),
        Question(text: "Which country has the largest population?", hint: nil, answer: "China", variants: ["India", "USA", "China", "Indonesia"]),
        Question(text: "What is the capital city of France?", hint: nil, answer: "Paris", variants: ["Berlin", "Madrid", "Rome", "Paris"]),
        Question(text: "Which ocean borders Australia?", hint: nil, answer: "Pacific Ocean", variants: ["Atlantic Ocean", "Indian Ocean", "Pacific Ocean", "Arctic Ocean"]),
        Question(text: "In which country is Niagara Falls located?", hint: nil, answer: "Canada and USA", variants: ["Canada", "USA", "Canada and USA", "Mexico"]),
        Question(text: "What is the official language of Brazil?", hint: nil, answer: "Portuguese", variants: ["Spanish", "Portuguese", "English", "French"]),
        Question(text: "Which continent is home to the ostrich?", hint: nil, answer: "Africa", variants: ["Asia", "Africa", "Australia", "America"]),
        Question(text: "What is the capital city of Japan?", hint: nil, answer: "Tokyo", variants: ["Beijing", "Seoul", "Tokyo", "Bangkok"]),
        Question(text: "Which country has a flag with a red square in the top left corner?", hint: nil, answer: "Canada", variants: ["Canada", "Japan", "Switzerland", "China"]),
        Question(text: "What is the capital city of Italy?", hint: nil, answer: "Rome", variants: ["Venice", "Rome", "Milan", "Florence"]),
        Question(text: "In which country is the famous Taj Mahal located?", hint: nil, answer: "India", variants: ["India", "Pakistan", "Bangladesh", "Nepal"]),
        Question(text: "Which continent has the smallest area?", hint: nil, answer: "Australia", variants: ["Asia", "Africa", "North America", "Australia"]),
        Question(text: "What is the capital city of Egypt?", hint: nil, answer: "Cairo", variants: ["Cairo", "Alexandria", "Giza", "Luxor"]),
        Question(text: "What currency is used in Japan?", hint: nil, answer: "Yen", variants: ["Yuan", "Yen", "Won", "Dollar"]),
        Question(text: "Which island is part of Greece?", hint: nil, answer: "Crete", variants: ["Santorini", "Crete", "Rhodes", "Cyprus"]),
        Question(text: "In which country is Mount Everest located?", hint: nil, answer: "Nepal", variants: ["Nepal", "India", "Tibet", "Bhutan"]),
        Question(text: "Which language is official in Switzerland?", hint: nil, answer: "German, French, Italian, and Romansh", variants: ["German", "French", "Italian", "German, French, Italian, and Romansh"]),
        Question(text: "In which country is the famous Angkor Wat temple located?", hint: nil, answer: "Cambodia", variants: ["Thailand", "Vietnam", "Cambodia", "Laos"]),
        Question(text: "Which ocean is to the east of Africa?", hint: nil, answer: "Indian Ocean", variants: ["Atlantic Ocean", "Indian Ocean", "Pacific Ocean", "Arctic Ocean"]),
        Question(text: "What is the capital city of Turkey?", hint: nil, answer: "Ankara", variants: ["Istanbul", "Ankara", "Izmir", "Bursa"]),
        Question(text: "Which continent has the most countries?", hint: nil, answer: "Africa", variants: ["Asia", "Africa", "Europe", "North America"]),
        Question(text: "What language is official in Argentina?", hint: nil, answer: "Spanish", variants: ["Portuguese", "Spanish", "English", "Italian"]),
        Question(text: "In which country is the Victoria Falls located?", hint: nil, answer: "Zambia and Zimbabwe", variants: ["Zambia", "Zimbabwe", "Zambia and Zimbabwe", "Botswana"]),
        Question(text: "What is the capital city of Mexico?", hint: nil, answer: "Mexico City", variants: ["Guadalajara", "Mexico City", "Cancun", "Monterrey"]),
        Question(text: "Which continent is south of Europe?", hint: nil, answer: "Africa", variants: ["Asia", "Africa", "Australia", "America"])
    ]
}
