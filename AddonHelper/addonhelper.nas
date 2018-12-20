# Aircraft Config Center Addon Helper
# Joshua Davidson (it0uchpods)

# Copyright (c) 2018 Joshua Davidson (it0uchpods)

setprop("/systems/acconfig/md-10-revision", 0);
setprop("/systems/acconfig/md-10-new-revision", 0);
setprop("/systems/acconfig/md-10-out-of-date", 0);
var update_dlg = gui.Dialog.new("sim/gui/dialogs/acconfig/addonhelper/update/dialog", "Aircraft/IDG-MD-10X/AddonHelper/update.xml");
setprop("/systems/acconfig/md-10-incompatible", 1); # Assume incompatible until we know for sure.

http.load("https://raw.githubusercontent.com/it0uchpods/IDG-MD-10X/master/revision.txt").done(func(r) setprop("/systems/acconfig/md-10-new-revision", r.response));
var revisionFile = (getprop("/sim/aircraft-dir") ~ "/revision.txt");
var current_revision = io.readfile(revisionFile);
print("IDG MD-10X Revision: " ~ current_revision);
setprop("/systems/acconfig/md-10-revision", current_revision);
var revisionMD11MinFile = (getprop("/sim/aircraft-dir") ~ "/revision-md-11-min.txt");
var MD11min_revision = io.readfile(revisionMD11MinFile);
setprop("/systems/acconfig/md-11-min-revision", MD11min_revision);

setlistener("/systems/acconfig/md-10-new-revision", func {
	if (getprop("/systems/acconfig/md-10-new-revision") > current_revision) {
		setprop("/systems/acconfig/md-10-out-of-date", 1);
	} else {
		setprop("/systems/acconfig/md-10-out-of-date", 0);
	}
});

if (getprop("/systems/acconfig/revision") >= MD11min_revision) {
	setprop("/systems/acconfig/md-10-incompatible", 0);
}

setlistener("/sim/signals/fdm-initialized", func {
	if (getprop("/systems/acconfig/md-10-incompatible") == 1) {
		setprop("/systems/acconfig/mismatch-code", "0x14F");
		setprop("/systems/acconfig/mismatch-reason", "IDG-MD-11X is too old! Please update it from the update dialog.");
		print("Mismatch: 0x14F");
		settimer(func {
			acconfig.error_mismatch.open();
			acconfig.welcome_dlg.close();
		}, 0.9);
	}
	if ((getprop("/systems/acconfig/md-10-out-of-date") == 1 and getprop("/systems/acconfig/out-of-date") != 1) or getprop("/systems/acconfig/md-10-incompatible") == 1) {
		settimer(func {
			update_dlg.open();
			acconfig.welcome_dlg.close();
		}, 1);
		print("System: The IDG-MD-10X Addon is out of date!");
	}
});


