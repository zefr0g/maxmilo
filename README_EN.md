# maxmilo - Mitsubishi HVAC ESPHome Controller

This project allows you to control your Mitsubishi HVAC unit (with a CN105 port) using an ESP8266 (ESP-01) and ESPHome. It replaces the original Mitsubishi **MAC-587IF-E** WiFi interface at a fraction of the cost, while offering more features. It is based on the excellent work of [echavet/MitsubishiCN105ESPHome](https://github.com/echavet/MitsubishiCN105ESPHome).

It provides a modern interface via Home Assistant or a standalone web browser, and features a captive portal for easy WiFi configuration.

<p align="center">
  <img src="docs/enclosure_render.png" alt="3D Enclosure Render" width="600" />
</p>

<p align="center">
  <img src="docs/esp.png" alt="ESP-01 and CN105 cable" width="200" />
  <img src="docs/ha_control1.png" alt="Home Assistant Interface 1" width="300" />
  <img src="docs/ha_control2.png" alt="Home Assistant Interface 2" width="300" />
</p>

## 🚀 Features

- **One-Click Installation:** Via the web installer, no command line needed.
- **WiFi Captive Portal:** Connect to the device's own WiFi to configure your local network settings.
- **Dynamic Renaming:** Change your unit's name directly from the web interface.
- **Advanced Diagnostics:** Monitor WiFi signal strength (RSSI) and uptime.
- **Home Assistant Integration:** Automatic discovery via the Native API.

## 📖 Documentation
- **[Step-by-Step Installation Guide (French)](docs/installation.md)**
- **[Future PCB Design Plan](docs/pcb_plan.md)**
- **Open Source Hardware:** 3D printable enclosure with secure mounting.

## 🛠 Hardware Required

To build this controller, you will need:

1.  **ESP8266 ESP-01 Module**
2.  **ESP-01 Serial WiFi Wireless Adapter Module** (Provides 5V to 3.3V regulation and logic level shifting)
3.  **JST PAP-05V-S Connector** (5-pin connector for the CN105 port)
4.  **maxmilo Enclosure** (SCAD file provided in `hardware/`)

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

### Option A: Web Installer (Recommended)
Flash your ESP-01 directly from your browser (Chrome/Edge) without installing anything!
👉 **[Click here to use the maxmilo Web Installer](https://zefr0g.github.io/maxmilo/web_installer/)**

### Option B: Manual Installation (CLI)
If you prefer to compile yourself:

#### 1. Install ESPHome
```bash
pip install esphome
```

#### 2. Flash the Firmware
```bash
esphome run example.yaml
```

## 💰 Buy a Kit
Don't want to source the parts yourself? [Open an Issue on GitHub](https://github.com/zefr0g/maxmilo/issues) to order a ready-to-use kit.

## 🤝 Contributing
Contributions are welcome! Feel free to open issues or pull requests.
