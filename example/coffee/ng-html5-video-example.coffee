angular.module('custom-video', ['ng-html5-video'])
.controller 'customVideoExample', ($scope)->
  $scope.width = 800
  $scope.height = 600
  $scope.mp4 = 'example/videos/mikethefrog.mp4'
  $scope.ogv = 'example/videos/mikethefrog.ogv'
  $scope.webm = 'example/videos/mikethefrog.webm'