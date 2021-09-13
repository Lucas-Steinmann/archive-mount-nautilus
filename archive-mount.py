import os
from gi.repository import Nautilus, GObject, Gio
import subprocess

SUPPORTED_FORMATS = (
        'application/zip', 'application/x-tar', 
        'application/x-bzip2', 'application/gzip', 
        'application/x-lzip', 'application/x-xz', 
        'application/x-7z-compressed', 'application/java-archive',
        'application/x-rar-compressed', 'application/x-xar', 
        'application/x-compressed-tar', 'application/x-xz-compressed-tar',
        'application/epub+zip'
)
gvfsd_archive_locations = (
    '/usr/lib/gvfs/gvfsd-archive',
    '/usr/libexec/gvfsd-archive',
    '/usr/lib/gvfsd-archive',
)

class MountArchiveExtension(GObject.GObject, Nautilus.MenuProvider):
    def __init__(self):
        pass
    
    def menu_activate_cb(self, menu, file):
        if file.is_gone():
            return
        file_location = file.get_location().get_path()
        for gvfsd_archive in gvfsd_archive_locations:
            if os.path.exists(gvfsd_archive):
                break
        else:
            return
        args = [gvfsd_archive, 'file=' + file_location]

        subprocess.Popen(args)
        
    def get_file_items(self, window, files):
        if len(files) != 1:
            return

        file = files[0]

        # We're only going to put ourselves on archive context menus
        if not file.get_mime_type() in SUPPORTED_FORMATS:
            return

        # Gnome can only handle file:
        # In the future we might want to copy the file locally
        if file.get_uri_scheme() != 'file':
            return

        item = Nautilus.MenuItem(name='Nautilus::mount_archive',
                                 label='Archiv einhängen',
                                 tip='Archiv mit FUSE einhängen.')
        item.connect('activate', self.menu_activate_cb, file)
        return item,

    # Current versions of Nautilus will throw a warning if get_background_items
    # isn't present
    def get_background_items(self, window, file):
        return None

