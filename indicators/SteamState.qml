pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

// One shared view of the Steam windows. Every bar copy binds to this, so
// a click updates all monitors at once.
Singleton {
  id: root

  readonly property string helper: decodeURIComponent(Qt.resolvedUrl("steam-window-hide").toString().replace(/^file:\/\//, ""))

  property bool running: false
  property bool hidden: false

  function refresh() {
    if (!statusProc.running) statusProc.running = true
    else pendingRefresh = true
  }

  // A Hyprland event can land while a status check is still in flight; rerun
  // once it finishes so the newest state wins.
  property bool pendingRefresh: false

  // Keybinding / scripting: omarchy-shell steam-window-hide toggle
  IpcHandler {
    target: "steam-window-hide"

    function toggle(): void {
      root.toggle()
    }

    function refresh(): void {
      root.refresh()
    }
  }

  function toggle() {
    if (!running) return
    hidden = !hidden
    Quickshell.execDetached([helper, "toggle"])
  }

  Process {
    id: statusProc
    command: [root.helper, "status"]
    stdout: StdioCollector {
      onStreamFinished: {
        var parts = text.trim().split(" ")
        root.running = parts[0] === "1"
        root.hidden = parts.length > 1 && parts[1] === "1"
        if (root.pendingRefresh) {
          root.pendingRefresh = false
          root.refresh()
        }
      }
    }
  }

  // Window events drive updates; only re-check on the ones that can change
  // whether Steam windows exist or where they live.
  Connections {
    target: Hyprland
    function onRawEvent(event) {
      switch (event.name) {
      case "openwindow":
      case "closewindow":
      case "movewindowv2":
      case "windowtitlev2":
        root.refresh()
      }
    }
  }

  // Safety net in case an event is missed.
  Timer {
    interval: 10000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.refresh()
  }
}
