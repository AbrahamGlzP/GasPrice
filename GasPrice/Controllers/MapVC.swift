//
//  MapVC.swift
//  GasPrice
//
//  Created by Hector on 10/25/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CustomAnnotation: MKPointAnnotation{
    var id: Int!
    var imageName: String!
}

class MapVC: UIViewController {

    var favGasLat: Double!
    var favGasLon: Double!
    var favIndex: Int!
    
    var usuario = [Usuario]()
    
    var places = [Place]()
    var favGasStop = [Gasolinera]()
    
    var gasolineras = [Gasolinera]()
    
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    let geoCoder = CLGeocoder()
    var directionsArray: [MKDirections] = []
    
    @IBOutlet weak var txtBuenDia: UILabel!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var btnAtras: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var viewCircle: CardView!
    @IBOutlet weak var viewSquare: UIView!
    @IBOutlet weak var txtDondeEstas: UITextField!
    @IBOutlet weak var txtGasolinera: UITextField!
    
    var baraGas1: Gasolinera!
    var baraGas2: Gasolinera!
    var baraGas3: Gasolinera!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var imgPin: UIImageView!
    
    let cheapAnnotation = MKPointAnnotation()
    
    @IBAction func btnMenu(_ sender: Any) {
        openView(viewRefId: "MenuVC")
        
    }
    
    @IBAction func buscarGasolinera(_ sender: Any) {
        bottomView.isHidden = true
        topView.isHidden = false
        imgPin.isHidden = false
        viewCircle.backgroundColor = UIColor.black
        
        txtDondeEstas.text = ""
        txtGasolinera.text = ""
        
        bottomViewHeight.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        
        favGasStop = loadFavGasStops()
        
        usuario = loadClient()
        if !loadClient().isEmpty{
            txtBuenDia.text = "Buen dia, " + String(usuario[0].Nombre)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favGasStop = loadFavGasStops()
        
        checkLocationServices()
        
        if loadClient().count != 0{
        usuario = loadClient()
        }
        
        if !loadGasStops().isEmpty{
            gasolineras = loadGasStops()
            baraGas1 = gasolineras[0]
            baraGas2 = gasolineras[1]
            baraGas3 = gasolineras[2]
            addPlaces()
            
        }
        
       // self.txtDondeEstas.delegate = self
       // self.txtGasolinera.delegate = self
        
        txtDondeEstas.addTarget(self, action: #selector(self.focusDondeEstas(_:)), for: UIControl.Event.touchDown)
        txtGasolinera.addTarget(self, action: #selector(self.focusGasolinera(_:)), for: UIControl.Event.touchDown)
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
    }
    
    
    func addPlaces()
    {
        
        for i in 3..<gasolineras.count
        {
            
            let annotation = CustomAnnotation()
            
            annotation.id = gasolineras[i].id
            annotation.coordinate = CLLocationCoordinate2D(latitude: gasolineras[i].Latitud, longitude: gasolineras[i].Longitud)
            annotation.title = gasolineras[i].Nombre
            annotation.subtitle = "Regular: $\(gasolineras[i].Regular ?? 0) Premium: $\(gasolineras[i].Premium ?? 0)"
            annotation.imageName = "markB5"
            map.addAnnotation(annotation)
        }
        
        let cheap1 = CustomAnnotation()
        cheap1.id = gasolineras[0].id
        cheap1.coordinate = CLLocationCoordinate2DMake(baraGas1.Latitud, baraGas1.Longitud)
        cheap1.title = baraGas1.Nombre
        cheap1.subtitle = "Regular: $\(baraGas1.Regular ?? 0) Premium: $\(baraGas1.Premium ?? 0)"
        cheap1.imageName = "markG5"
        
        let cheap2 = CustomAnnotation()
        cheap2.id = gasolineras[1].id
        cheap2.coordinate = CLLocationCoordinate2DMake(baraGas2.Latitud, baraGas2.Longitud)
        cheap2.title = baraGas2.Nombre
        cheap2.subtitle = "Regular: $\(baraGas2.Regular ?? 0) Premium: $\(baraGas2.Premium ?? 0)"
        cheap2.imageName = "markBL5"
        
        let cheap3 = CustomAnnotation()
        cheap3.id = gasolineras[2].id
        cheap3.coordinate = CLLocationCoordinate2DMake(baraGas3.Latitud, baraGas3.Longitud)
        cheap3.title = baraGas2.Nombre
        cheap3.subtitle = "Regular: $\(baraGas3.Regular ?? 0) Premium: $\(baraGas3.Premium ?? 0)"
        cheap3.imageName = "markY5"
        
        map.addAnnotation(cheap1)
        map.addAnnotation(cheap2)
        map.addAnnotation(cheap3)
       
        
    }
    //Para cambiar el color del pin dependiendo del precio de la gasolina
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")

        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
             annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .contactAdd)
            annotationView!.rightCalloutAccessoryView = btn
            
        }else{
            annotationView?.annotation = annotation
        }
        
        let cpa = annotation as! CustomAnnotation
        annotationView!.image = UIImage(named:cpa.imageName)
        
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let pin = view.annotation
        let nombre = pin!.title
        let mensaje = "¿Deseas agregar \(nombre! ?? "") a tus gasolineras favoritas?"
        
        let ac = UIAlertController(title: "Añadir a favoritos", message: mensaje, preferredStyle: .alert)
        
        let aceptar = UIAlertAction(title: "Agregar", style: .default) {
            UIAlertAction in
            
            if self.agregarFavoritos(index: self.favIndex){
                           self.showAlert(msg: "Ya guardaste esta gasolinera anteriormente")
                           
                       }else{
                           
                           self.showAlert(msg: "Se agrego la gasolinera a favoritos")
                            saveFavGasStops(self.favGasStop)
                print(loadFavGasStops())
                           
                       }
            
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        ac.addAction(aceptar)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    func agregarFavoritos(index: Int) -> Bool{

        let existe = favGasStop.contains(where: {$0.id == index})
        /*var existe = false
        
        for gaso in favGasStop{
            if gaso.id == favIndex{
                existe = true
                return existe
            }
        }*/
        if !existe{
            
            for gaso in gasolineras{
                if gaso.id == index{
                    favGasStop.append(gaso)
                    print(gaso.Nombre)
                }
            }
            
            //favGasStop.append(gasolineras.)
            //print(gasolineras[favIndex].Nombre!)
            
        }
        
        return existe
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if let customPin = view.annotation as? CustomAnnotation{
            
            favIndex = customPin.id
            print(favIndex!)
            
        }
        
        
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func btnVolver(_ sender: Any) {
        //checkLocationServices()
        bottomView.isHidden = false
        topView.isHidden = true
        imgPin.isHidden = true
        view.endEditing(true)
        
        viewCircle.backgroundColor = UIColor.lightGray
        viewSquare.backgroundColor = UIColor.lightGray
        
        bottomViewHeight.constant = 250
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func volverClicked(_ sender:Any)
    {
        
    }
    
    @objc func focusDondeEstas(_ textField: UITextField) {
        viewCircle.backgroundColor = UIColor.black
        viewSquare.backgroundColor = UIColor.lightGray
    }
    
    @objc func focusGasolinera(_ textField: UITextField) {
        viewCircle.backgroundColor = UIColor.lightGray
        viewSquare.backgroundColor = UIColor.black
        getDirections()
    }
    
    func openView(viewRefId : String){
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: viewRefId)
        vc.modalPresentationStyle = .overCurrentContext
           let transition = CATransition()
           transition.duration = 0.5
           transition.type = CATransitionType.reveal
           transition.subtype = CATransitionSubtype.fromLeft
           transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
           view.window!.layer.add(transition, forKey: kCATransition)
           self.present(vc, animated: false, completion: nil)
       }
 
    func setupLocationManager()
    {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization()
    {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            map.showsUserLocation = true
            startTackingUserLocation()
            
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTackingUserLocation() {
        map.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: map)
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func centerViewOnUserLocation()
    {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 3000, longitudinalMeters: 3000)
            map.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices()
    {
        if CLLocationManager.locationServicesEnabled()
        {
            setupLocationManager()
            checkLocationAuthorization()
        }
        else
        {
            
        }
    }
    
    //Funcion para trazar la ruta 
     func getDirections() {
       guard let location = locationManager.location?.coordinate else {
           //TODO: Inform user we don't have their current location
           return
       }
       
       let request = createDirectionsRequest(from: location)
       let directions = MKDirections(request: request)
       resetMapView(withNew: directions)
       
       directions.calculate { [unowned self] (response, error) in
           //TODO: Handle error if needed
           guard let response = response else { return } //TODO: Show response not available in an alert
           
           for route in response.routes {
               self.map.addOverlay(route.polyline)
               self.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
           }
       }
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getCenterLocation(for: map).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = true
        
        return request
    }
    
    
    func resetMapView(withNew directions: MKDirections) {
        map.removeOverlays(map.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
    }
    
    func showAlert(msg:String)
    {
        let alert = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension MapVC:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        //addPlaces()
        
        let center = getCenterLocation(for: map)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 10 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            var streetNumber = placemark.subThoroughfare ?? ""
            var streetName = placemark.thoroughfare ?? ""
            
            let location = placemark.location
            
            for place in self.places
            {
                let d = location?.distance(from: CLLocation(latitude: place.lat, longitude: place.lon))
                
                if(Double(d!) < 20)
                {
                    streetName = place.nombre
                    streetNumber = place.edificio
                    break
                }
            }
            
            
            DispatchQueue.main.async {
                self.txtDondeEstas.text = "\(streetName) \(streetNumber)"
            }
        }
    }
    /*
    func getGasolineras(){
        
        guard let url = URL(string:GasPriceAPI.BASE_URL + "gas_stops")else{return}
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){(data,response,_) in
            guard let data = data else{return}
            
            do{
                self.gasolineras = try JSONDecoder().decode([Gasolinera].self, from: data)
                print(self.gasolineras)
                
                self.addPlaces()
            }catch let error{
                print(error)
            }
        }
        task.resume()
        
        //addPlaces()
    }*/
    
}
