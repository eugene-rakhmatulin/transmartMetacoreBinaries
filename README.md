transmartBinaries
=================

This repository contains a pre-packaged version of Transmart with MetaCore and Cortellis integration functionality.
The source code is available in the branch "metacore-integration" - please, check out BOTH Rmodules and transmartApp if you want to build transmart from the source.

PRE-REQUISITES
--------------

For both Cortellis integration and enrichment functionality you need an ability to access web addresses in the Internet for your Transmart server.
If you use the proxy, you need to specify proxy settings in <tomcat_folder>/bin/catalina.sh in JAVA_OPTS:

```bash
	# $Id: catalina.sh 1146097 2011-07-13 15:25:05Z markt $
	# -----------------------------------------------------------------------------

	JAVA_OPTS="-Djava.awt.headless=true -server -Xms2048m 
	-Xmx4096m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m 
	-XX:MaxPermSize=256m -XX:+DisableExplicitGC 
	-DproxyHost=webproxy.int -DproxyPort=80 
	-Dhttps.proxyHost=webproxy.int -Dhttps.proxyPort=80
	-Dhttp.proxyHost=webproxy.int -Dhttp.proxyPort=80
	-Dhttp.nonProxyHosts=your_transmart_host
	-Dhttps.nonProxyHosts=your_transmart_host"

	# OS specific support.  $var _must_ be set to either true or false.
```

### 1. CORTELLIS

For Cortellis integration, you need to have working Cortellis API credentials.
Edit ~/.grails/transmartApp/Config.groovy and add the following lines:

```groovy
	com.recomdata.searchtool.cortellisEnabled = true
	com.thomsonreuters.transmart.cortellisAPILogin = 'your_API_login'
	com.thomsonreuters.transmart.cortellisAPIPassword = 'your_API_password'
```

Also, you'll need to copy an SSL certificate to your server and specify it in the configuration file:

com.thomsonreuters.transmart.cortellisCertStore = '/path/to/cortellis_truststore.jks'

Then, you need to specify metacoreURL in order to be able to open MetaCore maps from Cortellis search results:

```groovy
	com.thomsonreuters.transmart.metacoreURL = 'https://portal.genego.com'
```

### 2. ENRICHMENT FUNCTIONALITY (FREE & METACORE)

For both free and MetaCore enrichments, you need to specify the following line in your ~/.grails/transmartApp/Config.groovy:

```groovy
	com.thomsonreuters.transmart.metacoreAnalyticsEnable = true
```

You don't need to specify any extra settings in order for FREE enrichment to work

### 3. FULL METACORE ENRICHMENT FUNCTIONALITY

First of all, you need to create a special table that will store user preferences.
Please, execute create_user_settings.sql under "searchapp" or "system" Oracle user, otherwise you will not be able to use full enrichment functionality.

If you want all users use their personal MetaCore account, you don't need to do anything else.
If you want an ability to use common account for enrichments (users will have a choice), then you need to specify default MetaCore credentials in ~/.grails/transmartApp/Config.groovy:

```groovy
	com.thomsonreuters.transmart.metacoreDefaultLogin = 'metacore_login'
	com.thomsonreuters.transmart.metacoreDefaultPassword = 'metacore_password'
```

BINARY INSTALLATION
-------------------

To install Transmart WAR, just follow the procedure:

1. Make the database changes as described earlier in this manual
2. Shutdown Tomcat
3. Edit the configuration files according to written above
4. Delete <tomcat_dir>/webapps/transmart directory! This is important because Tomcat may not re-deploy an application if the old one is still in place. None of the application settings get lost in the process.
5. Make a backup copy of <tomcat_dir>/webapps/transmart.war just in case
6. Copy transmart.war from this repository into your <tomcat_dir>/webapps directory
7. Start Tomcat

If everything worked, you should be able to see "MetaCore Enrichment Analysis" tab in the Dataset Explorer. If you switch to the tab, there is a settings button there. Click on the button to check if everything works fine.

MetaCore enrichment functionality is then available in this separate tab (to run enrichment against the entire expression dataset for selected cohorts) or in Marker Selection advanced workflow to run enrichment against differentially expressed genes.
