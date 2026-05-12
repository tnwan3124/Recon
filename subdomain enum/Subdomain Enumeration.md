# Subdomain Enumeration

Mục tiêu là thu thập các subdomain bằng các tool có sẵn

### Subfinder (đã dùng shodan,fofa,chaos,dnsdumpster,urlscan,virustotal,zoomeyeapi)

```tsx
subfinder -d hertz.com -s shodan,fofa,chaos,dnsdumpster,urlscan,virustotal,zoomeyeapi  -silent -o subfinder.txt

309
```

crt

```tsx
curl -s "https://crt.sh/?q=%25.target.com&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | anew crtsh_subs.txt

727
```

github

```tsx
python github-subdomains.py -d hertz.com -t YOUR TOKEN

34
```

sublist3r

```tsx
sublist3r -d hertz.com     

8           
```

### Gộp các Subdomain này thành Subdomain_Enum.txt

```tsx
cat crtsh_subs.txt github_subs.txt sublist3r.txt total_subfinder.txt | sort -u > subdomain_enum.txt

927
```