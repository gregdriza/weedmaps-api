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
		-	`{
				"expiration_date"=>"2021-10-22", 
				"id_number"=>124557574,
				"state_issuer"=>"NY"
				}`
				
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
 - 