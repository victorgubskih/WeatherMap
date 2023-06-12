import Foundation
import UIKit

extension UIColor {
    func gradient(to nextColor: UIColor, proportion: CGFloat) -> UIColor {
        guard proportion >= 0 else { return self }
        guard proportion <= 1 else { return nextColor }
        
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
        guard nextColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }
        
        let r3 = r1 + (r2 - r1) * proportion
        let g3 = g1 + (g2 - g1) * proportion
        let b3 = b1 + (b2 - b1) * proportion
        let a3 = a1 + (a2 - a1) * proportion
        
        return UIColor(red: r3, green: g3, blue: b3, alpha: a3)
    }
}
