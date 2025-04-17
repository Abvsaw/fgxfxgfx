import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    private let queue = OperationQueue()
    private let harshThreshold: Double = 2.5 // g-force approx.
    @Published var totalAcceleration: Double = 0.0
    @Published var harshMoves = 0

    func startUpdates() {
        guard motion.isAccelerometerAvailable else { return }

        motion.accelerometerUpdateInterval = 0.1
        motion.startAccelerometerUpdates(to: queue) { [weak self] (data, error) in
            guard let self = self, let acc = data?.acceleration else { return }

            let total = sqrt(acc.x * acc.x + acc.y * acc.y + acc.z * acc.z)
            DispatchQueue.main.async {
                self.totalAcceleration = total
                if total > self.harshThreshold {
                    self.harshMoves += 1
                }
            }
        }
    }

    func stopUpdates() {
        motion.stopAccelerometerUpdates()
    }
}