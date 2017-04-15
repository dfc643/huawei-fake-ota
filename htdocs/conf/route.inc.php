<?php

R('/hello', 'ExampleApp@Hello');

R('/guide', 'hwOta@Guide');
R('/full/.*.xml', 'hwOta@XMLget');
R('/full/.*.zip', 'hwOta@ZIPget');
R('/sp_ard_common/v2/UpdateReport.action', 'hwOta@Resp200');
R('/sp_ard_common/v1/authorize.action', 'hwOta@Auth');
R('/sp_ard_common/.*/.*.action', 'hwOta@Resp');
R('/sp_(.*)_common/v2/Check.action', 'hwOta@Skip');

?>