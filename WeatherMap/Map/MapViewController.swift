import UIKit
import MapKit

private let initionalLocation = CLLocation(latitude: 49.715, longitude: 35.577295518227245)

class MapViewController: UIViewController {
    private enum Constants {
        static let identifier = "weatherAnnotation"
    }
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var annotationRepository: AnnotationRepository!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        annotationRepository = AnnotationRepository(delegate: self)
        annotationRepository.loadAnnotations()
        
        mapView.register(WeatherAnnotationView.self, forAnnotationViewWithReuseIdentifier: Constants.identifier)
        

        let startRegion = MKCoordinateRegion(
            center: initionalLocation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.region = startRegion
        
        annotationRepository.addAnnotation(title: "Велика Губщина", subtitle: "Центр", coordinate: initionalLocation.coordinate)
        
       /* let annotation = MKPointAnnotation()
        annotation.coordinate = initionalLocation.coordinate
        annotation.title = "house"
        mapView.addAnnotation(annotation)*/
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        
        let gRecognaser = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(_:)))
        gRecognaser.cancelsTouchesInView = false
        mapView.addGestureRecognizer(gRecognaser)
    }
    
    @objc func longPress(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        let pressPoint = recognizer.location(in: recognizer.view)
        let coordinate = mapView.convert(pressPoint, toCoordinateFrom: recognizer.view)
       
        annotationRepository.addAnnotation(title: "\(mapView.annotations.count)", subtitle: nil, coordinate: coordinate)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard view.rightCalloutAccessoryView == nil else { return }
        let deleteButton = UIButton(type: .close)
       
        view.rightCalloutAccessoryView = deleteButton
    }
    
   func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }
        if control == view.rightCalloutAccessoryView {
            annotationRepository.delete(annotation: annotation)
        }
    }
  
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is WeatherAnnotation else { return nil }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.identifier)
        return annotationView
    }
}

extension MapViewController: AnnotationDelegate {
    func didLoad(annotations: [MKAnnotation]) {
        mapView.addAnnotations(annotations)
    }
    
    func didAdd(annotation: MKAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
    func didDelete(annotation: MKAnnotation) {
        mapView.removeAnnotation(annotation)
    }
}
