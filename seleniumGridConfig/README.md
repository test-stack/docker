# nodeConfig & hubConfig for Selenium Grid2

Grid2 allows you to :

 * scale by distributing tests on several machines ( parallel execution )
 * manage multiple environments from a central point, making it easy to run the tests against a vast combination of browsers / OS.
 * minimize the maintenance time for the grid by allowing you to implement custom hooks to leverage virtual infrastructure for instance.

More information on [Selenium grid2 wiki](https://code.google.com/p/selenium/wiki/Grid2)
, [Default grid parameters](https://code.google.com/p/selenium/source/browse/java/server/src/org/openqa/grid/common/defaults/GridParameters.properties)

![flow](http://docs.seleniumhq.org/selenium-rc.png "Flow")


## How to use without config files
> Run from root directory

### node

```
java -jar selenium-server-standalone-2.x.x.jar -Dwebdriver.chrome.driver="./chromedriver" -role node -hub http://localhost:4444/grid/register -port 4441 -browser browserName=firefox,maxInstances=5
```
With default configuration
```
{
  "capabilities":
      [
        {
          "browserName": "*firefox",
          "maxInstances": 5,
          "seleniumProtocol": "Selenium"
        },
        {
          "browserName": "*googlechrome",
          "maxInstances": 5,
          "seleniumProtocol": "Selenium"
        },
        {
          "browserName": "*iexplore",
          "maxInstances": 1,
          "seleniumProtocol": "Selenium"
        },
        {
          "browserName": "firefox",
          "maxInstances": 5,
          "seleniumProtocol": "WebDriver"
        },
        {
          "browserName": "chrome",
          "maxInstances": 5,
          "seleniumProtocol": "WebDriver"
        },
        {
          "browserName": "internet explorer",
          "maxInstances": 1,
          "seleniumProtocol": "WebDriver"
        }
      ],
  "configuration":
  {
    "proxy": "org.openqa.grid.selenium.proxy.DefaultRemoteProxy",
    "maxSession": 5,
    "port": 5555,
    "host": ip,
    "register": true,
    "registerCycle": 5000,
    "hubPort": 4444,
    "hubHost": ip
  }
}
```

### hub

```
java -jar selenium-server-standalone-2.x.x.jar -role hub
```
With default configuration
```
{
  "host": null,
  "port": 4444,
  "newSessionWaitTimeout": -1,
  "servlets" : [],
  "prioritizer": null,
  "capabilityMatcher": "org.openqa.grid.internal.utils.DefaultCapabilityMatcher",
  "throwOnCapabilityNotPresent": true,
  "nodePolling": 5000,
  "cleanUpCycle": 5000,
  "timeout": 300000,
  "browserTimeout": 0,
  "maxSession": 5,
  "jettyMaxThreads":-1
}
```

## How to use with config files

### node

```
java -jar selenium-server-standalone-2.x.x.jar -Dwebdriver.chrome.driver="./chromedriver" -role node -nodeConfig ./nodeConfig.json
```

### hub

```
java -jar selenium-server-standalone-2.x.x.jar -role hub -hubConfig ./hubConfig.json
```