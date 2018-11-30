import hudson.model.UpdateSite
import org.springframework.util.CollectionUtils

Set<String> plugins = []
def default_plugins = ["proxmox", "crowd2"]
long installerCounter = 0
Boolean dynamicLoad = false
UpdateSite updateSite = Jenkins.getInstance().getUpdateCenter().getById('<Master_Update_Center-ID>')

def availablePlugins = Jenkins.instance.updateCenter.getCategorizedAvailables()
availablePlugins.each {
  plugins.add(it.plugin.name)
}

ArrayList plugins_to_install = new ArrayList(plugins)
Boolean isContains = plugins_to_install.retainAll(default_plugins);
println "${plugins} \n <====>"
plugins_to_install.each {
  println "Installing ${it} - ${++installerCounter} from ${plugins_to_install.size()}"
 /*UpdateSite.Plugin plugin = updateSite.getPlugin(it)
  Throwable error = plugin.deploy(dynamicLoad).get().getError()
  if(error != null) {
    println "ERROR installing ${it}, ${error}"
  }*/
}

/*if(plugins_to_install.size() != 0 && installerCounter == plugins_to_install.size()) {
   jenkins.model.Jenkins.instance.safeRestart()
} */

