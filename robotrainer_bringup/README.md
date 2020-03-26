


# SR3

## Local Network Setup
* Network: 10.20.20.x (255.255.255.0)
* IP PC-wired: 1 
* SICK Gateway: 10
* IP Laser scanner left: 11
* IP Laser scanner right: 12

### Configuration of PC for configuring Laser scanners
1. Enable IPv4 forwarding on SR3 (http://www.ducea.com/2006/08/01/how-to-enable-ip-forwarding-in-linux/)
```
sysctl -w net.ipv4.ip_forward=1
```
2. Set it permanent in /etc/sysctl.conf:
```
net.ipv4.ip_forward = 1
```
3. Add static route to your windows computer
```
route ADD 10.20.20.0 MASK 255.255.255.0 141.3.80.80
```
