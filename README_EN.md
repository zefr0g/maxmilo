# maxmilo - Mitsubishi HVAC ESPHome Controller

This project allows you to control your Mitsubishi HVAC unit (with a CN105 port) using an ESP8266 (ESP-01) and ESPHome. It provides a modern interface via Home Assistant or a standalone web browser, and features a captive portal for easy WiFi configuration.

## 🚀 Features

- **WiFi Captive Portal:** Connect to the device's own WiFi to configure your local network settings.
- **Standalone Web Interface:** Control your AC directly from your smartphone browser.
- **Home Assistant Integration:** Automatic discovery via the Native API.
- **Open Source Hardware:** Simple, affordable components.

## 🛠 Hardware Required

To build this controller, you will need:

1.  **ESP8266 ESP-01 Module**
2.  **ESP-01 Serial WiFi Wireless Adapter Module** (Provides 5V to 3.3V regulation and logic level shifting)
3.  **JST PAP-05V-S Connector** (5-pin connector for the CN105 port)
4.  **Enclosure** (3D printed or off-the-shelf)

### Wiring Diagram (CN105 to ESP-01)

| CN105 Pin | Function | ESP-01 Adapter |
| :--- | :--- | :--- |
| 1 | 12V | Not Connected |
| 2 | GND | GND |
| 3 | 5V | VCC (5V) |
| 4 | TX | RX (GPIO3) |
| 5 | RX | TX (GPIO1) |

> ⚠️ **Warning:** Ensure your adapter handles 5V to 3.3V logic level shifting to protect the ESP-01.

## 💻 Software Setup

### 1. Install ESPHome
If you haven't already, install ESPHome:
```bash
pip install esphome
```

### 2. Flash the Firmware
Connect your ESP-01 to your computer using a USB-to-Serial programmer and run:
```bash
esphome run example.yaml
```

### 3. WiFi Configuration
1. Once flashed and powered, the device will create a WiFi hotspot named `My HVAC Setup` (or the name you chose).
2. Connect to it with your smartphone.
3. A portal should open automatically. Select your home WiFi and enter the password.
4. The device will restart and connect to your network.

## 📂 Project Structure

- `common/`: Modular ESPHome configuration files.
- `hardware/`: PCB designs and enclosure files (STLs).
- `example.yaml`: Template configuration for your HVAC unit.

## 🤝 Contributing
Contributions are welcome! Feel free to open issues or pull requests.
