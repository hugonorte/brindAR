# Technical Specification: Brindar - The Sommelier's Lens

## Executive Summary
Brindar is a premium mobile application designed for wine enthusiasts. It leverages smartphone cameras and Augmented Reality (AR) to bridge the gap between physical wine bottles and digital knowledge. By scanning a bottle's EAN-13 or UPC-A barcode, users instantly access a curated world of viticulture data, professional sommelier insights, and personalized pairing suggestions. Users can also manually register wines not yet present in the internal database.

> **MVP Notice**: This document describes the **Minimum Viable Product (MVP)** phase of Brindar. All user data is persisted **locally on the device** (on-device database). The architecture must be designed from the start to allow a **fast, low-effort migration to a cloud-based REST API** when the product evolves beyond the MVP phase.

## Requirements

### Functional Requirements

1. **Premium Splash Screen**: An animated entry point reinforcing the "Brindar" luxury brand.

2. **Dynamic Dashboard**:
    - Personalized greeting based on time of day (Morning / Afternoon / Evening / Night).
    - User's display name shown in the greeting — hardcoded for the MVP; will be sourced from user profile in a future release.
    - Quick access to the Wine Knowledge Base.
    - Horizontal scrolling for Wine Pairing Suggestions — MVP data source: hardcoded curated list; future: generated dynamically based on user's scan history.
    - Top 3 Wine Ranking — ranked by **highest Expert Score** among wines in the internal database; MVP falls back to a hardcoded list if no wines are registered yet.
    - Top Liked Videos Ranking (educational wine content).

3. **AR Barcode Scanner (2D Overlay)**:
    - High-performance camera integration.
    - Real-time barcode recognition using the **`mobile_scanner`** library ([pub.dev/packages/mobile_scanner](https://pub.dev/packages/mobile_scanner)).
    - Supported barcode formats (in order of preference):
        1. **EAN-13** (European Article Number, 13 digits) — primary format, used in Brazil and Europe.
        2. **UPC-A** (Universal Product Code, 12 digits) — secondary format, common on wines from the US, Canada, and other markets.
    - Codes that are not valid EAN-13 or UPC-A (wrong format or failed checksum) must be silently ignored; the scanner continues listening.
    - After capturing a valid EAN-13 or UPC-A code, the app queries its **internal database**:
        - **Code found**: Display the wine data using the Elegant "Glassmorphism" UI overlay, showing:
            - Expert Score (e.g., 94 PTS).
            - Technical Specs (ABV, Body, Ideal Temperature).
            - Sommelier's "Digital Note".
        - **Code not found**: Display a message informing that the code was not found, followed by a button with the label **"cadastrar vinho ?"** that redirects the user to the Wine Registration Flow (RF#6).
    - The scanner must be **paused when the app enters background** and **resumed on foreground** to preserve battery and camera resources.

4. **Knowledge Base (Wine Library)**:
    - Searchable database containing:
        - Wines registered manually by the user via the Wine Registration Flow (RF#6).
        - Wines previously scanned and found in the internal database.
    - Detailed wine profiles with all fields from RF#6.
    - **CRUD operations available to the user**:
        - **Read**: View full wine profile.
        - **Update**: Edit any field of a wine previously registered by the user.
        - **Delete**: Remove a wine from the local database, with a confirmation dialog before deletion.
        - *(Create is handled exclusively through the Wine Registration Flow — RF#6.)*

5. **Wine Education Module**:
    - A dedicated section for educational content about wine.
    - Content sources (MVP): curated YouTube video embeds via `webview_flutter` or `url_launcher`.
    - Future: support for internal articles and expert tutorials.

6. **Wine Registration Flow**:
    - Triggered by the **"cadastrar vinho ?"** button on the scan "not found" screen.
    - The barcode (EAN-13 or UPC-A) captured during scan is **pre-filled** and read-only in the form.
    - Form fields (all required unless noted):
        - Wine Name
        - Barcode — EAN-13 or UPC-A *(pre-filled, read-only)*
        - Country of Origin
        - Region / Appellation
        - Grape Variety *(one or more)*
        - Vintage Year
        - ABV — Alcohol by Volume (%)
        - Body *(Light / Medium / Full)*
        - Ideal Serving Temperature (°C)
        - Expert Score (0–100 pts) *(optional)*
        - Sommelier's Digital Note *(optional, free text)*
    - All required fields are validated before submission.
    - **Access control (MVP)**: No authentication system exists in the MVP. Any user with the app installed may register wines freely. Access restrictions and user-level control will be introduced when the cloud backend (REST API) is implemented in the post-MVP phase.
    - On save: wine is persisted to the internal database and the Glassmorphism overlay is displayed immediately with the newly registered data.

---

### Non-Functional Requirements

1. **Performance**: Scanning and data overlay should feel instantaneous (< 500ms for recognized codes).
2. **UX/UI**: Strict adherence to "The Sommelier's Lens" design system:
    - Primary Colors: Burgundy (#210000) and Cream (#FCF9F3).
    - Typography: Editorial Noto Serif for headlines, Precise Manrope for body.
    - Interaction: Use of tonal shifts instead of borders; smooth micro-animations.
3. **Scalability**: Architecture must support future 3D AR integration (ARCore/ARKit).
4. **Availability**: The app must be fully functional offline. All core features (scan, library, registration) rely exclusively on the on-device database in the MVP; no network dependency for any core flow.
5. **App Lifecycle**: The camera scanner must be paused on `AppLifecycleState.paused` and resumed on `AppLifecycleState.resumed` to avoid resource leaks and battery drain.

---

## Architecture & State Management

- **Framework**: Flutter (Cross-platform iOS/Android).
- **State Management**: Provider or BLoC for separating UI from business logic.
- **Barcode Scanning Library**: [`mobile_scanner`](https://pub.dev/packages/mobile_scanner)
    - Replaces the `camera` package for the scan screen.
    - Uses the `MobileScanner` widget with `onDetect` callback to process detected barcodes.
    - Accepted formats: **`BarcodeFormat.ean13`** (preferred) and **`BarcodeFormat.upcA`** (secondary); all other formats are silently ignored.
    - Scanner lifecycle is bound to `WidgetsBindingObserver` to handle background/foreground transitions.
- **Data Flow**:
    1. `MobileScanner` widget detects a real EAN-13 or UPC-A barcode from the camera feed.
    2. The scanned barcode value (12 digits for UPC-A, 13 digits for EAN-13) is passed to `WineProvider.startScan(code)`.
    3. Local service queries internal database using the real code.
    4. UI State updates:
        - **Found** → "Success (Overlay)" state with Glassmorphism card.
        - **Not Found** → "Not Found" state with message + "cadastrar vinho ?" button.
        - **Registration** → navigates to Wine Registration Form with code pre-filled.
- **Navigation**: Persistent custom Bottom Navigation Bar for Dashboard, Scan, Library, and Education.
- **Data Persistence Strategy**:
    - **MVP (current phase)**: All wine data is stored **on the device** using a local database (e.g., `sqflite` or `drift`). No network connection is required for core features.
    - **Post-MVP (cloud-ready)**: The data layer must implement the **Repository Pattern**, abstracting persistence behind an interface (e.g., `WineRepository`). A concrete implementation `LocalWineRepository` handles on-device storage in the MVP. A future `RemoteWineRepository` will connect to a **REST API** (HTTP/JSON) to persist data in the cloud. Switching between implementations must require **no changes to business logic or UI** — only a dependency injection update.
    - **Engineer directive**: Never call database or HTTP code directly from Providers or UI widgets. Always go through the repository interface.

---

## Security & Reliability

1. **Token-based Authentication**: For future cloud sync of the user's "Cellar" (Library).
2. **Camera Permissions**: Graceful handling of permission denials with user education dialogs.
3. **Encrypted Local Storage**: To protect user's personal wine library data.
4. **API Security**: Use of HTTPS and secret management for fetching wine metadata.
5. **Barcode Validation**: Both format and checksum digit are verified before any database query is triggered. Accepted formats: EAN-13 (13 digits) and UPC-A (12 digits). Invalid codes are silently discarded.
6. **Access Control (Wine Registration)**: Open to all authenticated users in MVP. Admin-only restriction to be evaluated post-launch based on data integrity requirements.

---

**Do you approve of this specification? You can safely open `Technical_Specification.md` and add comments or modifications if you want me to rework anything!**
