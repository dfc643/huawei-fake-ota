<?php
/**
 * Main Router
 * @param route: route string
 * @param func: call a function
 */
function R ( $route, $func ) {

    $reqRoute = str_replace("/", "\/", $route);
    if ( preg_match("/^$reqRoute$/", $_SERVER['REQUEST_URI']) || 
         preg_match("/^$reqRoute\?(.*)$/", $_SERVER['REQUEST_URI']) )
    {
        if( strpos($func, '@') > -1 ) { //If function in Class
            $funcArr = explode('@', $func);
            $func = array(new $funcArr[0], $funcArr[1]);
        }
        if ( !is_callable( $func ) ) // is controller exist?
            MoeApps::abort(500, '', 'Controller Not Exist!');
        else
            call_user_func( $func );
            
        exit(0);
    }

}

?>