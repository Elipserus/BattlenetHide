import QtQuick
import QtQuick.Shapes
import qs.Ui

// Hides the Battle.net client window in a special workspace and brings it
// back. Never lit, so it stays tucked away with the other inactive
// indicators; gone from the bar while Battle.net isn't running.
BarIndicator {
  id: root

  active: false
  visible: belongsInBlock && BattlenetState.running
  inactiveTooltipText: BattlenetState.hidden ? "Mostrar Battle.net" : "Ocultar Battle.net"
  keepSpace: true

  iconComponent: Component {
    Item {
      // Battle.net logo from Simple Icons (CC0), on a 24x24 viewBox, sized
      // to the font the glyph indicators use so it sits level with them.
      Shape {
        anchors.centerIn: parent
        width: 24
        height: 24
        scale: root.fontSize / 24
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
          fillColor: root.foreground
          strokeWidth: -1
          PathSvg {
            path: "M18.94 8.296C15.9 6.892 11.534 6 7.426 6.332c.206-1.36.714-2.308 1.548-2.508 1.148-.275 2.4.48 3.594 1.854.782.102 1.71.28 2.355.429C12.747 2.013 9.828-.282 7.607.565c-1.688.644-2.553 2.97-2.448 6.094-2.2.468-3.915 1.3-5.013 2.495-.056.065-.181.227-.137.305.034.058.146-.008.194-.04 1.274-.89 2.904-1.373 5.027-1.676.303 3.333 1.713 7.56 4.055 10.952-1.28.502-2.356.536-2.946-.087-.812-.856-.784-2.318-.19-4.04a26.764 26.764 0 0 1-.807-2.254c-2.459 3.934-2.986 7.610-1.143 9.110 1.402 1.140 3.847.725 6.502-.926 1.505 1.672 3.083 2.740 4.667 3.094.084.015.287.043.332-.034.034-.06-.08-.124-.131-.149-1.408-.657-2.640-1.828-3.964-3.515 2.735-1.929 5.691-5.263 7.457-8.988 1.076.86 1.640 1.773 1.398 2.595-.336 1.131-1.615 1.840-3.403 2.185a27.697 27.697 0 0 1-1.548 1.826c4.634.16 8.080-1.220 8.458-3.565.286-1.786-1.295-3.696-4.053-5.170.696-2.139.832-4.040.346-5.588-.029-.08-.106-.270-.196-.270-.068 0-.067.130-.063.187.135 1.547-.263 3.200-1.062 5.190zm-8.533 9.869c-1.960-3.145-3.090-6.849-3.082-10.594 3.702-.124 7.474.748 10.714 2.627-1.743 3.269-4.385 6.100-7.633 7.966h.001z"
          }
        }
      }
    }
  }

  onPressed: function() { BattlenetState.toggle() }
}
