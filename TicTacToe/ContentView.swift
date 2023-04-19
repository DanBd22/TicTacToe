//
//  ContentView.swift
//  TicTacToe
//
//  Created by Badarau Dan on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var board: [String] = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    private let winningCombinations: [[Int]] = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Tic Tac Toe")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 50)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                ForEach(0..<9) { index in
                    Button(action: {
                        buttonTapped(index)
                    }) {
                        Text(board[index])
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: 80, height: 80)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(currentPlayer == "X" ? .red : .blue)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(currentPlayer == "X" ? Color.red : Color.blue, lineWidth: 2)
                            )
                    }
                    .disabled(board[index] != "")
                }
            }
            
            Button(action: newGame) {
                Text("New Game")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color(red: 0.5, green: 0.5, blue: 0.5))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
    }
    
    private func buttonTapped(_ index: Int) {
        if board[index] != "" { return }
        
        board[index] = currentPlayer
        
        if checkForWinner() {
            let alert = UIAlertController(title: "Game Over", message: "\(currentPlayer) has won the game!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { _ in
                newGame()
            }))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        } else if board.allSatisfy({ !$0.isEmpty }) {
            let alert = UIAlertController(title: "Game Over", message: "The game is a draw!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "New Game", style: .default, handler: { _ in
                newGame()
            }))
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            currentPlayer = currentPlayer == "X" ? "O" : "X"
        }
    }
    
    private func checkForWinner() -> Bool {
        for combination in winningCombinations {
            let a = board[combination[0]]
            let b = board[combination[1]]
            let c = board[combination[2]]
            if a == b && b == c && !a.isEmpty {
                return true
            }
        }
        return false
    }
    
    private func newGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
