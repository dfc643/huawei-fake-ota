<?php
class hwOta extends MoeApps {

    public function Skip() {
        $this->directshow('{"status":"1"}');
    }

    public function Resp() {
    
        $postData = json_decode(file_get_contents('php://input'));
        $respData = file_get_contents(E('MOEFRAME_TMP_ROOT')."/response.json");
        $dVer = file_get_contents(E('MOEFRAME_TMP_ROOT')."/emuiver.txt");
        
        if ( ($dVer == "5" && !isset($postData->rules->extra_info) && $postData->rules->PackageType == "increment") ||
              ($dVer == "4" && $postData->rules->PackageType == "increment") )  // emui 3,4 or 5+
        {
            $this->directshow($respData);
        }
        else
        {
            $this->Skip(); // skip other requestions
        }
        
    }
    
    public function XMLget() {
        header("Content-type: text/xml");
        if( basename($_SERVER['REQUEST_URI']) == "changelog.xml" &&  // support custom changelog.xml
              file_exists(dirname(E('MOEFRAME_ROOT'))."/changelog.xml") ) {
            $content = file_get_contents(dirname(E('MOEFRAME_ROOT'))."/changelog.xml");
        } else { // no custom changelog or other xml file
            $content = file_get_contents(E('MOEFRAME_TMP_ROOT')."/".basename($_SERVER['REQUEST_URI']));
        }
        $this->directshow( $content );
    }
    
    public function ZIPget() {
        header("Location: http://query.hicloud.com/".basename($_SERVER['REQUEST_URI']));
    }
    
    public function Resp200() {
        $this->header(200);
    }
    
    public function Auth() {
        /*
         * LOCAL FAKE SIGNATURE
         */
        // default cert and sign for OTA Server
        /*$sign = 'MEQCID7ixhzSsoZHK5A23QYQ+IqEB+JuekupuuOjNAWSjZo4AiBbdLfbjpsjZ3aU/fpBHoIrrkatohNSrWJPZh3kSPmWIg==';
        $cert = 'MIIDJzCCAsygAwIBAgIJALWcScNmfs+NMAoGCCqGSM49BAMCMIHXMQswCQYDVQQGEwJDTjEQMA4GA1UECAwHSmlhbmdzdTEQMA4GA1UEBwwHTmFuamluZzEsMCoGA1UECgwjSHVhd2VpIFNvZnR3YXJlIFRlY2hub2xvZ2llcyBDTy5MdGQxQTA/BgNVBAsMOERldmllIFJlZ2lvbiBEZWxpdmVyeSAmIFNlcnZpY2UgUXVhbGl0eSAmIE9wZXJhdGlvbiBEZXB0MRQwEgYDVQQDDAtPVEEgUm9vdCBDQTEdMBsGCSqGSIb3DQEJARYOb3RhQGh1YXdlaS5jb20wHhcNMTYwNzEyMDgxOTU5WhcNMTcwNzEyMDgxOTU5WjCB2zELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB0ppYW5nc3UxEDAOBgNVBAcMB05hbmppbmcxLDAqBgNVBAoMI0h1YXdlaSBTb2Z0d2FyZSBUZWNobm9sb2dpZXMgQ08uTHRkMUEwPwYDVQQLDDhEZXZpZSBSZWdpb24gRGVsaXZlcnkgJiBTZXJ2aWNlIFF1YWxpdHkgJiBPcGVyYXRpb24gRGVwdDEYMBYGA1UEAwwPT1RBIEF1dGggU2VydmVyMR0wGwYJKoZIhvcNAQkBFg5vdGFAaHVhd2VpLmNvbTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABGeDtAUO4uTY5yWwS54sk030WOdHYoaaO0dufn4jvul22Ytogvua1W0qY+ABblhA3eB49YXYPnpLvGhjr+73oZ6jezB5MAkGA1UdEwQCMAAwLAYJYIZIAYb4QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBTGCe/51LIS2ZT9nAj06RaAFcQa4jAfBgNVHSMEGDAWgBTH3T3aib5XZtlRccAInw7VjXJS0jAKBggqhkjOPQQDAgNJADBGAiEAjyic8z59ws8PvB2Q7apf69yFLM7ByICD8RBXxmz1WtUCIQChb2PYP5BzGRFxKV9ow9DesWt4bakIgdNFsUuT4NwMlQ==';
        
        $postData = json_decode(file_get_contents('php://input'));
        $updateToken = $postData->updateToken;
        $deviceId = $postData->deviceId;
        $versionId = $postData->version[0]->versionId;
        $versionNum = file_get_contents(E('MOEFRAME_TMP_ROOT')."/versionNumber.txt");
        
        $dataTemplate = '{"updateToken":"'.$updateToken.'","deviceId":"'.$deviceId.'","approvedVersionList":[{"versionId":"'.$versionId.'","status":"0","versionNumber":"'.$versionNum.'"}]}';
        $respData = "data=".base64_encode($dataTemplate)."&sign=$sign&cert=$cert";
        
        $this->directshow($respData);*/
        
        /*
         * PROXY SIGNATURE PROCCESS
         */
        // Loading Original Data
        $postData = file_get_contents('php://input');
        
        // Resolving Huawei Official Server IP address
        $ch = curl_init("http://119.29.29.29/d?dn=query.hicloud.com");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $hwOtaIp = curl_exec($ch);
        
        // Proxy Signature Proccess
        $ch = curl_init();  
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, "https://$hwOtaIp/sp_ard_common/v1/authorize.action");
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'User-Agent: Dalvik/2.1.0 (Linux; U; Android 7.0; ALE-L09 Build/HUAWEIALE-L09)',
            'Content-Type: application/json; charset=utf-8',
            'Content-Length: ' . strlen($postData),
            'Host: query.hicloud.com'
        ));
        $return_content = curl_exec($ch);
        curl_close($ch);
        
        // Insert Version Number and Modify status
        $verNum = file_get_contents(E('MOEFRAME_TMP_ROOT')."/versionNumber.txt");
        parse_str($return_content, $query_parts);
        $dataStr = json_decode(base64_decode($query_parts["data"]));
        $dataStr->approvedVersionList[0]->status = "0";
        $dataStr->approvedVersionList[0]->versionNumber = $verNum;
        $dataStr = base64_encode(json_encode($dataStr));
        
        // Rebuild Result
        preg_match("/&(sign=.*)$/", $return_content, $signCert);
        $return_content = "data=$dataStr&".$signCert[1];

        $this->directshow($return_content);
    }
    
    public function Guide() {
        
        $step = isset($_GET['step']) ? $_GET['step'] : "1";
        switch ($step) {
        
            case '-1': 
                system('move "'.E('MOEFRAME_ROOT').'\\public\\*.zip" "'.dirname(E('MOEFRAME_ROOT')).'\\" >nul');
                $this->viewrender('hwota/finish', array('title' => 'Finished'));
                system('taskkill /f /im DNSAgent.exe > nul');
                break;
        
            case '3': 
                $localIP = getHostByName(php_uname('n'));
                $this->viewrender('hwota/step3', array('title' => 'Step 3', 'localip' => $localIP));
                break;
        
            case '2.1':
                hwOta::GenRespJsonfile();
                if ( $_POST['from'] == "local" ) hwOta::GenRespXmlfile();
                $this->directshow('<script>window.location.href="?step=3";</script>');
                break;
        
            case '2': 
                $this->viewrender('hwota/step2', array('title' => 'Step 2'));
                break;
                
            case '1': default:
                $this->viewrender('hwota/step1', array('title' => 'Welcome'));
        
        }
        
    }
    
    private function GenRespJsonfile() {
        date_default_timezone_set('Asia/Shanghai');
        
        $jsonTemplate = '{"status":"0","autoPollingCycle":"1","components":[{"name":"","version":"","versionID":"","description":"","ruleAttr":"","createTime":"","url":"","reserveUrl":"","componentID":1,"versionType":"1","pointVersion":"1"}],"checkEnd":"1"}';
        $respData = json_decode($jsonTemplate);
        
        $respData->components[0]->name = $_POST['version'];
        $respData->components[0]->version = $_POST['version'];
        $respData->components[0]->description = "Update to: ".$_POST['version'].'  &#40;'.date("Y/n/j").'&#41;';
        $respData->components[0]->createTime = date("Y-m-d\TH:i:s+0000");
        
        if ( $_POST['from'] == "remote" ) {
            $matchStatus = preg_match("/\w\d{2,5}\/\w\d{2,5}\/v(\d{4,7})\/f/", $_POST['remotepath'], $matchedVer);
            $matchStatus ? $respData->components[0]->versionID = $matchedVer[1] : $respData->components[0]->versionID = "999999";
            $respData->components[0]->url = $_POST['remotepath'];
        } else {
            $respData->components[0]->versionID = "999999";
            $respData->components[0]->url = "http://query.hicloud.com/";
        }
        
        if ( $_POST['from'] == "local" ) {
            $version = $_POST['version'];
            $changelog = <<<EOF
<?xml version="1.0" encoding="utf-8"?>
<root>
<component name="TCPU" version="$version"/>
<default-language name="en-us">1033</default-language>
<romsurvey-flag>false</romsurvey-flag>
<point-version>false</point-version>
<language name="en-us" code="1033">
<features module="">
<feature>
Update from Fake OTA.
</feature>
</features>
</language>
</root>
EOF;

            file_put_contents(E('MOEFRAME_TMP_ROOT')."/changelog.xml", $changelog);
        }

        file_put_contents(E('MOEFRAME_TMP_ROOT')."/emuiver.txt", $_POST['emui']);
        file_put_contents(E('MOEFRAME_TMP_ROOT')."/versionNumber.txt", $_POST['version']);
        file_put_contents(E('MOEFRAME_TMP_ROOT')."/response.json", stripslashes(json_encode($respData)));

    }
    
    private function GenRespXmlfile() {
        
        $filelistTemplate = <<<EOF
<?xml version="1.0" encoding="utf-8"?>
<root>
<component>
<name>TCPU</name>
<compress>0</compress>
</component>
<vendorInfo name="common" subpath="" logfile="changelog.xml" package="update.zip" />
EOF;
        system('move "'.dirname(E('MOEFRAME_ROOT')).'\\*.zip" "'.E('MOEFRAME_ROOT').'\\public\\" >nul');
        $dir = scandir(E('MOEFRAME_ROOT').'\\public');
        foreach ( $dir as $file ) {
            if ( preg_match("/update_.*_\w{2,3}.zip/", $file) ) {
                $filesub = array_reverse(explode('_', str_replace(".zip", "", $file)));
                $areaCode = $filesub[1].'/'.$filesub[0];
                $filelistTemplate .= "\n".'<vendorInfo name="'.$areaCode.'" subpath="'.$areaCode.'" logfile="" package="'.$file.'" />';
            } else if ( preg_match("/update_.*_public.zip/", $file) ) {
                $filelistTemplate .= "\n".'<vendorInfo name="public" subpath="public" logfile="" package="'.$file.'" />';
            }
        }
        $filelistTemplate .= "\n<files>";
        if( file_exists(E('MOEFRAME_TMP_ROOT')."/changelog.xml") ) {
            $filemd5 = strtoupper(md5_file(E('MOEFRAME_TMP_ROOT')."/changelog.xml"));
            $filesize = filesize(E('MOEFRAME_TMP_ROOT')."/changelog.xml");
        }
        if ( file_exists(dirname(E('MOEFRAME_ROOT'))."/changelog.xml") ) { // for support custom changelog
            $filemd5 = strtoupper(md5_file(dirname(E('MOEFRAME_ROOT'))."/changelog.xml"));
            $filesize = filesize(dirname(E('MOEFRAME_ROOT'))."/changelog.xml");
        }
        $filelistTemplate .= "\n".<<<EOF
<file>
<spath>changelog.xml</spath>
<dpath>changelog.xml</dpath>
<operation>c</operation>
<md5>$filemd5</md5>
<size>$filesize</size>
</file>
EOF;
        
        foreach ( $dir as $file ) {
            if ( preg_match("/updat.*.zip/", $file) ) {
                $filemd5 = strtoupper(md5_file(E('MOEFRAME_ROOT').'\\public\\'.$file));
                $filesize = filesize(E('MOEFRAME_ROOT').'\\public\\'.$file);
                $filelistTemplate .= "\n".<<<EOF
<file>
<spath>$file</spath>
<dpath>$file</dpath>
<operation>c</operation>
<md5>$filemd5</md5>
<size>$filesize</size>
</file>
EOF;
            }
        }

        $filelistTemplate .= "\n".<<<EOF
</files>
</root>
EOF;

        file_put_contents(E('MOEFRAME_TMP_ROOT')."/filelist.xml", $filelistTemplate);

    }

}
?>