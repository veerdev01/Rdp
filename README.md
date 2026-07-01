# Railway par Remote Desktop (noVNC + XFCE)

## Deploy kaise karein

1. Ye saari files (`Dockerfile`, `xstartup`, `start.sh`, `railway.json`) ek GitHub repo mein daalo.
2. Railway.app par jaake **New Project → Deploy from GitHub repo** select karo, apna repo choose karo.
3. Railway automatically Dockerfile detect kar lega.
4. **Settings → Networking** mein jaake ek **Public Domain** generate karo — Railway apne aap `$PORT` env variable set kar dega, tumhe kuch alag se karne ki zarurat nahi.
5. **Variables** tab mein jaake ek environment variable add karo:
   - `VNC_PASSWORD` = tumhara custom password (default `changeme123` hai, ise zaroor badlo)
6. Deploy hone ke baad, generated domain (jaise `https://xyz.up.railway.app`) ko browser mein kholo — tumhe XFCE desktop dikhega, password dalke login karo.

## Important notes

- Ye **noVNC** based hai, real Windows RDP nahi — kyunki Railway sirf ek HTTP port expose karta hai, raw RDP protocol (port 3389) nahi chal sakta.
- Railway ke servers US/EU/Asia regions mein hote hain — India-specific region option available nahi hai. Agar tumhe strictly Indian IP chahiye, ye platform (Railway) is requirement ko fulfill nahi karega — koi Indian VPS provider (jaise DigitalOcean Bangalore, AWS Mumbai, ya local Indian VPS company) use karna padega.
- Free tier resources limited hote hain — desktop thoda slow chal sakta hai, especially browser (Firefox) heavy hai.
- Security: password strong rakho, aur agar public repo hai to `VNC_PASSWORD` ko hardcode mat karo — Railway ke Variables tab mein hi set karo.

## Resolution/customization
- `Dockerfile` mein `RESOLUTION=1280x720` env change karke screen size badal sakte ho.
- Aur apps chahiye (VS Code, LibreOffice, etc.) to Dockerfile mein `apt-get install` line mein add kar do.
