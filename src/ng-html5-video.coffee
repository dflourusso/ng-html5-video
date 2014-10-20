angular.module('ng-html5-video', [])
.directive 'ngHtml5Video', ->
  restrict: 'E'
  scope:
    width: '=?'
    height: '=?'
    mp4: '=?'
    ogv: '=?'
    webm: '=?'
  template: '
      <video id="video" width="{{width}}" height="{{height}}" controls>
        <source src="{{webm}}" type="video/webm">
        <source src="{{ogv}}" type="video/ogv">
        <source src="{{mp4}}" type="video/mp4">
		    <p>
          <a href="{{mp4}}">Download</a>
        </p>
      </video>
'
#  link: (scope, element)->