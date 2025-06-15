
Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
    classVariableNames: ''
    package: 'RideSharing'.

Ride >> initializeWithID: id pickup: pickup dropoff: drop dist: dist [
    rideID := id.
    pickupLocation := pickup.
    dropoffLocation := drop.
    distance := dist.
]

Ride >> rideDetails [
    ^ 'Ride ID: ', rideID, ', From: ', pickupLocation, ' To: ', dropoffLocation, ', Distance: ', distance asString, ' miles'
]

Ride >> fare [
    self subclassResponsibility
]

Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'RideSharing'.

StandardRide >> fare [
    ^ distance * 2.0
]

Ride subclass: #PremiumRide
    instanceVariableNames: ''
    classVariableNames: ''
    package: 'RideSharing'.

PremiumRide >> fare [
    ^ (distance * 4.0) + 5.0
]

Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    package: 'RideSharing'.

Driver >> initializeWithID: id name: driverName rating: rate [
    driverID := id.
    name := driverName.
    rating := rate.
    assignedRides := OrderedCollection new.
]

Driver >> addRide: aRide [
    assignedRides add: aRide.
]

Driver >> getDriverInfo [
    Transcript show: 'Driver: ', name, ' (', driverID, '), Rating: ', rating asString; cr.
    assignedRides do: [:r |
        Transcript show: (r rideDetails); cr.
        Transcript show: 'Fare: $', (r fare asString); cr; cr.
    ].
]

Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    package: 'RideSharing'.

Rider >> initializeWithID: id name: riderName [
    riderID := id.
    name := riderName.
    requestedRides := OrderedCollection new.
]

Rider >> requestRide: aRide [
    requestedRides add: aRide.
]

Rider >> viewRides [
    Transcript show: 'Rider: ', name, ' (', riderID, ') Ride History:'; cr.
    requestedRides do: [:r |
        Transcript show: (r rideDetails); cr.
        Transcript show: 'Fare: $', (r fare asString); cr; cr.
    ].
]

"Test Script"
| r1 r2 driver rider |

r1 := StandardRide new.
r1 initializeWithID: 'R1' pickup: 'A' dropoff: 'B' dist: 10.

r2 := PremiumRide new.
r2 initializeWithID: 'R2' pickup: 'C' dropoff: 'D' dist: 8.

driver := Driver new.
driver initializeWithID: 'D1' name: 'Alice' rating: 4.8.
driver addRide: r1.
driver addRide: r2.

rider := Rider new.
rider initializeWithID: 'U1' name: 'Bob'.
rider requestRide: r1.
rider requestRide: r2.

driver getDriverInfo.
rider viewRides.
