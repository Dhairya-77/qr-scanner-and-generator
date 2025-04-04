Hey, flutter developer! I made this QR code generator and scanner using flutter framework, dart and some external dependencies.

I made this application for android and web (I mostly debug the application for android).

This application has two tabs, one of QR code scanning and other one for generating QR.

  1)Tab-1 (Scan QR):
    -For scanning the QR Code i used 'qr_code_scanner_plus' dependency. it takes camera hardware access to scan QR code.
    -In scan QR tab i used on top two icons for toggle (on/off) flashlight and toggle (front/back) camera.
    -Also in same tab I added one bottom box in which user can see scanned results.
    -I implemented auto text copy to clipboard, after the QR code scanned. i Used 'super_clipboard' dependency for it.
    
  2)Tab-2 (Generate QR):
    -For generating the QR code i used 'qr_flutter' dependency.
    -I used one 'textField' widget for user input and in this widget's 'suffixIcon' property i used 'iconButton' widget for refreshing the QR Image View

I hope this project helps you in your development. There are maybe many problems in this project, I will happy if you fix it. Thank You.
