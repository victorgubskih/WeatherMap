import Foundation
import UIKit

class BezierCurveCalculator {
    private enum Constants {
        static let end = CGPoint(x: 1, y: 1)
    }
    let p0: CGPoint = .zero
    let p1: CGPoint
    let p2: CGPoint
    let p3: CGPoint = Constants.end

    static let linear = BezierCurveCalculator(
        p1: .zero,
        p2: Constants.end
    )

    static let easeIn = BezierCurveCalculator(
        p1: CGPoint(x: 0.42, y: 0.0),
        p2: Constants.end
    )

    static let easeOut = BezierCurveCalculator(
        p1: .zero,
        p2: CGPoint(x: 0.58, y: 1.0)
    )

    static let easeInEaseOut =  BezierCurveCalculator(
        p1: CGPoint(x: 0.42, y: 0.0),
        p2: CGPoint(x: 0.58, y: 1.0)
    )

    static let standart = BezierCurveCalculator(
        p1: CGPoint(x: 0.25, y: 0.1),
        p2: CGPoint(x: 0.25, y: 1.0)
    )

    init(p1: CGPoint, p2: CGPoint) {
        self.p1 = p1
        self.p2 = p2
    }

    func calcultate(t: CGFloat) -> CGPoint {
        guard t > 0 else {
            return p0
        }

        guard t < 1 else {
            return p3
        }

        let xt = (1 - t) * (1 - t) * (1 - t) * p0.x
                + 3 * (1 - t) * (1 - t) * t * p1.x
                + 3 * (1 - t) * t * t * p2.x
                + t * t * t * p3.x
        let yt = (1 - t) * (1 - t) * (1 - t) * p0.y
                + 3 * (1 - t) * (1 - t) * t * p1.y
                + 3 * (1 - t) * t * t * p2.y
                + t * t * t * p3.y

        return CGPoint(x: xt, y: yt)
    }

}
