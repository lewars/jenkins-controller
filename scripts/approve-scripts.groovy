import org.jenkinsci.plugins.scriptsecurity.scripts.*
import jenkins.model.*

def scriptApproval = ScriptApproval.get()
scriptApproval.pendingScripts.each {
    scriptApproval.approveScript(it.hash)
}
