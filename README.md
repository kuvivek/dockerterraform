
Create a terraform config file

    [kuvivek@vivekcentos Terraform]$ vi config.tf
    [kuvivek@vivekcentos Terraform]$
    [kuvivek@vivekcentos Terraform]$ cat config.tf 
    provider "docker" {
      host = "tcp://192.168.64.180:2376/"
    }
    
    resource "docker_image" "nginx" {
      name = "nginx:1.11-alpine"
    }
    
    resource "docker_container" "nginx-server" {
      name = "nginx-server"
      image = "${docker_image.nginx.latest}"
      ports {
        internal = 80
      }
      volumes {
        container_path  = "/usr/share/nginx/html"
        host_path = "/home/scrapbook/tutorial/www"
        read_only = true
      }
    }
    [kuvivek@vivekcentos Terraform]$ 

Note: In the terraform config file I have used the provider as docker and I am expecting to run the docker container on the docker daemon running on the TCP port 2376 of the current local machine with the IP address as 192.168.64.180. 

Lets stop the docker service and then start the docker daemon on the TCP port locally.
via the following command.

    [kuvivek@vivekcentos ~]$ 
    [kuvivek@vivekcentos ~]$ sudo dockerd --debug --host tcp://192.168.64.180:2376
    INFO[2019-09-10T19:09:20.973391603-04:00] Starting up                                  
    WARN[2019-09-10T19:09:20.974578242-04:00] [!] DON'T BIND ON ANY IP ADDRESS WITHOUT setting --tlsverify IF YOU DON'T KNOW WHAT YOU'RE DOING [!] 
    DEBU[2019-09-10T19:09:20.975161452-04:00] Listener created for HTTP on tcp (192.168.64.180:2376) 
    DEBU[2019-09-10T19:09:20.976618212-04:00] Golang's threads limit set to 10080          
    INFO[2019-09-10T19:09:20.977294404-04:00] parsed scheme: "unix"                         module=grpc
    INFO[2019-09-10T19:09:20.977321572-04:00] scheme "unix" not registered, fallback to default scheme  module=grpc
    INFO[2019-09-10T19:09:20.977386108-04:00] ccResolverWrapper: sending update to cc: {[{unix:///run/containerd/containerd.sock 0  <nil>}] }  module=grpc
    INFO[2019-09-10T19:09:20.977406249-04:00] ClientConn switching balancer to "pick_first"  module=grpc
    INFO[2019-09-10T19:09:20.977544754-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc0005a4a00, CONNECTING  module=grpc
    INFO[2019-09-10T19:09:21.018425031-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc0005a4a00, READY  module=grpc
    INFO[2019-09-10T19:09:21.019736889-04:00] parsed scheme: "unix"                         module=grpc
    INFO[2019-09-10T19:09:21.019765404-04:00] scheme "unix" not registered, fallback to default scheme  module=grpc
    INFO[2019-09-10T19:09:21.019790268-04:00] ccResolverWrapper: sending update to cc: {[{unix:///run/containerd/containerd.sock 0  <nil>}] }  module=grpc
    INFO[2019-09-10T19:09:21.019803786-04:00] ClientConn switching balancer to "pick_first"  module=grpc
    INFO[2019-09-10T19:09:21.019880033-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc00089d390, CONNECTING  module=grpc
    INFO[2019-09-10T19:09:21.020576097-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc00089d390, READY  module=grpc
    DEBU[2019-09-10T19:09:21.021120966-04:00] Using default logging driver json-file       
    DEBU[2019-09-10T19:09:21.021451887-04:00] [graphdriver] priority list: [btrfs zfs overlay2 aufs overlay devicemapper vfs] 
    DEBU[2019-09-10T19:09:21.032148049-04:00] processing event stream                       module=libcontainerd namespace=plugins.moby
    DEBU[2019-09-10T19:09:21.048077205-04:00] backingFs=xfs, projectQuotaSupported=false, indexOff="index=off,"  storage-driver=overlay2
    INFO[2019-09-10T19:09:21.048114325-04:00] [graphdriver] using prior storage driver: overlay2 
    DEBU[2019-09-10T19:09:21.048133271-04:00] Initialized graph driver overlay2            
    DEBU[2019-09-10T19:09:21.088315175-04:00] Max Concurrent Downloads: 3                  
    DEBU[2019-09-10T19:09:21.088350823-04:00] Max Concurrent Uploads: 5                    
    INFO[2019-09-10T19:09:21.088383646-04:00] Loading containers: start.                   
    DEBU[2019-09-10T19:09:21.088470488-04:00] Option Experimental: false                   
    DEBU[2019-09-10T19:09:21.088485680-04:00] Option DefaultDriver: bridge                 
    DEBU[2019-09-10T19:09:21.088497655-04:00] Option DefaultNetwork: bridge                
    DEBU[2019-09-10T19:09:21.088510338-04:00] Network Control Plane MTU: 1500              
    DEBU[2019-09-10T19:09:21.096765929-04:00] processing event stream                       module=libcontainerd namespace=moby
    DEBU[2019-09-10T19:09:21.142207941-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -j DOCKER-ISOLATION] 
    DEBU[2019-09-10T19:09:21.173611383-04:00] Firewalld passthrough: ipv4, [-t nat -D PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:21.193444454-04:00] Firewalld passthrough: ipv4, [-t nat -D OUTPUT -m addrtype --dst-type LOCAL ! --dst 127.0.0.0/8 -j DOCKER] 
    DEBU[2019-09-10T19:09:21.208856420-04:00] Firewalld passthrough: ipv4, [-t nat -D OUTPUT -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:21.233876810-04:00] Firewalld passthrough: ipv4, [-t nat -D PREROUTING] 
    DEBU[2019-09-10T19:09:21.253412009-04:00] Firewalld passthrough: ipv4, [-t nat -D OUTPUT] 
    DEBU[2019-09-10T19:09:21.276982276-04:00] Firewalld passthrough: ipv4, [-t nat -F DOCKER] 
    DEBU[2019-09-10T19:09:21.296707366-04:00] Firewalld passthrough: ipv4, [-t nat -X DOCKER] 
    DEBU[2019-09-10T19:09:21.311675703-04:00] Firewalld passthrough: ipv4, [-t filter -F DOCKER] 
    DEBU[2019-09-10T19:09:21.323685592-04:00] Firewalld passthrough: ipv4, [-t filter -X DOCKER] 
    DEBU[2019-09-10T19:09:21.334838726-04:00] Firewalld passthrough: ipv4, [-t filter -F DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:21.364655291-04:00] Firewalld passthrough: ipv4, [-t filter -X DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:21.380930817-04:00] Firewalld passthrough: ipv4, [-t filter -F DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:21.401089186-04:00] Firewalld passthrough: ipv4, [-t filter -X DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:21.418046785-04:00] Firewalld passthrough: ipv4, [-t filter -F DOCKER-ISOLATION] 
    DEBU[2019-09-10T19:09:21.436602317-04:00] Firewalld passthrough: ipv4, [-t filter -X DOCKER-ISOLATION] 
    DEBU[2019-09-10T19:09:21.448481661-04:00] Firewalld passthrough: ipv4, [-t nat -n -L DOCKER] 
    DEBU[2019-09-10T19:09:21.459170252-04:00] Firewalld passthrough: ipv4, [-t nat -N DOCKER] 
    DEBU[2019-09-10T19:09:21.487091308-04:00] Firewalld passthrough: ipv4, [-t filter -n -L DOCKER] 
    DEBU[2019-09-10T19:09:21.497372484-04:00] Firewalld passthrough: ipv4, [-t filter -n -L DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:21.508256690-04:00] Firewalld passthrough: ipv4, [-t filter -n -L DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:21.526537028-04:00] Firewalld passthrough: ipv4, [-t filter -N DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:21.542430765-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-1 -j RETURN] 
    DEBU[2019-09-10T19:09:21.559233396-04:00] Firewalld passthrough: ipv4, [-A DOCKER-ISOLATION-STAGE-1 -j RETURN] 
    DEBU[2019-09-10T19:09:21.570303923-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-2 -j RETURN] 
    DEBU[2019-09-10T19:09:21.581656201-04:00] Firewalld passthrough: ipv4, [-A DOCKER-ISOLATION-STAGE-2 -j RETURN] 
    DEBU[2019-09-10T19:09:21.625328647-04:00] Firewalld passthrough: ipv4, [-t nat -C POSTROUTING -s 172.18.0.0/16 ! -o br-c95e3032c002 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:21.643104341-04:00] Firewalld passthrough: ipv4, [-t nat -C DOCKER -i br-c95e3032c002 -j RETURN] 
    DEBU[2019-09-10T19:09:21.660439015-04:00] Firewalld passthrough: ipv4, [-t nat -I DOCKER -i br-c95e3032c002 -j RETURN] 
    DEBU[2019-09-10T19:09:21.676194361-04:00] Firewalld passthrough: ipv4, [-D FORWARD -i br-c95e3032c002 -o br-c95e3032c002 -j DROP] 
    DEBU[2019-09-10T19:09:21.688225381-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i br-c95e3032c002 -o br-c95e3032c002 -j ACCEPT] 
    DEBU[2019-09-10T19:09:21.701481371-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i br-c95e3032c002 ! -o br-c95e3032c002 -j ACCEPT] 
    DEBU[2019-09-10T19:09:21.713247598-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:21.743559949-04:00] Firewalld passthrough: ipv4, [-t nat -A PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:21.757171540-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:21.774589984-04:00] Firewalld passthrough: ipv4, [-t nat -A OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:21.801970042-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c95e3032c002 -j DOCKER] 
    DEBU[2019-09-10T19:09:21.818958467-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c95e3032c002 -j DOCKER] 
    DEBU[2019-09-10T19:09:21.830677197-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c95e3032c002 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:21.841609579-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c95e3032c002 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:21.851487186-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:21.873840848-04:00] Firewalld passthrough: ipv4, [-D FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:21.885776273-04:00] Firewalld passthrough: ipv4, [-I FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:21.901270576-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-1 -i br-c95e3032c002 ! -o br-c95e3032c002 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:21.927549587-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-1 -i br-c95e3032c002 ! -o br-c95e3032c002 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:21.944968263-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-2 -o br-c95e3032c002 -j DROP] 
    DEBU[2019-09-10T19:09:21.958142116-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-2 -o br-c95e3032c002 -j DROP] 
    DEBU[2019-09-10T19:09:21.986542616-04:00] Network (c95e303) restored                   
    DEBU[2019-09-10T19:09:21.986964468-04:00] Firewalld passthrough: ipv4, [-t nat -C POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:22.000073613-04:00] Firewalld passthrough: ipv4, [-t nat -C DOCKER -i docker0 -j RETURN] 
    DEBU[2019-09-10T19:09:22.013806658-04:00] Firewalld passthrough: ipv4, [-t nat -I DOCKER -i docker0 -j RETURN] 
    DEBU[2019-09-10T19:09:22.034960372-04:00] Firewalld passthrough: ipv4, [-D FORWARD -i docker0 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:22.054005874-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i docker0 -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.065941074-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i docker0 ! -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.076928109-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:22.087631234-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:22.113844291-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:22.125737656-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:22.141833592-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.160815843-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.175892652-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.192334853-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.204772325-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:22.230267833-04:00] Firewalld passthrough: ipv4, [-D FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:22.242663719-04:00] Firewalld passthrough: ipv4, [-I FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:22.254637352-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:22.277521551-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:22.304312108-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:22.319143074-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:22.329543018-04:00] Network (199442c) restored                   
    DEBU[2019-09-10T19:09:22.329855198-04:00] Firewalld passthrough: ipv4, [-t nat -C POSTROUTING -s 172.19.0.0/16 ! -o br-c671d281fed4 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:22.367955997-04:00] Firewalld passthrough: ipv4, [-t nat -C DOCKER -i br-c671d281fed4 -j RETURN] 
    DEBU[2019-09-10T19:09:22.391815959-04:00] Firewalld passthrough: ipv4, [-t nat -I DOCKER -i br-c671d281fed4 -j RETURN] 
    DEBU[2019-09-10T19:09:22.406514721-04:00] Firewalld passthrough: ipv4, [-D FORWARD -i br-c671d281fed4 -o br-c671d281fed4 -j DROP] 
    DEBU[2019-09-10T19:09:22.437095050-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i br-c671d281fed4 -o br-c671d281fed4 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.450899386-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i br-c671d281fed4 ! -o br-c671d281fed4 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.462205084-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:22.482531260-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:22.501478504-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:22.525395370-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:22.538157778-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c671d281fed4 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.569920596-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c671d281fed4 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.581883355-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c671d281fed4 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.601790097-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o br-c671d281fed4 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.619942885-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:22.635844738-04:00] Firewalld passthrough: ipv4, [-D FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:22.646561738-04:00] Firewalld passthrough: ipv4, [-I FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:22.658359055-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-1 -i br-c671d281fed4 ! -o br-c671d281fed4 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:22.688171925-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-1 -i br-c671d281fed4 ! -o br-c671d281fed4 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:22.703698426-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-2 -o br-c671d281fed4 -j DROP] 
    DEBU[2019-09-10T19:09:22.726267647-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-2 -o br-c671d281fed4 -j DROP] 
    DEBU[2019-09-10T19:09:22.741757992-04:00] Network (c671d28) restored                   
    DEBU[2019-09-10T19:09:22.743942712-04:00] Allocating IPv4 pools for network native_instruments_default (c671d281fed427d2b3c7344740032460632ef4739d68736fc7567c2d3a27ef42) 
    DEBU[2019-09-10T19:09:22.744052718-04:00] RequestPool(LocalDefault, 172.19.0.0/16, , map[], false) 
    DEBU[2019-09-10T19:09:22.744173041-04:00] RequestAddress(LocalDefault/172.19.0.0/16, 172.19.0.1, map[RequestAddressType:com.docker.network.gateway]) 
    DEBU[2019-09-10T19:09:22.744216532-04:00] Request address PoolID:172.19.0.0/16 App: ipam/default/data, ID: LocalDefault/172.19.0.0/16, DBIndex: 0x0, Bits: 65536, Unselected: 65534, Sequence: (0x80000000, 1)->(0x0, 2046)->(0x1, 1)->end Curr:0 Serial:false PrefAddress:172.19.0.1  
    DEBU[2019-09-10T19:09:22.744441502-04:00] Allocating IPv4 pools for network ni_final_default (c95e3032c0022300b3fa2a53ec006ec34dbc52ee3401e406c843ebcd6fdab2d0) 
    DEBU[2019-09-10T19:09:22.744491816-04:00] RequestPool(LocalDefault, 172.18.0.0/16, , map[], false) 
    DEBU[2019-09-10T19:09:22.744606838-04:00] RequestAddress(LocalDefault/172.18.0.0/16, 172.18.0.1, map[RequestAddressType:com.docker.network.gateway]) 
    DEBU[2019-09-10T19:09:22.744709018-04:00] Request address PoolID:172.18.0.0/16 App: ipam/default/data, ID: LocalDefault/172.18.0.0/16, DBIndex: 0x0, Bits: 65536, Unselected: 65534, Sequence: (0x80000000, 1)->(0x0, 2046)->(0x1, 1)->end Curr:0 Serial:false PrefAddress:172.18.0.1  
    DEBU[2019-09-10T19:09:22.746753024-04:00] Allocating IPv4 pools for network bridge (199442ca00aa7ab4a59d3d86b780420a689a6f7cadb70c20f5e70c3eea546a43) 
    DEBU[2019-09-10T19:09:22.746810546-04:00] RequestPool(LocalDefault, 172.17.0.0/16, , map[], false) 
    DEBU[2019-09-10T19:09:22.746859033-04:00] RequestAddress(LocalDefault/172.17.0.0/16, 172.17.0.1, map[RequestAddressType:com.docker.network.gateway]) 
    DEBU[2019-09-10T19:09:22.746920908-04:00] Request address PoolID:172.17.0.0/16 App: ipam/default/data, ID: LocalDefault/172.17.0.0/16, DBIndex: 0x0, Bits: 65536, Unselected: 65534, Sequence: (0x80000000, 1)->(0x0, 2046)->(0x1, 1)->end Curr:0 Serial:false PrefAddress:172.17.0.1  
    DEBU[2019-09-10T19:09:22.759109395-04:00] Firewalld passthrough: ipv4, [-t nat -C POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:22.783686907-04:00] Firewalld passthrough: ipv4, [-t nat -D POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:22.814344474-04:00] Firewalld passthrough: ipv4, [-t nat -C DOCKER -i docker0 -j RETURN] 
    DEBU[2019-09-10T19:09:22.833792598-04:00] Firewalld passthrough: ipv4, [-t nat -D DOCKER -i docker0 -j RETURN] 
    DEBU[2019-09-10T19:09:22.847200792-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i docker0 -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.857903351-04:00] Firewalld passthrough: ipv4, [-D FORWARD -i docker0 -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.870650419-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i docker0 ! -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.895045516-04:00] Firewalld passthrough: ipv4, [-D FORWARD -i docker0 ! -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.908256249-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.921426027-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.942730999-04:00] Firewalld passthrough: ipv4, [-D FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:22.957744868-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:22.971619775-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.001539499-04:00] Firewalld passthrough: ipv4, [-D FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.022153600-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:23.041733876-04:00] Firewalld passthrough: ipv4, [-t filter -D DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:23.064098151-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:23.081195675-04:00] Firewalld passthrough: ipv4, [-t filter -D DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:23.113431444-04:00] releasing IPv4 pools from network bridge (199442ca00aa7ab4a59d3d86b780420a689a6f7cadb70c20f5e70c3eea546a43) 
    DEBU[2019-09-10T19:09:23.113467033-04:00] ReleaseAddress(LocalDefault/172.17.0.0/16, 172.17.0.1) 
    DEBU[2019-09-10T19:09:23.113493529-04:00] Released address PoolID:LocalDefault/172.17.0.0/16, Address:172.17.0.1 Sequence:App: ipam/default/data, ID: LocalDefault/172.17.0.0/16, DBIndex: 0x0, Bits: 65536, Unselected: 65533, Sequence: (0xc0000000, 1)->(0x0, 2046)->(0x1, 1)->end Curr:0 
    DEBU[2019-09-10T19:09:23.113515637-04:00] ReleasePool(LocalDefault/172.17.0.0/16)      
    DEBU[2019-09-10T19:09:23.119558592-04:00] cleanupServiceDiscovery for network:199442ca00aa7ab4a59d3d86b780420a689a6f7cadb70c20f5e70c3eea546a43 
    INFO[2019-09-10T19:09:23.121847622-04:00] Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address 
    DEBU[2019-09-10T19:09:23.121920254-04:00] Allocating IPv4 pools for network bridge (679c44de79cf6f4b0249dfb0ec7253ac5a056a9e58f0c6849d4dfdd9bd392998) 
    DEBU[2019-09-10T19:09:23.121940907-04:00] RequestPool(LocalDefault, 172.17.0.0/16, , map[], false) 
    DEBU[2019-09-10T19:09:23.121972915-04:00] RequestAddress(LocalDefault/172.17.0.0/16, 172.17.0.1, map[RequestAddressType:com.docker.network.gateway]) 
    DEBU[2019-09-10T19:09:23.122008793-04:00] Request address PoolID:172.17.0.0/16 App: ipam/default/data, ID: LocalDefault/172.17.0.0/16, DBIndex: 0x0, Bits: 65536, Unselected: 65534, Sequence: (0x80000000, 1)->(0x0, 2046)->(0x1, 1)->end Curr:0 Serial:false PrefAddress:172.17.0.1  
    DEBU[2019-09-10T19:09:23.122485973-04:00] Firewalld passthrough: ipv4, [-t nat -C POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:23.144103718-04:00] Firewalld passthrough: ipv4, [-t nat -I POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE] 
    DEBU[2019-09-10T19:09:23.163867669-04:00] Firewalld passthrough: ipv4, [-t nat -C DOCKER -i docker0 -j RETURN] 
    DEBU[2019-09-10T19:09:23.184010919-04:00] Firewalld passthrough: ipv4, [-t nat -I DOCKER -i docker0 -j RETURN] 
    DEBU[2019-09-10T19:09:23.194321222-04:00] Firewalld passthrough: ipv4, [-D FORWARD -i docker0 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:23.206348105-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i docker0 -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.216932389-04:00] Firewalld passthrough: ipv4, [-I FORWARD -i docker0 -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.239767735-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -i docker0 ! -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.251867445-04:00] Firewalld passthrough: ipv4, [-I FORWARD -i docker0 ! -o docker0 -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.267255480-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:23.283113279-04:00] Firewalld passthrough: ipv4, [-t nat -C PREROUTING -m addrtype --dst-type LOCAL -j DOCKER] 
    DEBU[2019-09-10T19:09:23.299941886-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:23.313542611-04:00] Firewalld passthrough: ipv4, [-t nat -C OUTPUT -m addrtype --dst-type LOCAL -j DOCKER ! --dst 127.0.0.0/8] 
    DEBU[2019-09-10T19:09:23.326712211-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:23.357903923-04:00] Firewalld passthrough: ipv4, [-I FORWARD -o docker0 -j DOCKER] 
    DEBU[2019-09-10T19:09:23.371256060-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.396538837-04:00] Firewalld passthrough: ipv4, [-I FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT] 
    DEBU[2019-09-10T19:09:23.415500046-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:23.428498676-04:00] Firewalld passthrough: ipv4, [-D FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:23.438832682-04:00] Firewalld passthrough: ipv4, [-I FORWARD -j DOCKER-ISOLATION-STAGE-1] 
    DEBU[2019-09-10T19:09:23.448834247-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:23.460958015-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-1 -i docker0 ! -o docker0 -j DOCKER-ISOLATION-STAGE-2] 
    DEBU[2019-09-10T19:09:23.472374932-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:23.484444691-04:00] Firewalld passthrough: ipv4, [-t filter -I DOCKER-ISOLATION-STAGE-2 -o docker0 -j DROP] 
    DEBU[2019-09-10T19:09:23.497550483-04:00] Firewalld passthrough: ipv4, [-t filter -n -L DOCKER-USER] 
    DEBU[2019-09-10T19:09:23.508686923-04:00] Firewalld passthrough: ipv4, [-t filter -C DOCKER-USER -j RETURN] 
    DEBU[2019-09-10T19:09:23.522200218-04:00] Firewalld passthrough: ipv4, [-t filter -C FORWARD -j DOCKER-USER] 
    DEBU[2019-09-10T19:09:23.544393497-04:00] Firewalld passthrough: ipv4, [-D FORWARD -j DOCKER-USER] 
    DEBU[2019-09-10T19:09:23.563576023-04:00] Firewalld passthrough: ipv4, [-I FORWARD -j DOCKER-USER] 
    INFO[2019-09-10T19:09:23.577433060-04:00] Loading containers: done.                    
    INFO[2019-09-10T19:09:23.815348004-04:00] Docker daemon                                 commit=74b1e89 graphdriver(s)=overlay2 version=19.03.1
    INFO[2019-09-10T19:09:23.815832538-04:00] Daemon has completed initialization          
    DEBU[2019-09-10T19:09:23.841539136-04:00] Registering routers                          
    DEBU[2019-09-10T19:09:23.841610060-04:00] Registering GET, /containers/{name:.*}/checkpoints 
    DEBU[2019-09-10T19:09:23.841853179-04:00] Registering POST, /containers/{name:.*}/checkpoints 
    DEBU[2019-09-10T19:09:23.841933780-04:00] Registering DELETE, /containers/{name}/checkpoints/{checkpoint} 
    DEBU[2019-09-10T19:09:23.842106393-04:00] Registering HEAD, /containers/{name:.*}/archive 
    DEBU[2019-09-10T19:09:23.842212332-04:00] Registering GET, /containers/json            
    DEBU[2019-09-10T19:09:23.842269859-04:00] Registering GET, /containers/{name:.*}/export 
    DEBU[2019-09-10T19:09:23.842356175-04:00] Registering GET, /containers/{name:.*}/changes 
    DEBU[2019-09-10T19:09:23.842431941-04:00] Registering GET, /containers/{name:.*}/json  
    DEBU[2019-09-10T19:09:23.842495412-04:00] Registering GET, /containers/{name:.*}/top   
    DEBU[2019-09-10T19:09:23.842641263-04:00] Registering GET, /containers/{name:.*}/logs  
    DEBU[2019-09-10T19:09:23.842813812-04:00] Registering GET, /containers/{name:.*}/stats 
    DEBU[2019-09-10T19:09:23.842889396-04:00] Registering GET, /containers/{name:.*}/attach/ws 
    DEBU[2019-09-10T19:09:23.842967946-04:00] Registering GET, /exec/{id:.*}/json          
    DEBU[2019-09-10T19:09:23.843055700-04:00] Registering GET, /containers/{name:.*}/archive 
    DEBU[2019-09-10T19:09:23.843147158-04:00] Registering POST, /containers/create         
    DEBU[2019-09-10T19:09:23.843237429-04:00] Registering POST, /containers/{name:.*}/kill 
    DEBU[2019-09-10T19:09:23.843360406-04:00] Registering POST, /containers/{name:.*}/pause 
    DEBU[2019-09-10T19:09:23.843499369-04:00] Registering POST, /containers/{name:.*}/unpause 
    DEBU[2019-09-10T19:09:23.843610988-04:00] Registering POST, /containers/{name:.*}/restart 
    DEBU[2019-09-10T19:09:23.843690902-04:00] Registering POST, /containers/{name:.*}/start 
    DEBU[2019-09-10T19:09:23.843759672-04:00] Registering POST, /containers/{name:.*}/stop 
    DEBU[2019-09-10T19:09:23.843817670-04:00] Registering POST, /containers/{name:.*}/wait 
    DEBU[2019-09-10T19:09:23.843888593-04:00] Registering POST, /containers/{name:.*}/resize 
    DEBU[2019-09-10T19:09:23.844067992-04:00] Registering POST, /containers/{name:.*}/attach 
    DEBU[2019-09-10T19:09:23.844196195-04:00] Registering POST, /containers/{name:.*}/copy 
    DEBU[2019-09-10T19:09:23.844311725-04:00] Registering POST, /containers/{name:.*}/exec 
    DEBU[2019-09-10T19:09:23.844411254-04:00] Registering POST, /exec/{name:.*}/start      
    DEBU[2019-09-10T19:09:23.844477610-04:00] Registering POST, /exec/{name:.*}/resize     
    DEBU[2019-09-10T19:09:23.844532000-04:00] Registering POST, /containers/{name:.*}/rename 
    DEBU[2019-09-10T19:09:23.844635580-04:00] Registering POST, /containers/{name:.*}/update 
    DEBU[2019-09-10T19:09:23.844689108-04:00] Registering POST, /containers/prune          
    DEBU[2019-09-10T19:09:23.844733645-04:00] Registering POST, /commit                    
    DEBU[2019-09-10T19:09:23.844778793-04:00] Registering PUT, /containers/{name:.*}/archive 
    DEBU[2019-09-10T19:09:23.844836151-04:00] Registering DELETE, /containers/{name:.*}    
    DEBU[2019-09-10T19:09:23.844913551-04:00] Registering GET, /images/json                
    DEBU[2019-09-10T19:09:23.844978948-04:00] Registering GET, /images/search              
    DEBU[2019-09-10T19:09:23.845014189-04:00] Registering GET, /images/get                 
    DEBU[2019-09-10T19:09:23.845045740-04:00] Registering GET, /images/{name:.*}/get       
    DEBU[2019-09-10T19:09:23.845111054-04:00] Registering GET, /images/{name:.*}/history   
    DEBU[2019-09-10T19:09:23.845160878-04:00] Registering GET, /images/{name:.*}/json      
    DEBU[2019-09-10T19:09:23.845218344-04:00] Registering POST, /images/load               
    DEBU[2019-09-10T19:09:23.845306491-04:00] Registering POST, /images/create             
    DEBU[2019-09-10T19:09:23.845369685-04:00] Registering POST, /images/{name:.*}/push     
    DEBU[2019-09-10T19:09:23.845436154-04:00] Registering POST, /images/{name:.*}/tag      
    DEBU[2019-09-10T19:09:23.845641596-04:00] Registering POST, /images/prune              
    DEBU[2019-09-10T19:09:23.845691567-04:00] Registering DELETE, /images/{name:.*}        
    DEBU[2019-09-10T19:09:23.845756033-04:00] Registering OPTIONS, /{anyroute:.*}          
    DEBU[2019-09-10T19:09:23.845816903-04:00] Registering GET, /_ping                      
    DEBU[2019-09-10T19:09:23.845871986-04:00] Registering HEAD, /_ping                     
    DEBU[2019-09-10T19:09:23.845908678-04:00] Registering GET, /events                     
    DEBU[2019-09-10T19:09:23.845979570-04:00] Registering GET, /info                       
    DEBU[2019-09-10T19:09:23.846069631-04:00] Registering GET, /version                    
    DEBU[2019-09-10T19:09:23.846137474-04:00] Registering GET, /system/df                  
    DEBU[2019-09-10T19:09:23.846198131-04:00] Registering POST, /auth                      
    DEBU[2019-09-10T19:09:23.846238614-04:00] Registering GET, /volumes                    
    DEBU[2019-09-10T19:09:23.846279790-04:00] Registering GET, /volumes/{name:.*}          
    DEBU[2019-09-10T19:09:23.846338554-04:00] Registering POST, /volumes/create            
    DEBU[2019-09-10T19:09:23.846394563-04:00] Registering POST, /volumes/prune             
    DEBU[2019-09-10T19:09:23.846429423-04:00] Registering DELETE, /volumes/{name:.*}       
    DEBU[2019-09-10T19:09:23.846538717-04:00] Registering POST, /build                     
    DEBU[2019-09-10T19:09:23.846584970-04:00] Registering POST, /build/prune               
    DEBU[2019-09-10T19:09:23.846707753-04:00] Registering POST, /build/cancel              
    DEBU[2019-09-10T19:09:23.846768238-04:00] Registering POST, /session                   
    DEBU[2019-09-10T19:09:23.846854566-04:00] Registering POST, /swarm/init                
    DEBU[2019-09-10T19:09:23.846900267-04:00] Registering POST, /swarm/join                
    DEBU[2019-09-10T19:09:23.846943293-04:00] Registering POST, /swarm/leave               
    DEBU[2019-09-10T19:09:23.847023805-04:00] Registering GET, /swarm                      
    DEBU[2019-09-10T19:09:23.847079692-04:00] Registering GET, /swarm/unlockkey            
    DEBU[2019-09-10T19:09:23.847115698-04:00] Registering POST, /swarm/update              
    DEBU[2019-09-10T19:09:23.847225663-04:00] Registering POST, /swarm/unlock              
    DEBU[2019-09-10T19:09:23.847280136-04:00] Registering GET, /services                   
    DEBU[2019-09-10T19:09:23.847329027-04:00] Registering GET, /services/{id}              
    DEBU[2019-09-10T19:09:23.847383818-04:00] Registering POST, /services/create           
    DEBU[2019-09-10T19:09:23.847459830-04:00] Registering POST, /services/{id}/update      
    DEBU[2019-09-10T19:09:23.847553909-04:00] Registering DELETE, /services/{id}           
    DEBU[2019-09-10T19:09:23.847627612-04:00] Registering GET, /services/{id}/logs         
    DEBU[2019-09-10T19:09:23.847683838-04:00] Registering GET, /nodes                      
    DEBU[2019-09-10T19:09:23.847736686-04:00] Registering GET, /nodes/{id}                 
    DEBU[2019-09-10T19:09:23.847846640-04:00] Registering DELETE, /nodes/{id}              
    DEBU[2019-09-10T19:09:23.847936111-04:00] Registering POST, /nodes/{id}/update         
    DEBU[2019-09-10T19:09:23.848024599-04:00] Registering GET, /tasks                      
    DEBU[2019-09-10T19:09:23.848113906-04:00] Registering GET, /tasks/{id}                 
    DEBU[2019-09-10T19:09:23.848177297-04:00] Registering GET, /tasks/{id}/logs            
    DEBU[2019-09-10T19:09:23.848260331-04:00] Registering GET, /secrets                    
    DEBU[2019-09-10T19:09:23.848310943-04:00] Registering POST, /secrets/create            
    DEBU[2019-09-10T19:09:23.848384915-04:00] Registering DELETE, /secrets/{id}            
    DEBU[2019-09-10T19:09:23.848914198-04:00] Registering GET, /secrets/{id}               
    DEBU[2019-09-10T19:09:23.849971636-04:00] Registering POST, /secrets/{id}/update       
    DEBU[2019-09-10T19:09:23.850135758-04:00] Registering GET, /configs                    
    DEBU[2019-09-10T19:09:23.850423322-04:00] Registering POST, /configs/create            
    DEBU[2019-09-10T19:09:23.850665564-04:00] Registering DELETE, /configs/{id}            
    DEBU[2019-09-10T19:09:23.850927602-04:00] Registering GET, /configs/{id}               
    DEBU[2019-09-10T19:09:23.851302264-04:00] Registering POST, /configs/{id}/update       
    DEBU[2019-09-10T19:09:23.851616442-04:00] Registering GET, /plugins                    
    DEBU[2019-09-10T19:09:23.851926347-04:00] Registering GET, /plugins/{name:.*}/json     
    DEBU[2019-09-10T19:09:23.852205080-04:00] Registering GET, /plugins/privileges         
    DEBU[2019-09-10T19:09:23.852488787-04:00] Registering DELETE, /plugins/{name:.*}       
    DEBU[2019-09-10T19:09:23.853277459-04:00] Registering POST, /plugins/{name:.*}/enable  
    DEBU[2019-09-10T19:09:23.853391638-04:00] Registering POST, /plugins/{name:.*}/disable 
    DEBU[2019-09-10T19:09:23.853778197-04:00] Registering POST, /plugins/pull              
    DEBU[2019-09-10T19:09:23.854029502-04:00] Registering POST, /plugins/{name:.*}/push    
    DEBU[2019-09-10T19:09:23.854356494-04:00] Registering POST, /plugins/{name:.*}/upgrade 
    DEBU[2019-09-10T19:09:23.854652782-04:00] Registering POST, /plugins/{name:.*}/set     
    DEBU[2019-09-10T19:09:23.863705167-04:00] Registering POST, /plugins/create            
    DEBU[2019-09-10T19:09:23.863779770-04:00] Registering GET, /distribution/{name:.*}/json 
    DEBU[2019-09-10T19:09:23.863845688-04:00] Registering POST, /grpc                      
    DEBU[2019-09-10T19:09:23.863883551-04:00] Registering GET, /networks                   
    DEBU[2019-09-10T19:09:23.863962365-04:00] Registering GET, /networks/                  
    DEBU[2019-09-10T19:09:23.864006558-04:00] Registering GET, /networks/{id:.+}           
    DEBU[2019-09-10T19:09:23.864064240-04:00] Registering POST, /networks/create           
    DEBU[2019-09-10T19:09:23.864107242-04:00] Registering POST, /networks/{id:.*}/connect  
    DEBU[2019-09-10T19:09:23.864163857-04:00] Registering POST, /networks/{id:.*}/disconnect 
    DEBU[2019-09-10T19:09:23.864221948-04:00] Registering POST, /networks/prune            
    DEBU[2019-09-10T19:09:23.864268657-04:00] Registering DELETE, /networks/{id:.*}        
    INFO[2019-09-10T19:09:23.864668600-04:00] API listen on 192.168.64.180:2376            
      
    ^CINFO[2019-09-10T19:12:12.022336552-04:00] Processing signal 'interrupt'                
    DEBU[2019-09-10T19:12:12.024424447-04:00] daemon configured with a 15 seconds minimum shutdown timeout 
    DEBU[2019-09-10T19:12:12.024591991-04:00] start clean shutdown of all containers with a 15 seconds timeout... 
    DEBU[2019-09-10T19:12:12.033378757-04:00] Unix socket /var/run/docker/libnetwork/67308021a45d661e02b0c5db957f12f2f72d0492be49cdbe98984d6e1016550c.sock doesn't exist. cannot accept client connections 
    DEBU[2019-09-10T19:12:12.033670315-04:00] Cleaning up old mountid : start.             
    DEBU[2019-09-10T19:12:12.034201319-04:00] Cleaning up old mountid : done.              
    DEBU[2019-09-10T19:12:12.034656954-04:00] Clean shutdown succeeded                     
    INFO[2019-09-10T19:12:12.034697443-04:00] Daemon shutdown complete                     
    [kuvivek@vivekcentos ~]$ 
    [kuvivek@vivekcentos ~]$ 

Since I used debug command It dumps all short of information. Let's use without --debug option.

    [kuvivek@vivekcentos ~]$ sudo dockerd --host tcp://192.168.64.180:2376 
    [sudo] password for kuvivek: 
    INFO[2019-09-10T19:25:25.378915234-04:00] Starting up                                  
    WARN[2019-09-10T19:25:25.380050462-04:00] [!] DON'T BIND ON ANY IP ADDRESS WITHOUT setting --tlsverify IF YOU DON'T KNOW WHAT YOU'RE DOING [!] 
    INFO[2019-09-10T19:25:25.383568404-04:00] parsed scheme: "unix"                         module=grpc
    INFO[2019-09-10T19:25:25.383599889-04:00] scheme "unix" not registered, fallback to default scheme  module=grpc
    INFO[2019-09-10T19:25:25.383629214-04:00] ccResolverWrapper: sending update to cc: {[{unix:///run/containerd/containerd.sock 0  <nil>}] }  module=grpc
    INFO[2019-09-10T19:25:25.383719629-04:00] ClientConn switching balancer to "pick_first"  module=grpc
    INFO[2019-09-10T19:25:25.383857450-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc000611850, CONNECTING  module=grpc
    INFO[2019-09-10T19:25:25.386279052-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc000611850, READY  module=grpc
    INFO[2019-09-10T19:25:25.387621059-04:00] parsed scheme: "unix"                         module=grpc
    INFO[2019-09-10T19:25:25.387721883-04:00] scheme "unix" not registered, fallback to default scheme  module=grpc
    INFO[2019-09-10T19:25:25.387741415-04:00] ccResolverWrapper: sending update to cc: {[{unix:///run/containerd/containerd.sock 0  <nil>}] }  module=grpc
    INFO[2019-09-10T19:25:25.387751274-04:00] ClientConn switching balancer to "pick_first"  module=grpc
    INFO[2019-09-10T19:25:25.387812086-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc0001735f0, CONNECTING  module=grpc
    INFO[2019-09-10T19:25:25.388220459-04:00] pickfirstBalancer: HandleSubConnStateChange: 0xc0001735f0, READY  module=grpc
    INFO[2019-09-10T19:25:25.472213344-04:00] [graphdriver] using prior storage driver: overlay2 
    INFO[2019-09-10T19:25:25.486714964-04:00] Loading containers: start.                   
    INFO[2019-09-10T19:25:26.892379012-04:00] Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address 
    INFO[2019-09-10T19:25:27.260783025-04:00] Loading containers: done.                    
    INFO[2019-09-10T19:25:27.313812896-04:00] Docker daemon                                 commit=74b1e89 graphdriver(s)=overlay2 version=19.03.1
    INFO[2019-09-10T19:25:27.313897531-04:00] Daemon has completed initialization          
    INFO[2019-09-10T19:25:27.378504842-04:00] API listen on 192.168.64.180:2376            

Now in the Other terminal Let's execute the terraform init command

    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ ./terraform init
    
    Initializing the backend...
    
    Initializing provider plugins...
    
    The following providers do not have any version constraints in configuration,
    so the latest version was installed.
    
    To prevent automatic upgrades to new major versions that may contain breaking
    changes, it is recommended to add version = "..." constraints to the
    corresponding provider blocks in configuration, with the constraint strings
    suggested below.
    
    * provider.docker: version = "~> 2.2"
    
    Terraform has been successfully initialized!
    
    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.
    
    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ 


Next step it is suggesting is to execute the terrform plan. Just to get what it is planning to do
Instead we can go one step ahead and apply the plan itself, using the terraform apply

    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ ./terraform apply
    
    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # docker_container.nginx-server will be created
      + resource "docker_container" "nginx-server" {
          + attach           = false
          + bridge           = (known after apply)
          + container_logs   = (known after apply)
          + exit_code        = (known after apply)
          + gateway          = (known after apply)
          + id               = (known after apply)
          + image            = (known after apply)
          + ip_address       = (known after apply)
          + ip_prefix_length = (known after apply)
          + log_driver       = "json-file"
          + logs             = false
          + must_run         = true
          + name             = "nginx-server"
          + network_data     = (known after apply)
          + restart          = "no"
          + rm               = false
          + start            = true
    
          + ports {
              + external = (known after apply)
              + internal = 80
              + ip       = "0.0.0.0"
              + protocol = "tcp"
            }
    
          + volumes {
              + container_path = "/usr/share/nginx/html"
              + host_path      = "/home/scrapbook/tutorial/www"
              + read_only      = true
            }
        }
    
      # docker_image.nginx will be created
      + resource "docker_image" "nginx" {
          + id     = (known after apply)
          + latest = (known after apply)
          + name   = "nginx:1.11-alpine"
        }
    
    Plan: 2 to add, 0 to change, 0 to destroy.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    docker_image.nginx: Creating...
    docker_image.nginx: Creation complete after 9s [id=sha256:bedece1f06cc142829698e6ba8f04d7f92e7f1b94b985e14b65f55e6ae4858c2nginx:1.11-alpine]
    docker_container.nginx-server: Creating...
    docker_container.nginx-server: Creation complete after 2s [id=2fb90768750e4b368b444a253b331c0e48d909d720fbcf90300544584ddd59ea]
    
    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
    [kuvivek@vivekcentos Terraform]$

After running the terraform apply it creates a state file which is mentioned below:

    [kuvivek@vivekcentos Terraform]$ ls
    config.tf  Readme.txt  terraform  terraform.tfstate
    [kuvivek@vivekcentos Terraform]$ cat terraform.tfstate 
    {
      "version": 4,
      "terraform_version": "0.12.8",
      "serial": 3,
      "lineage": "227345d5-c174-32d2-10e4-d69c05bdb72d",
      "outputs": {},
      "resources": [
        {
          "mode": "managed",
          "type": "docker_container",
          "name": "nginx-server",
          "provider": "provider.docker",
          "instances": [
            {
              "schema_version": 1,
              "attributes": {
                "attach": false,
                "bridge": "",
                "capabilities": [],
                "command": null,
                "container_logs": null,
                "cpu_set": null,
                "cpu_shares": null,
                "destroy_grace_seconds": null,
                "devices": [],
                "dns": null,
                "dns_opts": null,
                "dns_search": null,
                "domainname": null,
                "entrypoint": null,
                "env": null,
                "exit_code": null,
                "gateway": "172.17.0.1",
                "healthcheck": [],
                "host": [],
                "hostname": null,
                "id": "2fb90768750e4b368b444a253b331c0e48d909d720fbcf90300544584ddd59ea",
                "image": "sha256:bedece1f06cc142829698e6ba8f04d7f92e7f1b94b985e14b65f55e6ae4858c2",
                "ip_address": "172.17.0.2",
                "ip_prefix_length": 16,
                "labels": null,
                "links": null,
                "log_driver": "json-file",
                "log_opts": null,
                "logs": false,
                "max_retry_count": null,
                "memory": null,
                "memory_swap": null,
                "mounts": [],
                "must_run": true,
                "name": "nginx-server",
                "network_alias": null,
                "network_data": [
                  {
                    "gateway": "172.17.0.1",
                    "ip_address": "172.17.0.2",
                    "ip_prefix_length": 16,
                    "network_name": "bridge"
                  }
                ],
                "network_mode": null,
                "networks": null,
                "networks_advanced": [],
                "pid_mode": null,
                "ports": [
                  {
                    "external": 32768,
                    "internal": 80,
                    "ip": "0.0.0.0",
                    "protocol": "tcp"
                  }
                ],
                "privileged": null,
                "publish_all_ports": null,
                "restart": "no",
                "rm": false,
                "start": true,
                "sysctls": null,
                "tmpfs": null,
                "ulimit": [],
                "upload": [],
                "user": null,
                "userns_mode": null,
                "volumes": [
                  {
                    "container_path": "/usr/share/nginx/html",
                    "from_container": "",
                    "host_path": "/home/scrapbook/tutorial/www",
                    "read_only": true,
                    "volume_name": ""
                  }
                ]
              },
              "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ==",
              "depends_on": [
                "docker_image.nginx"
              ]
            }
          ]
        },
        {
          "mode": "managed",
          "type": "docker_image",
          "name": "nginx",
          "provider": "provider.docker",
          "instances": [
            {
              "schema_version": 0,
              "attributes": {
                "id": "sha256:bedece1f06cc142829698e6ba8f04d7f92e7f1b94b985e14b65f55e6ae4858c2nginx:1.11-alpine",
                "keep_locally": null,
                "latest": "sha256:bedece1f06cc142829698e6ba8f04d7f92e7f1b94b985e14b65f55e6ae4858c2",
                "name": "nginx:1.11-alpine",
                "pull_trigger": null,
                "pull_triggers": null
              },
              "private": "bnVsbA=="
            }
          ]
        }
      ]
    }
    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ 

For getting the docker client and server information now the command will change from 

    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ sudo docker info
    Client:
     Debug Mode: false
    
    Server:
    ERROR: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
    errors pretty printing info
    [kuvivek@vivekcentos Terraform]$

to the new one in which it is looking for docker daemon hosted on the local tcp port 2376 rather than on unix socket by default. 

    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ sudo docker -H 192.168.64.180:2376 info
    Client:
     Debug Mode: false
    
    Server:
     Containers: 1
      Running: 1
      Paused: 0
      Stopped: 0
     Images: 4
     Server Version: 19.03.1
     Storage Driver: overlay2
      Backing Filesystem: xfs
      Supports d_type: true
      Native Overlay Diff: true
     Logging Driver: json-file
     Cgroup Driver: cgroupfs
     Plugins:
      Volume: local
      Network: bridge host ipvlan macvlan null overlay
      Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
     Swarm: inactive
     Runtimes: runc
     Default Runtime: runc
     Init Binary: docker-init
     containerd version: 894b81a4b802e4eb2a91d1ce216b8817763c29fb
     runc version: 425e105d5a03fabd737a126ad93d62a9eeede87f
     init version: fec3683
     Security Options:
      seccomp
       Profile: default
     Kernel Version: 3.10.0-957.27.2.el7.x86_64
     Operating System: CentOS Linux 7 (Core)
     OSType: linux
     Architecture: x86_64
     CPUs: 2
     Total Memory: 1.407GiB
     Name: vivekcentos
     ID: IXZV:ZLX7:62EH:6LMY:7FEJ:FXEI:YKD6:IK5I:EIQF:MCPX:GT2S:QAOP
     Docker Root Dir: /var/lib/docker
     Debug Mode: false
     Username: kuvivek
     Registry: https://index.docker.io/v1/
     Labels:
     Experimental: false
     Insecure Registries:
      127.0.0.0/8
     Live Restore Enabled: false
    
    WARNING: API is accessible on http://192.168.64.180:2376 without encryption.
             Access to the remote API is equivalent to root access on the host. Refer
             to the 'Docker daemon attack surface' section in the documentation for
             more information: https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ 

For checking the container the command is changed to

    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ sudo docker -H 192.168.64.180:2376 ps -a
    [sudo] password for kuvivek: 
    CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                            NAMES
    2fb90768750e        bedece1f06cc        "nginx -g 'daemon of…"   35 minutes ago      Up 35 minutes       443/tcp, 0.0.0.0:32768->80/tcp   nginx-server
    [kuvivek@vivekcentos Terraform]$ 
    [kuvivek@vivekcentos Terraform]$ 



