
import MapKit

public protocol PlaceDetailCoordinator: AnyObject {
    func showAlert()
    func openMenu(place: Place)
    func traceRoute(_ origin: CLLocationCoordinate2D, _ destination: CLLocationCoordinate2D)
}
