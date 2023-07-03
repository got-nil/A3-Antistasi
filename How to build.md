# How to build (Mod)
## Common setup
* install Arma 3 Tools in the same steam library that Arma 3 is installed
## Steps
### First Time
- Run `AntistasiBuilder.exe` once, it creates an `AntistasiBuilder.cfg` next to it
- Add the path to your Arma 3 Tools after `-a3ToolsDir=` (mine becomes `-a3ToolsDir="D:\SteamLibrary\steamapps\common\Arma 3 Tools"`)
- Make sure you have the `antistasi.biprivatekey` in `A3A/Keys`

---

### To build
- Run `AntistasiBuilder.exe`. This builds the PBOs to `build/A3A`.

---

### To sign
- Open `DSUtils` through Arma 3 Tools
- Add the `build/A3A/addons` folder as the source directory
- Use the folder button next to `Private key` to select the `antistasi.biprivatekey`
- Select `Override signatures` if you already have signatures in the build folder
- Select `Process files` in the bottom right, then yes when asking if you want to proceed
    - To check if it worked, select `Check signatures` and set `A3A/Keys` as the keys directory and `build/A3A/addons` as the addons directory. There should be no errors if the files are signed correctly.

---

### To upload
- Copy `antistasi.bikey` from `A3A/Keys` to `build/A3A/Keys`
    - ABSOLUTELY <u>__DO NOT__</u> COPY THE `antistasi.biprivatekey` TO ANYWHERE WITHIN `build/A3A` :D
- Open `Publisher` through Arma 3 Tools
- Select `Antistasi - The (Modified) Mod for GNil` on the left
- On the far right of the line labeled `Mod content:`, select the folder icon and select the `build/A3A` folder.
    - It should then say "Mod content strcture seems to be valid. (no extensions) all signed"
- Tick the box "I agree with Steamworks license" if you want to be able to update the mod
- Press the update button
    - It may or may not freeze at 100%, just check the workshop page to see if it actually update
    - You can also zip the `build/A3A` folder then send it to morg <3 so that he can update the server