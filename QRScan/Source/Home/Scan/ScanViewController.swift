//
//  ScanViewController.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/17/22.
//

import AVKit
import AVFoundation

class ScanViewController: UIViewController {
  
  //MARK: Variables
  let session: AVCaptureSession = AVCaptureSession()
  let metadataOutput: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
  var success : Bool = true
  var label : UILabel!
  var image : UIImageView!
  var backButton: UIButton!
  
  //MARK:- VC lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
  //MARK: Methods for when view appears
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    viewDidAppearSetup()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    image.layer.removeAllAnimations()
  }
  
  fileprivate func initialSetup(){
    self.navigationController?.navigationBar.isHidden = true /// Hide Nav bar
    //MARK: Add respective components
    sessionSetup()
    addBlur()
    addLabel()
    addCorners()
  }
  
  fileprivate func viewDidAppearSetup(){
    outputCheck()
    runSession()
    animateCorner()
    self.label.text = "Find a code to scan"
    self.navigationController?.navigationBar.isHidden = true
  }
  
  
  //MARK: Setup camera session
  func sessionSetup(){
    guard let device = AVCaptureDevice.default(for: .video ) else  { errorAlert("camera missing") ; return } /// Check camera
    
    session.sessionPreset = AVCaptureSession.Preset.high
    
    do {   try session.addInput(AVCaptureDeviceInput(device: device))   }
    catch {  errorAlert(error.localizedDescription) }
    
    let previewLayer = AVCaptureVideoPreviewLayer(session: session)
    previewLayer.frame = self.view.layer.bounds
    view.layer.addSublayer(previewLayer)
    
    session.startRunning() /// Start session
  }
  
  //MARK: Check for if camera video can be displayed
  func outputCheck(){
    
    //MARK: Check output
    if session.canAddOutput(metadataOutput) {
      session.addOutput(metadataOutput)
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.qr]
    } else {
      errorAlert("Cannot display camera output")
    }
  }
  
  
  //Return to session
  private func runSession(){
    if !session.isRunning{
      session.startRunning()
    }
  }
  // ---------------------------------BEGIN-UI-SETUP----------------------------------------
  // MARK: - UserInterface elements setup
  
  //MARK:- Add Blur with custom mask
  func addBlur(){
    //MARK: Add Blur view
    let blur = UIBlurEffect(style: .regular)
    let blurView = UIVisualEffectView(effect: blur)
    blurView.frame = self.view.bounds
    blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    let scanLayer = CAShapeLayer()
    let maskSize = getMaskSize()
    let outerPath = UIBezierPath(roundedRect: maskSize, cornerRadius: 30)
    
    //MARK: Add Mask
    let superlayerPath = UIBezierPath(rect: blurView.frame)
    outerPath.append(superlayerPath)
    scanLayer.path = outerPath.cgPath
    scanLayer.fillRule = .evenOdd
    
    view.addSubview(blurView) /// FInal blur layer
    blurView.layer.mask = scanLayer
  }
  
  // Get mask size respect to screen size
  /// For `Dynamic` CameraView Size
  private func getMaskSize() -> CGRect {
    let viewWidth = view.frame.width
    let rectwidth = viewWidth - 114
    let halfWidth = rectwidth/2
    let x = view.center.x - halfWidth
    let y = view.center.y - halfWidth
    return CGRect(x: x, y: y, width: rectwidth, height: rectwidth)
  }
  
  //MARK: Add disclaimer label
  func addLabel(){
    let lableDimension = (92/896)*view.frame.height
    label = UILabel(frame: CGRect(x: 0, y: 0, width: lableDimension+100, height: lableDimension))
    label.center = CGPoint(x: view.center.x, y: 100)
    label.textAlignment = .center
    label.text = "Find a code to scan"
    label.font = label.font.withSize(20)
    label.textColor = .white
    label.clipsToBounds = true
    label.layer.cornerRadius = (46/896)*view.frame.height
    
    self.backButton = UIButton(frame: CGRect(x: self.view.frame.width - 50, y: 64, width: 34, height: 34))
    backButton.setImage(UIImage(named: "iconClose"), for: .normal)
    backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
//    backButton.layer.cornerRadius = 25
//    backButton.layer.masksToBounds = true
    view.addSubview(backButton)
    view.addSubview(label)
  }
  
  //MARK: Add White corners ( design purpose only )
  func addCorners(){
    let maskSize = getMaskSize().height
    let imageWidth = maskSize * 1.0866666667
    let halfWidth = (imageWidth) / 2
    let x = view.center.x - halfWidth
    let y = view.center.y - halfWidth
    let imageFrame = CGRect(x: x, y: y, width: imageWidth, height: imageWidth)
    
    image  = UIImageView()
    image.frame = imageFrame
    image.image = UIImage(named: "corners")
    print(imageFrame)
    view.addSubview(image)
  }
  
  // Add animation to the corners
  func animateCorner(){
    let animation = CABasicAnimation(keyPath: "transform.scale")
    animation.toValue = 1.1         /// 1.1 times initial size
    animation.duration=1            /// 1 second
    animation.timingFunction=CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    animation.autoreverses=true
    animation.repeatCount = .infinity           /// Infinite animation
    image.layer.add(animation, forKey:"animate")
  }

  @objc func backAction(sender: UIButton!) {
    self.navigationController?.popViewController(animated: true)
  }
}

//MARK:- AVCaptureMetadataOutputObjects Delegate Method
extension ScanViewController : AVCaptureMetadataOutputObjectsDelegate{
  
  /// returns metadataOutput as `String from qr`
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    if let metadataObject = metadataObjects.first {
      guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
      guard let stringValue = readableObject.stringValue else { return }
      AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
      successAlert(stringValue)
      self.label.text = "✅"
    }
    session.stopRunning()
  }
}

//MARK:- Alert Functions
extension ScanViewController {
  
  /// Alert shown when qr scan is `Successful`
  public func successAlert(_ message : String){
    //    let alert = UIAlertController(title: "Heres Your result", message: message, preferredStyle: .alert)
    //    let goAction = UIAlertAction(title: "Go TO", style: .default) { (UIAlertAction) in
    do {
      let data = Data(message.utf8)
      let decoder = JSONDecoder()
      let qrScannedData = try decoder.decode(QRScannedModel.self, from: data)
      let storyboard = UIStoryboard(name: "Home", bundle: nil)
      let viewController = storyboard.instantiateViewController(withIdentifier: "QRScannedViewController") as! QRScannedViewController
      let viewModel = QRScannedViewModel()
      viewModel.parseQRObject = qrScannedData
      viewController.viewModel = viewModel
      self.navigationController?.pushViewController(viewController, animated: true)
    } catch {
      print(error.localizedDescription)
      self.showNormalAlert(for: "Error", description: "Could Not Parse QR Code") {
        self.session.startRunning()
        self.label.text = "Find a code to scan"
      }
    }
    //    }
    //    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)  { (UIAlertAction) in
    //      self.session.startRunning()
    //      self.label.text = "Find a code to scan"
    //    }
    //    alert.addAction(cancelAction)
    //    alert.addAction(goAction)
    //    self.present(alert,animated: true)
  }
  
  /// Alert shown when qr scan  `Fails` or `Unexpected Error`
  public func errorAlert(_ message: String){
    let aLert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "return", style: .default, handler: nil)
    aLert.addAction(action)
    self.present(aLert,animated: true)
  }
}

