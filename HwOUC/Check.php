<?php
$rawData = $GLOBALS['HTTP_RAW_POST_DATA'];
$jsonData = json_decode($rawData);

// If not Honor 4C return failed information
if(strpos($jsonData->rules->DeviceName, "CHM") < 0) {
    echo deviceQuery(-1);
    exit(-1);
}

// 
switch(substr($jsonData->rules->FirmWare, -4 , 4)) {
    // B551 to B556
    case 'B551':
        switch($jsonData->rules->DeviceName) {
            case 'CHM-UL00': die (deviceQuery(0, '556', '48326'));
            case 'CHM-TL00': die (deviceQuery(1, '556', '48305'));
            case 'CHM-TL00H': die (deviceQuery(2, '556', '48316'));
            default:  die (deviceQuery(-1));
        }
    
    // B555 to B556
    case 'B555':
        switch($jsonData->rules->DeviceName) {
            case 'CHM-UL00': die (deviceQuery(0, '556', '48289'));
            case 'CHM-TL00': die (deviceQuery(1, '556', '48300'));
            case 'CHM-TL00H': die (deviceQuery(2, '556', '48295'));
            default:  die (deviceQuery(-1));
        }
    
    // B556 to B561 (test-mode)
    case 'B556':
        switch($jsonData->rules->DeviceName) {
            case 'CHM-UL00': die (deviceQuery(0, '561', '53670', 2));
            case 'CHM-TL00': die (deviceQuery(1, '561', '53702', 2));
            case 'CHM-TL00H': die (deviceQuery(2, '561', '53682', 2));
            default:  die (deviceQuery(-1));
        }
    
    // B561 downgrade to B231
    case 'B561':
        switch($jsonData->rules->DeviceName) {
            //case 'CHM-UL00': die (deviceQuery(0, '561', '53675', 1));
            //case 'CHM-TL00': die (deviceQuery(1, '231', '48303', 1));
            //case 'CHM-TL00H': die (deviceQuery(2, '425', '48297', 1));
            default:  die (deviceQuery(-1));
        }
    
    // Unsupported
    default:
        echo deviceQuery(-1);
        exit(-1);
}

// Return update server link to OUC
function deviceQuery($devType, $cuName = 'unset', $cuVer = '-1', $grademode = 0) {
    switch($devType) {    
        case 0:
            $fwName = 'CHM-UL00C00B'.$cuName;
            $fwVer = $cuVer;
            $fwDesc = '受限发布: [更新包] 当前版本至 '.$fwName.'  &#40;2016/1/1&#41;';
            $fwUrl = 'http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1018/g223/v'.$fwVer.'/f1/';
            break;
        
        case 1:
            $fwName = 'CHM-TL00C01B'.$cuName;
            $fwVer = $cuVer;
            $fwDesc = '受限发布: [更新包] 当前版本至 '.$fwName.'  &#40;2016/1/1&#41;';
            $fwUrl = 'http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1021/g223/v'.$fwVer.'/f1/';
            break;
        
        case 2:
            $fwName = 'CHM-TL00HC00B'.$cuName;
            $fwVer = $cuVer;
            $fwDesc = '受限发布: [更新包] 当前版本至 '.$fwName.'  &#40;2016/1/1&#41;';
            $fwUrl = 'http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1022/g223/v'.$fwVer.'/f1/';
            break;
        
        case -1:
        default:
            $fwName = '抱歉暂时不支持的设备';
            $fwVer = '-1';
            $fwDesc = '当前固件不支持您的设备请等待官方更新';
            $fwUrl = 'http://ota-update.rhc.huawei.com/HwOUC/unsupported/';
            break;
    }
    
    // Is downgrade or upgrade to unstable?
    switch($grademode) {
        case 1: $fwName = "【降级到】".$fwName." (实验功能)"; break;
        case 2: $fwName = $fwName." (暂不可降级)"; break;
    }
    
    // If does not support how to do?
    if($devType == -1) {
		return '{"status":"1"}';
		die();
    }
    
    $jsonData = '{
        "status":"0",
        "autoPollingCycle":"1",
        "components":[{
            "name":"'.$fwName.'",
            "version":"'.$fwName.'",
            "versionID":"'.$fwVer.'",
            "description":"'.$fwDesc.'",
            "createTime":"2016-01-01T00:00:00+0000",
            "url":"'.$fwUrl.'"
        }]
    }';

    return $jsonData;
}
?>