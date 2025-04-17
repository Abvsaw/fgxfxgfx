import SwiftUI
import CoreMotion

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    @State private var score: Int?

    var body: some View {
        VStack(spacing: 20) {
            Text("Driving Score")
                .font(.largeTitle)
                .bold()

            Text("Acceleration: \(String(format: "%.2f", motionManager.totalAcceleration)) m/s²")
            Text("Harsh Moves: \(motionManager.harshMoves)")

            if let score = score {
                Text("Score: \(score)/100")
                    .font(.title)
                    .foregroundColor(.blue)
            }

            Button("End Session") {
                motionManager.stopUpdates()
                let rawScore = 100 - motionManager.harshMoves * 5
                score = max(0, rawScore)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            motionManager.startUpdates()
        }
    }
}