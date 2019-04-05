# JobFinder


### JobFinder is an iOS application uses third party providers to search for job.
### This application written in Swift using VIPER design pattern.

## Installation:
1. Install pods using "pod install".
2. Open workspace and route to "JobFinder"->"Utils"->"Constants" and change "googlePlacesApiKey" to your key.
3. Build and run.


## Customization:
- This application built to add new providers in very easy way, also you can control the number of data per page, simply you don't need to have any experience to make this application works or to add new providers.

### Add new provider:

- all providers are saved in json file called "providers.json"
- located in "JobFinder"->"Resources"->"providers.json"

- You can add new provider by copying one of the objects and append it to the json array after changing the info for this provider, and when you run the application, you will see that the new provider has been added.

- Now let's take a look at one of these objects to describe it's properties.

{

### Request Parameters for Github  https://jobs.github.com/api

- description — A search term, such as "ruby" or "java". This parameter is aliased to search.
- location — A city name, zip code, or other location search term.
- lat — A specific latitude. If used, you must also send long and must not send location.
- long — A specific longitude. If used, you must also send lat and must not send location.
- full_time — If you want to limit results to full time positions set this parameter to 'true'.


### Application Keys Mapper
```json
"displayName": "Github",                                                          
"searchBaseUrl": "https://jobs.github.com/positions.json",     
"httpMethod": "GET",                                                                
"searchUrlParameterKeys": {                                                     
"lat": "lat",                                                                                  
"lng": "long",                                                                              
"latLng": null,                                                                             
"position": "description",
"pageSize": null,
"pagination": "page",                                                               
"fromRecord": null
},
```
### Response Parameters for GitHub
```json
 {
 "id": "126c5b80-d626-11e8-9e0e-830fc841cb6b",
 "type": "Full Time",
 "url": "https://jobs.github.com/positions/126c5b80-d626-11e8-9e0e-830fc841cb6b",
 "created_at": "Mon Oct 22 18:13:39 UTC 2018",
 "company": "Resonate Capital, LLC",
 "company_url": null,
 "location": "San Francisco, CA",
 "title": "Data Engineer, Hedge Fund",
 "description": "job description",
 "how_to_apply": "\u003cp\u003ePlease send your resume to \u003ca href=\"mailto:resume@resonatecap.com\"\u003eresume@resonatecap.com\u003c/a\u003e\u003c/p\u003e\n",
 "company_logo": null
 }
```

### Application Keys Mapper
```json
"searchJobResponseParamterKeys": {
"companyLogo": "company_logo",
"jobTitle": "title",
"companyName": "company",
"location": "location",
"postDate": "created_at",
"postDateFormat": "EEE MMM dd HH:mm:ss Z yyyy",
"url": "url"
}
}
```

## Change page size or date format 

1. route to "JobFinder"->"Utils"->"Constants" and change "dataSizeInPage" to your page size.
2. route to "JobFinder"->"Utils"->"Constants" and change "dateFormat" to your date format.



## Best regards
## Ali Omari
## iOS developer
