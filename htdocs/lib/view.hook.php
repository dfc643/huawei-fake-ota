<?php

/**
 * Include other view hook
 * @param $view: custom view name
 * @param $parameters: view parameters
 */
function VI( $view, $parameters = array() ) {

    MoeApps::viewrender($view,$parameters);
    
}

?>