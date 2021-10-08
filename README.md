# Scenario
In many jurisdictions where cannabis is legal for medical use, providers must maintain current records for their patients in case of compliance audit. Many providers, commonly known as “dispensaries”, turn to Software-as-a-Service solutions to maintain their patient database.

You’ll be building a small API that provides the backend functionality for such patient management software. The API will store and retrieve this patient data.

# Feature requirements
Create an application that provides an API to store and retrieve data on patients and patients’ government-issued identifications, such as a driver’s license or passport.

### Data to store:
* Patient’s name, email address and date of birth
* Patient’s Identification number (such as driver’s license number), state issuer, expiration date
* A URL reference to the patient’s identification (as if a scan was uploaded to cloud storage)
  * Note: This need not be a true, accessible URL. “Faked” URLs are fine

### API functionality:
* CRUD (Create, Read, Update, Delete) routes are available for each patient and identification record
* “Read” routes should return the above stored fields for each patient and identification record
* In API responses where an identification is included, calculate the current expiration status (“is this record expired?“) based on the stored expiration date. This should be returned alongside the other stored fields

# Submission requirements
* Separate auto-generated code and code you wrote “by hand” into distinct commits
* Please provide tests that confirm the functionality of your code
* Open a PR merging your code into the main branch when your application is complete
* Make sure your commits are easy to read and understandable

# Some tips when doing the challenge
* There is not a hard time requirement. We respect that while juggling work and life, it can be difficult to find a solid block of time for a code challenge. Feel free to spend your time over as many days as necessary. We hope that will not take more than 3-4 hours of your time. If you estimate it will take much more, please reach out to a recruiter
* To keep the review process anonymous, please do not include identifying information in code comments, commit messages or branch names
* Otherwise, follow the development practice and standards most familiar to you

# Additional features: not required!
We have defined a few optional features for prospects that may have extra time remaining. We request that, if you have spent more than 4 hours on the Feature Requirements, you do not spend more time on any of the below features. Consider them as discussion topics for future conversations, rather than “bonus points” to be earned or missed.

### Store Medical Recommendation in addition to Government ID
Medical cannabis providers are also required to validate that patients have a current “Medical Recommendation” (colloquially known as a “rec”) on each visit to a dispensary. A medical recommendation is a document from a physician asserting to the provider that they find cannabis to be an acceptable treatment for a patient’s ailment. Many providers will collect a scan of the recommendation on first visit to a dispensary so patients are not required to have the document on hand for subsequent visits.

* Extend the API functionality to store and retrieve Medical Recommendation records
* Each recommendation has fields: recommendation number, state where valid, physician issuer, expiration date and URL reference
* CRUD routes are available for each Medical Recommendation
* In API responses where a recommendation is included, calculate the current expiration status (“is this record expired?“) based on the stored expiration date. This should be returned alongside the other stored fields

### Upload documents
* Replace the “fake” URL reference on the government identification and/or medical recommendation model(s) with the ability to store and retrieve a real file
* The URL returned in API responses containing the identification or medical recommendation should point to the uploaded file
* The upload and storage strategy is left to you to define

### Deploy your application
* Deploy your application to a publicly-accessible environment so our reviewers can play with your API endpoints
* This can be a Heroku dyno, AWS cluster, private server or anything in between

Have fun building your small piece of cannabis tech! If any aspect of this prompt is unclear, or if you have questions while working through it, please get in touch and we’ll help clarify any points.
