# Launcher Hide

Indicadores para la barra de [Omarchy](https://omarchy.org/) que ocultan con un clic las ventanas de **Battle.net** y **Steam**, y las vuelven a mostrar con otro. Inspirado en [SteamHide](https://github.com/michaelsucks/SteamHide).

![Launcher Hide](preview.png)

## Características

- Se integran en el grupo de indicadores central de la barra (junto a dictado, grabar pantalla, etc.) y se ocultan con él hasta que pasas el ratón por encima
- Muestran el logo de cada launcher, con el mismo tamaño y opacidad que el resto de indicadores
- Cada indicador solo aparece mientras su launcher está abierto
- Solo ocultan las ventanas del cliente; los juegos lanzados desde ellos no se tocan
- Al mostrarlas, las ventanas vuelven al workspace en el que estés

## Instalación

```bash
git clone https://github.com/Elipserus/LauncherHide
cd LauncherHide
./install              # Battle.net y Steam
./install battlenet    # solo Battle.net
./install steam        # solo Steam
```

El grupo de indicadores es el widget `omarchy.indicators` de Omarchy, que solo carga indicadores de su propia carpeta. Por eso el instalador lo clona en `~/.config/omarchy/plugins/$USER.indicators` con `omarchy plugin clone` (la barra pasa a usar el clon) y le añade los indicadores elegidos. Si ya tienes ese clon, lo reutiliza.

Ten en cuenta que el clon no recibe los cambios que Omarchy haga en sus indicadores originales en futuras actualizaciones.

Si tu entrada de indicadores en `~/.config/omarchy/shell.json` define `items`, añade ahí `Battlenet` y/o `Steam`.

## Desinstalación

```bash
./uninstall              # Battle.net y Steam
./uninstall battlenet    # solo Battle.net
./uninstall steam        # solo Steam
```

Esto quita los indicadores del clon. Para volver por completo a los indicadores originales de Omarchy:

```bash
omarchy plugin remove $USER.indicators
```

## Uso

Pasa el ratón por el grupo de indicadores del centro de la barra y haz clic en el logo de Battle.net o de Steam para ocultar sus ventanas. Vuelve a hacer clic para mostrarlas.

### Atajos de teclado y scripts

Cada indicador expone un destino IPC, así que puedes asignarlo a una tecla en `~/.config/hypr/bindings.lua`:

```bash
omarchy-shell battlenet-hide toggle
omarchy-shell steam-window-hide toggle
```

`refresh` en lugar de `toggle` fuerza a releer el estado.

Los scripts incluidos también funcionan por sí solos:

```bash
./indicators/battlenet-hide status      # muestra "<abierto> <oculto>", p. ej. "1 0"
./indicators/battlenet-hide hide        # oculta
./indicators/battlenet-hide show        # muestra
./indicators/battlenet-hide toggle      # alterna
./indicators/steam-window-hide status   # igual, para Steam
```

## Cómo funciona

- **Battle.net** se ejecuta con Proton y la clase de ventana `steam_app_battlenet`, que comparte con los juegos que lanza. El script elige las ventanas del cliente por su título `Battle.net`.
- **Steam** usa la clase `steam` para todas sus ventanas (biblioteca, lista de amigos, chats), mientras que los juegos usan `steam_app_<id>`, así que basta con esa clase.

Para ocultarlas, las ventanas se mueven a un workspace especial (`special:battlenet` o `special:steam`); para mostrarlas, vuelven al workspace activo. Los indicadores se actualizan con los eventos de ventana de Hyprland.

## Requisitos

- Omarchy con el shell basado en Quickshell y la configuración de Hyprland en Lua
- Battle.net instalado mediante Omarchy (`omarchy-launch-battlenet`) y/o Steam
- `jq`

## Créditos

Logos de [Simple Icons](https://simpleicons.org/) (CC0). Battle.net es una marca de Blizzard Entertainment y Steam es una marca de Valve Corporation; este proyecto no está afiliado a ninguna de ellas.

## Licencia

MIT
