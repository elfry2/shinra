. .\Config.ps1

# Install Scoop.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Out-Null

# Install Git via Scoop.
scoop install git

# Install the required Scoop buckets.
scoop bucket add extras
scoop bucket add versions

# Install the required Scoop packages.
scoop install "nginx@$NginxVersion"
scoop install "$PHPPackageName@$PHPVersion"
#scoop install nginx
#scoop install php
scoop install postgresql composer nodejs mongodb mongosh curlie neovim gh dbeaver

# Copy the files into the installation directories.
# Inspired by something found on https://gist.github.com/odan/b5f7de8dfbdbf76bef089776c868fea1.
Copy-Item ".\nginx.conf" -Destination "$HOME\scoop\apps\nginx\$NginxVersion\conf\" -Verbose
Copy-Item ".\index.php" -Destination "$HOME\scoop\apps\nginx\$NginxVersion\html\" -Verbose
Copy-Item ".\php.ini" -Destination "$HOME\scoop\apps\$PHPPackageName\$PHPVersion" -Verbose
Copy-Item "cli\php.ini" -Destination "$HOME\scoop\apps\$PHPPackageName\$PHPVersion\cli" -Verbose

# Start shinra on startup.
Remove-Item -Verbose -Recurse -Force "C:\shinra"
New-Item -Path "C:\shinra" -ItemType Directory -Verbose
Copy-Item ".\Config.ps1" -Destination "C:\shinra" -Verbose
Copy-Item ".\Start.ps1" -Destination "C:\shinra" -Verbose
Copy-Item ".\Start shinra.lnk" -Destination "$HOME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Verbose

# Start shinra.
.\Start.ps1

echo "Script finished. Make sure to read the output."
