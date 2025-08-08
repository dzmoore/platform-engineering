import crypto

oxr = option("params").oxr
ocds = option("params").ocds

specObj = oxr.spec or {}
metadataObj = oxr.metadata or {}

metadataName = metadataObj.name
nameHash = crypto.sha256(metadataName)
nameAndHash = "{}-{}".format(metadataName[0:12:], nameHash)

managedResourceName = lambda baseName: str -> str {
    "gke-ap-{}-{}".format(baseName, nameAndHash)[0:45:].rstrip("-")
}

clusterName: str = specObj.name
clusterLocation: str = specObj.location or "us-west1"
providerName: str = specObj.providerConfigName or "default"
clusterDeletionProtection: bool = specObj.clusterDeletionProtection or True
deletionPolicy: str = specObj.deletionPolicy or "Delete"

clusterObjName = managedResourceName("cluster")
serviceAccountObjName = managedResourceName("svc-acct")
serviceAccountKeyObjName = managedResourceName("svc-acct-key")

serviceAccountName = nameAndHash[0:30:].rstrip("-")

observedClusterConnectionDetails = ocds[clusterObjName]?.ConnectionDetails or {}
encodedKubeconfig = observedClusterConnectionDetails.kubeconfig or ""

observedServiceAccountKeyConnectionDetails = ocds[serviceAccountKeyObjName]?.ConnectionDetails or {}
encodedServiceAccountKey = observedServiceAccountKeyConnectionDetails.private_key or ""

connectionDetails = {
    apiVersion: "meta.krm.kcl.dev/v1alpha1"
    kind: "CompositeConnectionDetails"
    data: {
        kubeconfig: encodedKubeconfig
        serviceAccountPrivateKey: encodedServiceAccountKey
    }
}

_resources = [
    connectionDetails
]

items = _resources
