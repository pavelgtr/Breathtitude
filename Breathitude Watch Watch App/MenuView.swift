//  MenuView.swift

import SwiftUI

struct MenuView: View {
    var body: some View {
        List {
            NavigationLink(destination: PlayerView(meditation: "Wim Hof Breathing")) {
                Text("Wim Hof Breathing")
            }
            NavigationLink(destination: PlayerView(meditation: "Pavel's Meditation")) {
                Text("Pavel's Meditation")
            }
            NavigationLink(destination: PlayerView(meditation: "Tony Robbins Priming")) {
                Text("Tony Robbins Priming")
            }
        }
        .navigationTitle("Meditations")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
