<?php
class ExampleApp extends MoeApps {

    public function Hello() {

        if( isset($_GET['test']) )
            $content = "You Clicked On Test!";
        else
            $content = "Nice to meet you!";
                    
        $this->viewrender('welcome', array(
              'title' => 'Welcome to MoeFrame',
            'content' => $content,
            'version' => '1.0'
        ));
            
    }

}
?>