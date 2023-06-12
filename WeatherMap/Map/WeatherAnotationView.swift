import UIKit
import MapKit

class WeatherAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 60)
        centerOffset = CGPoint(x: 0, y: -frame.height / 2)
        canShowCallout = true
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
