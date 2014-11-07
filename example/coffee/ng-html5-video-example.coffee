angular.module('custom-video', ['ng-html5-video'])
.controller 'customVideoExample', ($scope)->
  $scope.width = 800
  $scope.height = 600
  $scope.mp4 = 'example/videos/example.mp4'
  $scope.ogv = 'example/videos/example.ogv'
  $scope.webm = 'example/videos/example.webm'
  true