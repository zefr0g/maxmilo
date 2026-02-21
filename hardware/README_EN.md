# maxmilo Hardware - Bill of Materials & Assembly

This folder contains information about the physical components and the assembly process.

## 📦 Bill of Materials (BOM)

| Qty | Item | Description | Approx. Price |
| :--- | :--- | :--- | :--- |
| 1 | ESP8266 ESP-01 | Microcontroller (Wi-Fi) | ~$2.00 |
| 1 | ESP-01 Serial Adapter Module | Logic level shifter and 5V regulator | ~$1.50 |
| 1 | JST PAP-05V-S | 5-pin 2.0mm pitch connector (for CN105) | ~$0.50 |
| 5 | Female DuPont Wires | To connect adapter to CN105 (if not using a custom cable) | ~$0.50 |
| 1 | Custom 3D Printed Case | Enclosure for the modules | (Minimal) |

## 💰 Buy the Kit

Don't want to source the parts yourself? Buy a pre-tested kit directly from me!

- **DIY Kit:** All components (ESP-01, Adapter, Connector, 3D Printed Case) included. You assemble and flash.
- **Assembled & Pre-flashed:** Ready to plug-and-play. I will pre-flash it with your WiFi credentials if provided.

### How to Order
To purchase, please [open an issue](https://github.com/zefr0g/maxmilo/issues) or contact me at: **[Insert Your Email/PayPal/Link Here]**

## 🛠 Assembly Instructions

1.  **Prepare the Connector:** Crimp the PAP-05V-S connector with 5 wires (only 4 are strictly needed: GND, 5V, TX, RX).
2.  **Logic Level Shifting:** The Mitsubishi CN105 port uses 5V logic. **The ESP-01 uses 3.3V.** You **MUST** use a logic level shifter or an adapter that handles this. The adapter module mentioned in the BOM typically does this.
3.  **Wiring:**
    - CN105 Pin 2 (GND) -> Adapter GND
    - CN105 Pin 3 (5V) -> Adapter VCC
    - CN105 Pin 4 (TX) -> Adapter RX
    - CN105 Pin 5 (RX) -> Adapter TX
4.  **Insert ESP-01:** Plug the ESP-01 module into the adapter's socket.
5.  **Enclosure:** Secure the components inside the 3D printed case and route the cable out.

## 📂 Enclosure Files
- `enclosure.scad`: Customizable OpenSCAD script for 3D printing.
- `enclosure.stl`: (Export from OpenSCAD for printing).
