# 🖼️ Wallscape-Engine (WIC Edition)

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://microsoft.com/powershell)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OS: Windows](https://img.shields.io/badge/OS-Windows-0078D4.svg)](https://www.microsoft.com/windows)

A high-performance wallpaper automation toolkit for Windows. This engine rescues corrupted image assets, standardizes formats for security, and maintains a clean, sequentially indexed library.

---

## ⚡ The Problem vs. The Solution

Many image management scripts for Windows rely on the legacy **GDI+** library, which frequently triggers "Out of Memory" errors when processing modern or progressive image formats (like `.webp` or certain high-res `.jpg` files).

**Wallscape-Engine** solves this by utilizing the **WIC (Windows Imaging Component)** engine. This provides:
- **Robust Decoding:** If Windows Photo Viewer can see it, this engine can process it.
- **Asset Sanitization:** Automatically converts diverse formats into secure, metadata-clean `.png` files.
- **Stability:** Efficient memory handling for modern hardware (tested on i5 13th Gen).

## 🚀 Quick Start

1. **Setup Folder Structure:**
   > 📂 **Note:** It is highly recommended to create a folder named `Wallpapers` inside your **`Pictures`** (Imagens) directory.

2. **Download & Deploy:**
   - Drop `WallscapeEngine.ps1` and `LaunchEngine.bat` into your `Wallpapers` folder.

3. **Run:**
   - Simply **double-click** `Launch-Engine.bat`. No administrator privileges required for standard user directories.

## 🛠️ Key Features

- **Automated Import:** Scans the parent directory (`Pictures`) and automatically pulls new assets into the engine.
- **Deep Rescue:** Uses the WIC-based `BitmapDecoder` to bypass legacy image processing failures.
- **Sequential Indexing:** Automatically re-indexes your entire collection (e.g., `wallpaper_1.png`, `wallpaper_2.png`) to keep your library organized.
- **Cloud-Ready:** Native support for both local and **OneDrive-synced** picture folders.

## ⚖️ License

Distributed under the MIT License. See `LICENSE` for more information.
