//
//  ViewController.swift
//  MagicPaper
//
//  Created by Isaac Urbina on 1/22/25.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
	
	// MARK: - IBOutlets
	
	@IBOutlet var sceneView: ARSCNView!
	
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set the view's delegate
		sceneView.delegate = self
		
		// Show statistics such as fps and timing information
		sceneView.showsStatistics = true
		
		let configuration = ARImageTrackingConfiguration()
		
		if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: Bundle.main) {
			
			configuration.trackingImages = trackedImages
			configuration.maximumNumberOfTrackedImages = 1
			
			print("Images found")
		}
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Create a session configuration
		let configuration = ARWorldTrackingConfiguration()
		
		// Run the view's session
		sceneView.session.run(configuration)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// Pause the view's session
		sceneView.session.pause()
	}
	
	
	// MARK: - ARSCNViewDelegate
	
	func renderer(_ renderer: any SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
		let node = SCNNode()
		
		if let imageAnchor = anchor as? ARImageAnchor {
			let plane = SCNPlane(
				width: imageAnchor.referenceImage.physicalSize.width,
				height: imageAnchor.referenceImage.physicalSize.height
			)
			plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
			
			let planeNode = SCNNode(geometry: plane)
			planeNode.eulerAngles.x = -.pi / 2
			
			node.addChildNode(planeNode)
		}
		
		return node
	}
}
