import SwiftUI

struct ContentView: View {
    //possible moves (Array)
    @State private var moves = ["✋", "✊", "✌️"]
    
    //the choices the bot have when playing the game. index 0...2 ("✋", "✊", "✌️")
    @State private var botChoice = Int.random(in: 0...2)
    
    //The initial score is set to 0
    @State private var score = 0
    
    //The initial bot score is set to 0
    @State private var botScore = 0
    
    //The thinking face boolean. It starts as true because the game has to start/reset always showing this face.
    @State private var thinking = true
    
    //Shows the alert.
    @State private var showingAlert = false
    
    //This var was suposed to be a boolean with either the player wins or lose, but in Janken, there is a third possibility, which is draw, so I had to turn it into a string.
    @State private var winLoseDraw = ""
    //Dark mode checker
    @Environment(\.colorScheme) var colorScheme
    
    //The function gets executed when the paper (button) is tapped.
    func paper() {
        if botChoice == 1 {
            score += 1
            winLoseDraw = "win"
        }
        if botChoice == 2 {
            botScore += 1
            winLoseDraw = "lose"
        }
        if botChoice == 0 {
            winLoseDraw = "draw"
        }
        showingAlert = true
        thinking = false
    }
    
    //The function gets executed when the rock (button) is tapped.
    func rock() {
        if botChoice == 0 {
            botScore += 1
            winLoseDraw = "lose"
        }
        if botChoice == 2 {
            score += 1
            winLoseDraw = "win"
        }
        if botChoice == 1 {
            winLoseDraw = "draw"
        }
        showingAlert = true
        thinking = false
    }
    
    //The function gets executed when the scissors (button) is tapped.
    func scissors() {
        if botChoice == 0 {
            score += 1
            winLoseDraw = "win"
        }
        if botChoice == 1 {
            botScore += 1
            winLoseDraw = "lose"
        }
        if botChoice == 2 {
            winLoseDraw = "draw"
        }
        showingAlert = true
        thinking = false
    }
    
    
    //This function gets executed, each turn. It turns on the thinking face bool, and randomizes the moves again.
    func reset() {
        thinking = true
        botChoice = Int.random(in: 0...2)
    }
    
    //The trailing button that resets the score to 0.
    func resetGameButton() {
        score = 0
        botScore = 0
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ZStack {
                    //The blue/black gradient circle.
                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                        .clipShape(Circle())
                        .padding()
                        .shadow(color: .black, radius: 6)
                        //A simple if statement that displays the thinking face if the thinking bool is true (it starts as true, but whenever the player taps one of these buttons underneath, the value is set to false, so it will run the else statement below.)
                    if thinking == true {
                        Text("🤔")
                                .font(.system(size: 200))
                                .shadow(color: .black, radius: 10)
                    }
                    
                    else {
                        Text("\(moves[botChoice])")
                                .font(.system(size: 200))
                                .shadow(color: .black, radius: 10)
                    }
                    
                }
                
                Spacer()
                //This HStack represents the score.
                HStack {
                    Spacer()
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                            .clipShape(Capsule())
                            .frame(width: 130, height: 50)
                            .shadow(color: .black, radius: 6)
                            HStack {
                                Image(systemName: "person")
                                Text("\(score)")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 36))
                            }
                            .padding()
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                            .clipShape(Capsule())
                            .frame(width: 130, height: 50)
                            .shadow(color: .black, radius: 6)
                        HStack {
                            Image(systemName: "hand.raised")
                            Text("\(botScore)")
                                .fontWeight(.semibold)
                                .font(.system(size: 36))
                        }
                        .padding()
                        .font(.title)
                        .foregroundColor(.white)
                    }
                    Spacer()
                }
                //This HStack contains the 3 possible moves that the player can use, when tapped, it executes the corresponding function.
                HStack {
                    Button(action: {
                       paper()
                    }, label: {
                        Text("\(moves[0])")
                            .shadow(color: colorScheme == .dark ? .yellow : .black, radius: 6)
                    })
                    Button(action: {
                        rock()
                    }, label: {
                        Text("\(moves[1])")
                            .shadow(color: colorScheme == .dark ? .yellow : .black, radius: 6)
                    })
                    Button(action: {
                        scissors()
                    }, label: {
                        Text("\(moves[2])")
                            .shadow(color: colorScheme == .dark ? .yellow : .black, radius: 6)
                    })
                }.font(.system(size: 100))
                
            //The 3 possible alerts. lose, win, draw.
            }.alert(isPresented: $showingAlert, content: {
                if self.winLoseDraw == "lose" {
                    return
                        Alert(title: Text("You Lost!"), dismissButton: .default(Text("Continue")) {
                            self.reset()
                        })
                }
                
                else if self.winLoseDraw == "win" {
                    return
                        Alert(title: Text("You Won!"), dismissButton: .default(Text("Continue")) {
                            self.reset()
                        })
                }
                
                else if self.winLoseDraw == "draw" {
                    return
                        Alert(title: Text("Draw"), dismissButton: .default(Text("Continue")) {
                            self.reset()
                        })
                }
                //this will never get executed.
                else {
                    return
                        Alert(title: Text(""), message: Text(""), dismissButton: .default(Text("")))
                }
            })
            .navigationBarTitle("Janken")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        resetGameButton()
                                    }, label: {
                                        Text("Reset")
                                    })
            )
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
