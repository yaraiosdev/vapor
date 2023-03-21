# Vapor Api Grading System



## Table of Contents

- [Introduction](#introduction)
- [Structure](#structure)
- [Endpoints](#endpoints)
  - [Anatomy of an endpoint](#anatomy-of-an-endpoint)
  - [Request methods](#request-methods)
  - [Examples](#examples)



 


- [HTTP Response Status Codes](#http-response-status-codes)
- [Response](#response)
  - [Errors](#errors)
    - [Vapor 1](#vapor-1)
    - [Vapor 2](#vapor-2)
  - [Examples](#examples-1)
    - [A single item](#a-single-item)
    - [A request without data to return](#a-request-without-data-to-return)
    - [A wrong endpoint](#a-wrong-endpoint)
    - [A wrong input](#a-wrong-input)
    - [A collection of items](#a-collection-of-items)


  
## Introduction
This document will show our grading system API built using the Vapor web framework and Fluent ORM framework for Swift.
We will show the Structure of this API and its endpoints and how exactly to use this API.
<div align="center">

![8c5be280-5bbd-11ea-83c7-7fb50300e4df ](https://user-images.githubusercontent.com/40645258/226743772-f9c99ff5-6451-4a65-8533-c5505c551627.png )

  </div>

# Structure
```
├── Sources
│   └── app
│       ├── Controllers // Our API Controllers
│       │       ├── coursesController.swift  
│       │       ├── GradeController.swift 
|       |       ├── StudenController.swift
│       │       └── inspectorController.swift   
│       ├── Models
|       |      ├── course.swift
|       |      ├── grade.swift
|       |      ├── inspector.swift
|       |      └── student.swift
|       |
|       ├── configure.swift //  database migrations 
|       |        
│       └── routes.swift //file contains the routes(_:)function. This method is called near the end of configure(_:) to register
└── Run
    └── main.swift      
```

# Endpoints

Endpoints with literal and readable URLs are what make an API awesome. To make everything easy and convenient for you, we have specified how you should do it.

## Anatomy of an endpoint

The anatomy of an endpoint should look like this:
### Instructor
#### all the Instructor endpoint 
```
/api/Instructor
```
#### the Instructor by id endpoint 
```
/api/Instructor/{Instructor_Id}
```
### Student
#### all the Instructor endpoint 
```
/api/student
```
#### the course by id endpoint 
```
/api/student/{student_Id}
```
### Courses
#### all the courses endpoint 
```
/api/course
```
#### the course by id endpoint 
```
/api/course /{course_Id}
```
#### all the courses from a specific Instructor endpoint 
```
/api/course/getInstrctorCourses/{Instructor_Id}
```
### Grades
#### all the grades endpoint 
```
/api/grade
```
#### the grade by id endpoint 
```
/api/grade/{grade_Id}
```
#### all the grades for a specific student endpoint 
```
/api/grade/getStudent/{student_Id}
```
#### all the grades for a specific course endpoint 
```
/api/grade/getcourse/{course_Id}
```



### Request methods

The request method is the way we distinguish what kind of action our endpoint is being "asked" to perform. For example, `GET` pretty much gives itself. But we also have a few other methods that we use quite often.

| Method   | Description                              |
| -------- | ---------------------------------------- |
| `GET`    | Used to retrieve a single item or a collection of items. |
| `POST`   | Used when creating new items e.g. a new user, post, comment etc. |
| `PUT`    | Used to replace a whole item (all fields) with new data. |
| `DELETE` | Used to delete an item.                  |

### Examples

Now that we’ve learned about the anatomy of our endpoints and the different request methods that we should use, it’s time for some examples:

| Method   | URL                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/Instructor`                        | Retrieve all instructors.                 |
| `POST`   | `/api/Instructor`                        | Create a new Instructor.                       |
| `GET`    | `/api/Instructor/30`                     | Retrieve instructor with id 30.          |
| `POST`   | `/api/course `                           | Add a new course  to post #28.           |
| `GET`    | `/api/grade/getStudent/300` | Retrieve the grades of the student with the id 300    |
| `DELETE` | `/student/300 | Delete the student with id 300.`                 |
| `GET`    | `/api/course/getInstrctorCourses/30` |  Get all the courses that are being taught by the instructor  with id 30 |



## HTTP Response Status Codes

One of the most important things in an API is how it returns response codes. Each response code means a different thing and consumers of your API rely heavily on these codes.

| Code  | Title                     | Description                              |
| ----- | ------------------------- | ---------------------------------------- |
| `200` | `OK`                      | When a request was successfully processed (e.g. when using `GET`, `PATCH`, `PUT` or `DELETE`). |
| `201` | `Created`                 | Every time a record has been added to the database (e.g. when creating a new user or post). |
| `304` | `Not modified`            | When returning a cached response. |
| `400` | `Bad request`             | When the request could not be understood (e.g. invalid syntax). |
| `401` | `Unauthorized`            | When authentication failed. |
| `403` | `Forbidden`               | When an authenticated user is trying to perform an action, which he/she does not have permission to. |
| `404` | `Not found`               | When URL or entity is not found. |
| `440` | `No accept header`        | When the required "Accept" header is missing from the request. |
| `422` | `Unprocessable entity`    | Whenever there is something wrong with the request (e.g. missing parameters, validation errors) even though the syntax is correct (ie. `400` is not warranted). |
| `500` | `Internal server error`   | When an internal error has happened (e.g. when trying to add/update records in the database fails). |
| `502` | `Bad Gateway`             | When a necessary third party service is down. |

The response codes often have very precise definition and are easily misunderstood when just looking at their names. For example, `Bad Request` refers to malformed requests and not, as often interpreted, when there is something semantically wrong with the reuquest. Often `Unprocessable entity` is a better choice in those cases.
Another one that is often used incorrectly is `Precondition Failed`. The precondition this status code refers to are those defined in headers like `If-Match` and `If-Modified-Since`. Again, `Unprocessable entity` is usually the more appropriate choice if the request somehow isn't valid in the current state of the server.
When in doubt, refer to [this overview](https://httpstatuses.com) and see if the description of an status code matches your situation.

## Response

Generally we have a few rules the response has to follow:

- Root should always be returned as an object.
- Keys should always be returned as camelCase.
- When we don’t have any data, we need to return in the following way:
  - Collection: Return empty array.
  - Empty key: Return null or unset the key.
- Consistency of key types. e.g. always return IDs as an integer in all endpoints.
- Date/timestamps should always be returned with a time zone.
- Content (being a single object or a collection) should be returned in a key (e.g. `data`).
- Pagination data should be returned in a `meta` key.
- Endpoints should always return a JSON payload.
  - When an endpoint doesn't have meaningful data to return (e.g. when deleting something), use a `status` key to communicate the status of the endpoint.

### Errors

When errors occur the consumer will get a JSON payload verifying that an error occurred together with a reason for why the error occurred. 

Error handling has changed from Vapor 1 through 3, these are the keys to expect from the different versions.

#### Vapor 3

| Endpoint   | Description                              |
| ---------- | ---------------------------------------- |
| `error`    | A boolean confirming an error occurred.  |
| `reason`   | A description of the error that occurred. For some errors this value provides extra information on non-production environments. |

#### Vapor 2

| Endpoint   | Description                              |
| ---------- | ---------------------------------------- |
| `error`    | A boolean confirming an error occurred.  |
| `reason`   | A description of the error that occurred. |
| `metadata` | Any custom metadata that might be included. **Only** available on a non-production environment. |

#### Vapor 1

| Key        | Description                              |
| ---------- | ---------------------------------------- |
| `code`     | The HTTP code.                           |
| `error`    | A boolean confirming an error occurred.  |
| `message`  | A description of the error that occurred. |
| `metadata` | Any custom metadata that might be included. **Only** available on a non-production environment. |

### Examples

Just to round it all off, here’s a few examples of how our response will return depending on whether you’re about to return a single item, a collection or a paginated result set.

#### A single item

```
{
    "instuctor_id": {
        "id": "29"
    },
    "id": "1",
    "courseName": "math"
}
```

#### A request without data to return

```
[]

```
#### A wrong endpoint
```
{
    "error": true,
    "reason": "Not Found"
}
```
#### A wrong input

```
{
    "error": true,
    "reason": "Bad Request"
}
```

#### A collection of items

```
[
    {
        "id": "1",
        "instuctor_id": {
            "id": "29",
            "instructorName": "reema"
        },
        "courseName": "math"
    },
    {
        "id": "3",
        "instuctor_id": {
            "id": "29",
            "instructorName": "reema"
        },
        "courseName": "algebra"
    },
    {
        "id": "4",
        "instuctor_id": {
            "id": "300",
            "instructorName": "duaa"
        },
        "courseName": "web"
    },
    {
        "id": "5",
        "instuctor_id": {
            "id": "300",
            "instructorName": "duaa"
        },
        "courseName": "C++"
    }
]
```

