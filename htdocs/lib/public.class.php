<?php
class MoeApps {

    /**
     * Direct Show or ECHO
     * @param $content: body content
     */
    public function directshow( $content ) {
    
        print $content;
        exit(0);
        
    }
    
    /**
     * Return Http Code
     * @param code: http code
     * @param body: document body
     */
    public function header ( $code, $body = '' ) {

        switch ( $code ) {
            
            case 200: header('HTTP/1.1 200 OK'); break;
            case 403: header('HTTP/1.1 403 Forbidden'); break;
            case 404: header('HTTP/1.1 404 Not Found'); break;
            case 405: header('HTTP/1.1 404 Not Allowed'); break;
            case 500: header('HTTP/1.1 500 Internal Server Error'); break;
            
            default: header('HTTP/1.1 '.$code);
            
        }
        
        print $body;

    }
    
    /**
     * Abort Loading and Return Http Code
     * @param code: http code
     * @param view: return custom view
     */
    public function abort ( $code, $view = '', $msg = '' ) {
    
        MoeApps::header($code);
        switch ( $code ) {
            
            case 403: $error = 'Forbidden'; break;
            case 404: $error = 'Page Not Found'; break;
            case 405: $error = 'Not Allowed'; break;
            case 500: $error = 'Internal Server Error'; break;
            default: $error = 'Unknown Error';
            
        }
        
        print $msg; // print debug message
        
        if ( $view == '' ) {
        $template = <<<EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>$error</title>
    <style>
    body {margin: 0; padding: 0; background-color: #F0F0F0;}
    #content {position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin: auto;
        height: 110px; width: 100%; text-align: center; color: #555; }
    a {color: #555;}
    .title {font-size: 64px;}
    .version {margin-top: 5px;}
    </style>
</head>
<body>
    <div id="content">
        <div class="title">Oops, $error !</div>
        <div class="version">
            Error $code, Please try <a href="javascript:window.location.reload()">reload</a> page.
        </div>
    </div>  
</body>
</html>
EOF;
            print $template;
        } else {
            MoeApps::viewrender($view, array(
                'code' => $code,
                'error' => $error
            ));
        }
        
        exit(-1);

    }
    
    /**
     * View Render
     * @param view: return a view
     * @param parameters: return parameters to view
     */
    public static function viewrender ( $view, $parameters = array() ) {

        include_once "view.hook.php"; // load view hooks
        $view_content = file_get_contents("../view/$view.html"); // load view content
        
        preg_match_all("/\{\{ \\\$([^\}]*) \}\}/", $view_content, $view_variable); // store variable to array
        $view_variable = $view_variable[1];
        foreach ( $view_variable as $variable ) { // loading variables
            $view_content = preg_replace("/\{\{ \\\$$variable \}\}/", $parameters["$variable"], $view_content);
        }
      
        $view_content = preg_replace("/\{\{ \@([^\}]*) \}\}/", "<?php $1 ?>", $view_content); // run php function in view
        
        eval("?>" . $view_content . "<?php ");

    }

}