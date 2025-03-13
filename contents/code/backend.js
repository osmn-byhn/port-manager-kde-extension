var portManager = {
    getPortList: function() {
        var proc = new Process();
        proc.exec("ss -tulnp | awk 'NR>1 {print $5, $7}'");

        var output = proc.readAll().split("\n");
        plasmoid.nativeInterface.clearPortList();

        for (var i in output) {
            var line = output[i].split(" ");
            if (line.length > 1) {
                var port = line[0].split(":").pop();
                var pid = line[1].split(",")[0].replace("pid=", "");

                plasmoid.nativeInterface.addPortEntry(port, pid);
            }
        }
    },

    terminateProcess: function(pid) {
        var proc = new Process();
        proc.exec("kill " + pid);
        portManager.getPortList();
    }
};

plasmoid.nativeInterface.getPortList = portManager.getPortList;
plasmoid.nativeInterface.terminateProcess = portManager.terminateProcess;
