angular.module('ng-html5-video', [])
.directive 'ngHtml5Video', ($interval)->
  restrict: 'E'
  scope:
    width: '=?'
    height: '=?'
    mp4: '=?'
    ogv: '=?'
    webm: '=?'
  template: '
      <div style="position: relative;">
        <video id="video" width="{{width}}" height="{{height}}">
          <source ng-src="{{mp4}}" type="video/mp4">
          <source ng-src="{{ogv}}" type="video/ogv">
          <source ng-src="{{webm}}" type="video/webm">
          <p>
            <a href="{{mp4}}">Download</a>
          </p>
        </video>
  <style type="text/css">
    .video-range {
      -webkit-appearance: none;
      -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
      width: 100%;
      height: 30px;
      margin: 0;
      border: none;
      padding: 1px 2px;
      border-radius: 14px;
      background: #96c0d7;
      box-shadow: inset 0 1px 0 0 #5a5f69, inset 0 -1px 0 0 #a2a8b3;
      -webkit-box-shadow: inset 0 1px 0 0 #5a5f69, inset 0 -1px 0 0 #a2a8b3;
      outline: none; /* no focus outline */
    }
    .video-range-vertical {
      -webkit-transform:rotate(270deg);
      -moz-transform:rotate(270deg);
      -o-transform:rotate(270deg);
      -ms-transform:rotate(270deg);
      transform:rotate(270deg);
    }
    .video-range::-moz-range-track {
      border: inherit;
      background: transparent;
    }
    .video-range::-ms-track {
      border: inherit;
      color: transparent; /* dont drawn vertical reference line */
      background: transparent;
    }
    .video-range::-ms-fill-lower,
    .video-range::-ms-fill-upper {
      background: transparent;
    }
    .video-range::-ms-tooltip {
      display: none;
    }

    /* thumb */
    .video-range::-webkit-slider-thumb {
      -webkit-appearance: none;
      width: 40px;
      height: 18px;
      border: none;
      border-radius: 12px;
      background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #529de1), color-stop(100%, #245e8f)); /* android <= 2.2 */
      background-image: -webkit-linear-gradient(top , #529de1 0, #245e8f 100%); /* older mobile safari and android > 2.2 */;
      background-image: linear-gradient(to bottom, #529de1 0, #245e8f 100%); /* W3C */
    }
    .video-range::-moz-range-thumb {
      width: 40px;
      height: 18px;
      border: none;
      border-radius: 12px;
      background-image: linear-gradient(to bottom, #529de1 0, #245e8f 100%); /* W3C */
    }
    .video-range::-ms-thumb {
      width: 40px;
      height: 18px;
      border-radius: 12px;
      border: 0;
      background-image: linear-gradient(to bottom, #529de1 0, #245e8f 100%); /* W3C */
    }
    .show-controls {
      opacity: 0;
      transition: opacity 3s ease-in-out;
      -moz-transition: opacity 3s ease-in-out;
      -webkit-transition: opacity 3s ease-in-out;
      -ms-transition: opacity 3s ease-in-out;
      -o-transition: opacity 3s ease-in-out;
    }
    .show-controls:hover {
      opacity: 0.6;
      transition: opacity .5s ease-in-out;
      -moz-transition: opacity .5s ease-in-out;
      -webkit-transition: opacity .5s ease-in-out;
      -ms-transition: opacity .5s ease-in-out;
      -o-transition: opacity .5s ease-in-out;
    }
      </style>
      <div class="show-controls">
        <div ng-click="playPause()" ng-dblclick="fullScreen()" style="position: absolute; right: 0; top:0; bottom: 0; left: 0; opacity: 0;"></div>
        <div style="position: absolute; left: {{vid.width * 0.72}}px; top:{{vid.height*0.5-35}}px; width: {{vid.height - 55}}px;">
            <input type="range" min="0" max="1" step="0.01" ng-model="volume" ng-change="setVolume()" class="video-range video-range-vertical"/>
        </div>
        <div style="position: absolute; left: 5px; top: {{vid.height - 40}}px; width: {{vid.width - 10}}px;">
            <input type="range" min="0" max="{{vid.duration}}"  step="0.01" value="0.00" ng-model="time" ng-change="toTime()" class="video-range"/>
        </div>
      </div>
    </div>
'
  link: (scope, element)->
    scope.vid = element.find('video')[0]
    scope.volume = 1
    scope.time = 0
    window.video = scope.vid

    scope.playPause = ->
      if scope.vid.paused
        scope.vid.play()
        scope.fullScreen() if 768 > scope.vid.width
      else
        scope.vid.pause()

    scope.mute = ->
      if scope.vid.muted then scope.vid.muted = false else scope.vid.muted = true

    scope.fullScreen = ->
      if scope.vid.requestFullscreen
        scope.vid.requestFullscreen()
      else if scope.vid.mozRequestFullScreen
        scope.vid.mozRequestFullScreen()
      else if scope.vid.webkitRequestFullscreen
        scope.vid.webkitRequestFullscreen()

    scope.setVolume = ->
      scope.vid.volume = scope.volume

    scope.toTime = =>
      scope.vid.currentTime = String(scope.time)

    scope.updateTimeRange = =>
      scope.time = scope.vid.currentTime

    $interval(scope.updateTimeRange, 100)
