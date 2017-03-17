//
//  ViewController.swift
//  BlueSniff
//
//  Created by Pedro Pachuca on 11/30/15.
//  Copyright © 2015 Pedro Pachuca. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBAction func refreshTapped(_ sender: AnyObject) {
        self.peripherals = []
        self.ourRSSI = []
        self.tableVoew.reloadData()
        startScan()
    }
    @IBOutlet weak var tableVoew: UITableView!
    var centralManager : CBCentralManager?
    var peripherals  = [CBPeripheral]()
    var ourRSSI = [NSNumber]()
    var timer : Timer?
    override func viewDidLoad() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        super.viewDidLoad()
        self.tableVoew.delegate = self
        self.tableVoew.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func startScan() {
        self.timer?.invalidate()
        self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
        
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.stopScan), userInfo: nil, repeats: false)
    }
    
    func stopScan() {
        print("stopping")
        self.centralManager?.stopScan()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVoew.dequeueReusableCell(withIdentifier: "blueCell") as! BluetoothTableViewCell
        let peripheral = self.peripherals[indexPath.row]
        let RSSI = ourRSSI[indexPath.row]
        if peripheral.name == nil {
            cell.nameLabel!.text = peripheral.identifier.uuidString

        }
        else {
            cell.nameLabel!.text = peripheral.name
        }
            cell.RSSILabel!.text = "RSSI: \(RSSI)"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("*******************")
        print("Name: \(peripheral.name)")
        print("UUID: \(peripheral.identifier.uuidString)")
        print("Ad Data: \(advertisementData)")
        print("RSSI \(RSSI)")
        print("*******************")
        self.peripherals.append(peripheral)
        self.ourRSSI.append(RSSI)
        self.tableVoew.reloadData()
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("Good")
            startScan()
        }
        else {
            let alertVC = UIAlertController(title: "Bluetooth isnt working", message: "Make sure it is on", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style:UIAlertActionStyle.default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            print("whoops")
        }
    }

}

