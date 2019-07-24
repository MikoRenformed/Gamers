


<!DOCTYPE HTML>
<html>

<head>
    <meta charset="utf-8">

    <title>JupyterHub</title>
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    
    <link rel="stylesheet" href="/hub/static/css/style.min.css?v=dd1df30ccc6c4d3e9705d78012d25b57" type="text/css"/>
    
    <script src="/hub/static/components/requirejs/require.js?v=e7199843dfd445bb66ec816e98a03214" type="text/javascript" charset="utf-8"></script>
    <script src="/hub/static/components/jquery/dist/jquery.min.js?v=a09e13ee94d51c524b7e2a728c7d4039" type="text/javascript" charset="utf-8"></script>
    <script src="/hub/static/components/bootstrap/dist/js/bootstrap.min.js?v=5869c96cc8f19086aee625d670d741f9" type="text/javascript" charset="utf-8"></script>
    <script>
      require.config({
          
          urlArgs: "v=20190722232519",
          
          baseUrl: '/hub/static/js',
          paths: {
            components: '../components',
            jquery: '../components/jquery/dist/jquery.min',
            bootstrap: '../components/bootstrap/dist/js/bootstrap.min',
            moment: "../components/moment/moment",
          },
          shim: {
            bootstrap: {
              deps: ["jquery"],
              exports: "bootstrap"
            },
          }
      });
    </script>

    <script type="text/javascript">
      window.jhdata = {
        base_url: "/hub/",
        prefix: "/",
        
        user: "sako0518",
        
        
        admin_access: false,
        
        
        options_form: false,
        
      }
    </script>

    
    

</head>

<body>

<noscript>
  <div id='noscript'>
    JupyterHub requires JavaScript.<br>
    Please enable it to proceed.
  </div>
</noscript>


  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <span id="jupyterhub-logo" class="pull-left"><a href="/hub/"><img src='/hub/logo' alt='JupyterHub' class='jpy-logo' title='Home'/></a></span>
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#thenavbar" aria-expanded="false">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>

      <div class="collapse navbar-collapse" id="thenavbar">
        
        <ul class="nav navbar-nav">
          
            <li><a href="/hub/home">Home</a></li>
            <li><a href="/hub/token">Token</a></li>
            
          
        </ul>
        
        <ul class="nav navbar-nav navbar-right">
          
            <li>
              
                <span id="login_widget">
                  
                    <a id="logout" role="button" class="navbar-btn btn-sm btn btn-default" href="/hub/logout"> <i aria-hidden="true" class="fa fa-sign-out"></i> Logout</a>
                  
                </span>
              
            </li>
          
        </ul>
      </div>

      
      
    </div>
  </nav>










<div class="container">
  <div class="row">
    <div class="text-center">
      <img src="/static/images/logo.png" class="center-block" alt="CU Logo">
      
      <p>Your server is starting up.</p>
      <p>You will be redirected automatically when it's ready for you.</p>
      <p></p>
      <p> If you have problems or questions, contact the
	<a href="mailto:help@cs.colorado.edu">the CS help desk</a>.
	 Documentation and additional information is available
	at the <a href="https://csel.cs.colorado.edu/index.html">
	  Computer Science Educational Resource Guide </a>.</p>
      
      <div class="progress">
        <div id="progress-bar" class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
          <span class="sr-only"><span id="sr-progress">0%</span> Complete</span>
        </div>
      </div>
      <p id="progress-message"></p>
    </div>
  </div>
  <div class="row">
    <div class="col-md-8 col-md-offset-2">
      <details id="progress-details">
        <summary>Event log</summary>
        <div id="progress-log"></div>
      </details>
    </div>
  </div>
</div>






<div class="modal fade" id="error-dialog" tabindex="-1" role="dialog" aria-labelledby="error-label" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="error-label">Error</h4>
      </div>
      <div class="modal-body">
        
  <div class="ajax-error">
    The error
  </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" data-dismiss="modal">OK</button>
      </div>
    </div>
  </div>
</div>





<script type="text/javascript">
require(["jquery"], function ($) {
  $("#refresh").click(function () {
    window.location.reload();
  })

  // hook up event-stream for progress
  var evtSource = new EventSource("/hub/api/users/sako0518/server/progress");
  var progressMessage = $("#progress-message");
  var progressBar = $("#progress-bar");
  var srProgress = $("#sr-progress");
  var progressLog = $("#progress-log");

  evtSource.onmessage = function(e) {
    var evt = JSON.parse(e.data);
    console.log(evt);
    if (evt.progress !== undefined) {
      // update progress
      var progText = evt.progress.toString();
      progressBar.attr('aria-valuenow', progText);
      srProgress.text(progText + '%');
      progressBar.css('width', progText + '%');
    }
    // update message
    var html_message;
    if (evt.html_message !== undefined) {
      progressMessage.html(evt.html_message);
      html_message = evt.html_message;
    } else if (evt.message !== undefined) {
      progressMessage.text(evt.message);
      html_message = progressMessage.html();
    }
    if (html_message) {
      progressLog.append(
        $("<div>")
          .addClass('progress-log-event')
          .html(html_message)
      );
    }

    if (evt.ready) {
      evtSource.close();
      // reload the current page
      // which should result in a redirect to the running server
      window.location.reload();
    }

    if (evt.failed) {
      evtSource.close();
      // turn progress bar red
      progressBar.addClass('progress-bar-danger');
      // open event log for debugging
      $('#progress-details').prop('open', true);
    }
  }

});
</script>


</body>

</html>