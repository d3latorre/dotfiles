# dotfiles
Repository to store my dotfiles

## Check for wsl

- https://scottspence.com/posts/windsurf-setup-for-wsl#launch-windsurf-from-the-terminal

- For it to work on wsl we need to change the nameserver, the server of dns that wsl uses. We add dns srvers also when is necessary to use a VPN on windows

      sudo rm /etc/resolv.conf
      sudo bash -c 'echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4 " > /etc/resolv.conf'
      sudo bash -c 'echo "[network]" > /etc/wsl.conf'
      sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
      sudo chattr +i /etc/resolv.conf
      
      # On windows for DNS
      
      ipconfig /all | findstr /R "DNS\ Servers"
      
      # Again on WSL
      
      sudo bash -c "echo 'nameserver <dns_server_from_prev_cmd>' > /etc/resolv.conf"
