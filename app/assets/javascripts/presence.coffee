window.officeApp = officeApp = angular.module('officeApp', ['restangular']).run ['$compile', '$rootScope', '$document', ($compile, $rootScope, $document) ->
  $document.on 'page:load', ->
    body = angular.element('body')
    compiled = $compile(body.html())($rootScope)
    body.html(compiled)
]


officeApp.config((RestangularProvider) ->
  RestangularProvider.setBaseUrl('/api/')
)

officeApp.controller 'RoomController', ['$scope', 'Restangular', '$timeout', ($scope, Restangular, $timeout) ->
  $scope.occupied = false
  
  Restangular.all("rooms/#{window.room_id}").customGET().then((r)->
    $scope.room = r.room
    $scope.occupied = (r.room.users.length > 0)
  )

  setInterval((->
    Restangular.all("rooms/#{window.room_id}").customGET().then((r)->
      $scope.room = r.room
      $scope.occupied = (r.room.users.length > 0)
    )
  ), 1000);
]

officeApp.controller 'RoomsController', ['$scope', 'Restangular', '$timeout', ($scope, Restangular, $timeout) ->
  Restangular.all("rooms").customGET().then((r)->
    $scope.rooms = r.rooms
  )
  setInterval((->
    Restangular.all("rooms").customGET().then((r)->
      $scope.rooms = r.rooms
    )
  ), 1000);
]

officeApp.controller 'TagController', ['$scope', 'Restangular', '$timeout', ($scope, Restangular, $timeout) ->
  $scope.save = (tag, tagForm) ->
    if !tagForm.$valid
      alert("Invalid form")
      return;
    Restangular.all("tags").post({tag: tag}).then((r)->
      document.location = "/rooms"
    )
]