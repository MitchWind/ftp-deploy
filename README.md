## Usage Example
```yaml
name: Example

on:
  push:
    branches: [ master, Development ]
jobs:
  Make:
    runs-on: ubuntu-latest
    name: Make ${{matrix.work}} ${{matrix.arch}}
    steps:
      - name: Checkout
        uses: actions/checkout@main
      - name: down
        uses: MitchWind/ftp-deploy@master
        with:
            server: "v0.ftp.upyun.com"
            username: "mofeng64/wind-openwrt"
            password: ${{ secrets.FTP_PASSWOD }}
            local_dir: "targets"
            server_dir: "test"

```
## Settings
|Option|Description|Required|Default |Example
|---    | ---       | ---    | ---   | ---
|server |FTP Server.|Yes     |N/A    |fpt.server
|username|FTP Username|YES|N/A|useranme
|password|FTP Password|YES|N/A|password
|port|Server Port|NO|21|0~65535
|local_dir|Local directory|NO|./|/web
|server_dir|Server directory|NO|./|www
|working-directory|Acitons Wrok|NO|$GITHUB_WORKSPACE|/work
|settings|FTP setting commode config.|NO|N/A|N/A
|options|mirror options|NO|N/A|N/A
|max_retries|Times that the lftp will be executed if an error occurred|NO|1|N/A
|nop_interval|FTP - Delay in seconds between NOOP commands when downloading tail of a file|NO|2|N/A
|ssl_allow|FTP - Allow SSL encryption.|NO|false|true
|net_timeout|NET - Sets the network protocol timeout.|NO|10|N/A
|net_max_retries|NET - Maximum number of operation without success. 0 unlimited. 1 no retries.|NO|3|N/A
|net_persist_retries|NET - Ignore hard errors. When reply 5xx errors or there is too many users.|NO|5|N/A
|net_reconnect_interval_multiplier|sets  multiplier by which base interval is multiplied each time new attempt to perform an operation fails. When the interval reaches maximum, it is reset to base value.  See net:reconnect-interval-base and net:reconnect-interval-max.|NO|1|N/A
|net_reconnect_interval_base|sets the base minimal time between reconnects. Actual interval depends  on  net:reconвЂђ  nect-interval-multiplier and number of attempts to perform an operation.|NO|5|N/A
|delete|Delete all the files inside of the remote directory.|NO|true|false
|no_perms|don't set file permissions.|NO|true|N/A


