# Scheduler App

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
It's an app that creates a map for you to your classes based on the schedule that you input.

### App Evaluation
- **Category:** Educational/Map
- **Mobile:** Yes
- **Story:** Analayzes user's schedule and creates a map for them to get to their classes
- **Market:** UMD Students
- **Habit:** Very Often 
- **Scope:** UMD Campus, could later expand to other college campuses

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] user creates account/log in to account
- [  ] user uploads schedule 
- [  ] view full schedule/make changes to schedule
- [  ] map of the schedule w/ directions 

**Optional Nice-to-have Stories**

- [  ]  settings
- [  ]  multiple schedules
- [  ]  linking google calendar schedule

### 2. Screen Archetypes

* Login Screen
   * user creates account/logs into account
* Schedule Screen
   * user uploads schedule 
   * view full schedule/make changes to schedule
* Map Screen
   * map of the schedule w/ directions 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Schedule in List Form
* Schedule in Map Form 
* Settings 

**Flow Navigation** (Screen to Screen)

* Login
   * Create Account Screen
* Viewing Schedule 
   * Edit Schedule
   * Map Screen


## Wireframes

<img src="https://i.imgur.com/T2V3ia4.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
User
| Property | Type | Description |
| -------- | -------- | -------- |
| username     | String     | user unique name     |
| password     | String     | user password     |
| uid     | number     | user unique identifier    |

Calendar
| Property | Type | Description |
| -------- | -------- | -------- |
| id     | String     |  unique id for an event     |
| event_name     | String     | user event     |
| start_time     | datetime     | time format(MMddYYY HH:MM)    |
| end_time     | datetime     | time format(MMddYYY HH:MM)    |
|destination     | String     | User destination     |
|current_location    | String     | User current location     |

UMD Maps
| Property | Type | Description |
| -------- | -------- | -------- |
| acr     | String     |  unique acronym for UMD building     |
| name     | String     |  UMD building name   |
| lat     | number     |  UMD building Latitude coordinate   |
| long     | number     |  UMD building Longitude coordinate   |

### Networking
#### List of network requests by screen
- Login Screen
    - (CREATE/POST) create a new user
    - (READ/GET) user login
      ```swift=
      let query = PFQuery(className:"Calendar")
      query.whereKey(“id”, equalTo: currentUser)
      query.order(byDescending: “start_time”)
      query.findObjectsInBackground { (calendars: [PFObject]?, error: Error?) in
         if let error = error { 
            print(error.localizedDescription)
         } else if let calendars = calendars {
            print("Successfully retrieved \(calendars.count) days of a calendar.”)
        // TODO: Do something with calendar...
         }
      }
      ```
- Profile Screen
    - (Read/GET) User can see their information
    - (Update/PUT) User can update their information

#### Existing API Endpoints
##### Google Maps API
- Base URL: https://maps.googleapis.com/maps/api/

| HTTP Verb | Endpoint | Description |
| -------- | -------- | -------- |
| GET     | place/findplacefromtext/json | search for place information     |
| GET     | place/details/json | details about place id    |
| GET     | distancematrix/json | travel distance and time between two points     |
| GET     | geocode/json | geocode a text address into longitude and latitude     |

##### Google Calender API
- Base url: https://www.googleapis.com/calendar/v3

| HTTP Verb | Endpoint | Description |
| -------- | -------- | -------- |
| GET     | /calendars/calendarId/events/eventId| returns an event     |
| POST     | /calendars/calendarId/events | creates an event   |
| PUT     | /calendars/calendarId/events/eventId | updates an event     |

