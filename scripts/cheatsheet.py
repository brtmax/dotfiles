import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

window = Gtk.Window()
window.set_default_size(400, 800)
window.set_decorated(False)
window.set_keep_above(True)
window.modify_bg(Gtk.StateType.NORMAL, Gdk.color_parse("rgba(0,0,0,0.6)"))

label = Gtk.Label(label=open("~/notes/cheatsheet_1.txt").read())
window.add(label)
window.show_all()
Gtk.main()
