import SwiftUI

struct ContentView: View {
    @State private var moves = ["✋", "✊", "✌️"]
    @State private var botChoice = Int.random(in: 0...2)
    @State private var winLose = ""
    @State private var score = 0
    @State private var thinking = true
    @State private var showingScore = false
    @State private var winLoseDraw = ""
    
    func paper() {
        if botChoice == 1 {
            winLose = "You Won!"
            score += 1
            winLoseDraw = "win"
        }
        if botChoice == 2 {
            winLose = "You Lost!"
            if score <= 0 {}
            else {
                score -= 1
            }
            winLoseDraw = "lose"
        }
        if botChoice == 0 {
            winLoseDraw = "draw"
        }
        showingScore = true
    }
    
    func rock() {
        if botChoice == 0 {
            winLose = "You Lost!"
            if score <= 0 {}
            else {
                score -= 1
            }
            winLoseDraw = "lose"
        }
        if botChoice == 2 {
            winLose = "You Won!"
            score += 1
            winLoseDraw = "win"
        }
        if botChoice == 1 {
            winLoseDraw = "draw"
        }
        showingScore = true
    }
    
    func scissors() {
        if botChoice == 0 {
            winLose = "You Won!"
            score += 1
            winLoseDraw = "win"
        }
        if botChoice == 1 {
            winLose = "You Lost!"
            if score <= 0 {}
            else {
                score -= 1
            }
            winLoseDraw = "lose"
        }
        if botChoice == 2 {
            winLoseDraw = "draw"
        }
        showingScore = true
    }
    
    func reset() {
        thinking = true
        botChoice = Int.random(in: 0...2)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Spacer()
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                        .clipShape(Circle())
                        .padding()
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
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                        .clipShape(Capsule())
                        .frame(width: 130, height: 50)
                    HStack {
                        Image(systemName: "star.fill")
                        Text("\(score)")
                            .fontWeight(.semibold)
                            .font(.system(size: 36))
                    }
                    .padding()
                    .font(.title)
                    .foregroundColor(.white)
                }
                
                HStack {
                    Button(action: {
                       paper()
                        thinking = false
                    }, label: {
                        Text("\(moves[0])")
                            .shadow(color: .black, radius: 10)
                    })
                    Button(action: {
                        rock()
                        thinking = false
                    }, label: {
                        Text("\(moves[1])")
                            .shadow(color: .black, radius: 10)
                    })
                    Button(action: {
                        scissors()
                        thinking = false
                    }, label: {
                        Text("\(moves[2])")
                            .shadow(color: .black, radius: 10)
                    })
                }.font(.system(size: 100))
                    
            }.alert(isPresented: $showingScore, content: {
                if self.winLoseDraw == "lose" {
                    return
                        Alert(title: Text(winLose), dismissButton: .default(Text("Continue")) {
                            self.reset()
                        })
                }
                
                else if self.winLoseDraw == "win" {
                    return
                        Alert(title: Text(winLose), dismissButton: .default(Text("Continue")) {
                            self.reset()
                        })
                }
                
                else if self.winLoseDraw == "draw" {
                    return
                        Alert(title: Text("Draw"), dismissButton: .default(Text("Continue")) {
                            self.reset()
                        })
                }
                else {
                    return
                        Alert(title: Text(winLose), message: Text("You Won"), dismissButton: .default(Text("Continue")))
                }
            })
            .navigationBarTitle("Janken")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
