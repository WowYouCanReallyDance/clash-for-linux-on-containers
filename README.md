# clash-for-linux-on-containers
Run clash on podman or docker, all that based on project clash-for-linux

# How to use it?
1. Run the command on your terminal cloning this repo: `git clone `
2. Edit the file .env to puts your clash-subscribe-url
3. Change to repo dir: `cd clash-for-linux-on-containers`
4. Build image with podman: `podman build -t clash-local/clash-one .` (OR docker as you like)
5. Run it: `podman run -itd --name clash-local -p 9090:9090 -p 7890:7890 clash-one:latest`
6. Visit dashboard in your brower with url: `<host_ip>:9090/ui`
