
param($pegaRegistryUserId, $pegaRegistryAPIKey, $pesonalRegistryUserId, $pesonalRegistryAPIKey)
$pegaRegistryUserId
$pegaRegistryAPIKey
$pesonalRegistryUserId
$pesonalRegistryAPIKey

#1. Request access for "My Pega Docker Image Access" from https://sm.pega.com.
#2. Request for API access keys (For more details refer: https://docs.pega.com/client-managed-cloud/87/pega-provided-docker-images)
#3. Login into Pega Docker Registry
docker login pega-docker.downloads.pega.com --username=$pegaRegistryUserId --password=$pegaRegistryAPIKey

#4. Pull all the images to your local system. Steps 5,6,7,8 can be run in parallel. https://docs.pega.com/client-managed-cloud/87/pega-provided-docker-images

#5. Platform/pega===>Pega Platform + Tomcat application server.
docker pull pega-docker.downloads.pega.com/platform/pega:8.7.0
 
#6. Platform/installer  install or upgrade all of the Pega-specific rules and database tables
docker pull pega-docker.downloads.pega.com/platform/installer:8.7.0
   
#7. Search n Reporting service
docker pull pega-docker.downloads.pega.com/platform-services/search-n-reporting-service:1.17.10
    
#8. platform/clustering-service===>Hazelcast (version 1.0.3 or later) for the caching capabilities in Pega Infinity as a backing service.
docker pull pega-docker.downloads.pega.com/platform/clustering-service:1.0.3
   
#9. Re-tag images
docker images
Invoke-Expression "docker tag pega-docker.downloads.pega.com/platform/pega:8.7.0 ${pesonalRegistryUserId}/my-pega:8.7.0"
Invoke-Expression "docker tag pega-docker.downloads.pega.com/platform/installer:8.7.0  ${pesonalRegistryUserId}/my-pega-installer:8.7.0"
Invoke-Expression "docker tag pega-docker.downloads.pega.com/platform-services/search-n-reporting-service:1.17.10  ${pesonalRegistryUserId}/my-pega-srs:1.17.10"
Invoke-Expression "docker tag pega-docker.downloads.pega.com/platform/clustering-service:1.0.3  ${pesonalRegistryUserId}/my-pega-clustering-service:1.0.3"
docker images


#10. Push them into your private Docker registry
#10.1 
docker login -u $pesonalRegistryUserId --password=$pesonalRegistryAPIKey
#The following steps can be run in parallel
#10.2
Invoke-Expression "docker push ${pesonalRegistryUserId}/my-pega:8.7.0" 
#10.3
Invoke-Expression "docker push ${pesonalRegistryUserId}/my-pega-installer:8.7.0"
#10.4
Invoke-Expression "docker push ${pesonalRegistryUserId}/my-pega-srs:1.17.10"
#10.5
Invoke-Expression "docker push ${pesonalRegistryUserId}/my-pega-clustering-service:1.0.3"

