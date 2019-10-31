# Simple-PowerShell-HTTP-File-Server
A crude and simple HTTP File Server PowerShell Script

* Use /stop - to stop the script/http listener
* Use /filename.ext - to list the directories and files in the webroot (this will be where the PowerShell script is stored)
* Use /<almost anything else> - to download files, display text content in the web browser, etc. (works with Invoke-WebRequest/wget)
