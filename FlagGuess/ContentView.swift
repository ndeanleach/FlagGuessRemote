//
//  ContentView.swift
//  FlagGuessGame
//
//  Created by Nathan Leach on 8/30/23.
//

import SwiftUI

struct FlagImage: View{
    
    var img: String

    var body: some View{
        Image(img)
            .clipShape(Capsule())
            .shadow(radius: 20)
    }
}

struct ContentView: View {
    
    @State private var playerScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .padding(20)
                    ForEach(0..<3) { num in
                        Button{
                            flagTapped(num)
                        } label: {
                            FlagImage(img: countries[num])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(playerScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding(40)
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(playerScore)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            if playerScore < 10 {
                scoreTitle = "Correct"
                playerScore += 1
                showingScore = true
            } else{
                scoreTitle = "You Win! Starting New Game"
                showingScore = true
                playerScore = 0
            }
        } else {
            scoreTitle = "Wrong"
            showingScore = true
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

