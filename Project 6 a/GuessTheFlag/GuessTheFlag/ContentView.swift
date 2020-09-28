//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mayuresh Rao on 8/9/20.
//  Copyright © 2020 Mayuresh Rao. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var message = ""

    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            LinearGradient.init(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(self.countries[correctAnswer]).foregroundColor(.white).font(.largeTitle).fontWeight(.black)
                    
                    ForEach(0..<3) {
                        number in Button(action:{
                            self.flagTapped(number)
                        } ) {
                            Image(self.countries[number]).renderingMode(.original).clipShape(Capsule()).overlay(Capsule().stroke(Color.black,lineWidth: 1)).shadow(color: .black, radius: 2)
                        }
                    }
                    Text("Score: \(score)").foregroundColor(.white)

                    Spacer()
                }
            }
        }.alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue"))
            {
                self.askQuestions()
                }
            )
            
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            message = "Your score is \(score)"
            score = score + 1
        } else{
            scoreTitle = "Wrong"
            message = "Wrong! That's the flag of \(self.countries[number])"
        }
        showingScore = true
    }
    func askQuestions()  {
        countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




