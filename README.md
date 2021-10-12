<<<<<<< HEAD
# Hello Weedmaps!

Thank you so much for the opportunity to share my skills with you. I really enjoyed working on this and i'm excited to share it with you. I've built a Ruby on Rails API with unit tested CRUD endpoints for Patients and Identifications, with image upload and display endpoints, all hosted on Heroku. 

https://weedmaps-patient-api-gregdriza.herokuapp.com/

# Endpoints

 - **Patients**

	 - **CREATE** - POST - **/patients/new**
    `"patient": {
    "name"=>"Brick Spinkerton",
    "date_of_birth"=>"1994-10-22",
    "email"=>"Brick@Spinkerton.biz",
    "identifications"=>[{
	    "expiration_date"=>"2021-10-22",
	    "id_number"=>124557574,
	    "state_issuer"=>"NY"
    },{
	    "expiration_date"=>"2021-10-21",
	    "id_number"=>124357644,
	    "state_issuer"=>"NY"
    }]
  }`
  		 - Patients can be created with 0 to N number of Identifications.
	 - **READ** - GET Index/Show - **/patients or /patients/:id**
		 -  Return all Patients with their Identifications serialized or pass an ID to see a single patient.
	- **UPDATE** - PATCH  - **/patients/:id** 
	 - `{"patient": {
				"name"=>"Droe Gliden"
			}}`
	 - Can update one or more fields at a time. 
	 - Will throw if Patient isn't found
	 
	 -	**DELETE** - DELETE - **/patient/:id
		 -	The patient matching this id will never buy cannabis in this town ever again.
		 -	Throws if Patient cannot be found
 - **Identifications** 
	-	**CREATE**- POST - **/identifications/new**
		-	`{ "identification":{
				"expiration_date"=>"2021-10-22", 
				"id_number"=>124557574,
				"state_issuer"=>"NY"
				}}`
				
		 - `state_issuer` must be a valid US state initial. 
		 - Dates must be in format `YYYY-MM-DD` (this looks like it's a quirk of rails `Date.parse()`. Given more time, I'd probably find a better way to deal with time.
		 - `id_number` must be a unique 9 digit integer
	 - **READ** - GET - **/identifications** or **/identifications/:id** 
		 - Standard `index` and `show` routes
	 - **UPDATE** - UPDATE - **/identifications/:id**
		 - `{ "identification": {"id_number"=>987654321} }`
	- **DELETE** - DELETE - **/identifications/:id**
	- **UPLOAD** - POST - **/identifications/:id/upload**
		- Content-type: multipart/form-data with file of any format.
		- Doesn't seem to work on Heroku, will have to clone repo and try locally, posting to `localhost:3000`
		- Will update the `id_url` field on the identification passed through.
	- **GET_ID_IMAGE** - GET - **/identifications/:id/id_image**
		- Takes an Identification id and returns the uploaded image inline. Either click the link in postman or drop it in a browser.
	
	
**Things I would improve given a little more time**

 - Better error handling. Some of these endpoints are kind of brittle and easy to break. I'm returning error messages, but without knowledge of the implementation, some of them would be difficult to interpret. A good API would do a better job of articulating whats gone wrong. 
 - Tests for model validations in the controller. 
 - Better coverage of the controllers. Right now mostly "happy path" is being tested. There should probably be tests that assert that these methods throw when there is an issue.
 - Poor testing of the `upload` and `get_id_image` functionality. Testing that an image ends up in the filesystem turns out to be not that easy. I'd need a little more time to figure out how to do that properly. 
 
**Notes**

  - Run specs with `rspec spec/controllers/identifications_controller_spec.rb` or `rspec spec/controllers/patients_controller_spec.rb`
  - If you wan't to see where the majority of the important code is, jump to the commit 'application, database, and specs'
=======
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
>>>>>>> 954d1d18a2341852a7fac212f8b47be11023724a
