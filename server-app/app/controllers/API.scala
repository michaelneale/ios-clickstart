package controllers

import play.api._
import play.api.libs.json._
import play.api.mvc._
import stemming._
import couch._
import play.api.libs.concurrent.Execution.Implicits._

object API extends Controller {
  

  /** Search for the stemmed query */
  def search(query:String) = Action {   
    Async {
        CouchDB.search(StringStemmer.stem(query)).map { response => 
            if (response.status == 404) 
                NotFound("No match")
             else 
                Ok(Json.toJson(Map("result" -> (response.json \ "content").as[String])))
        }
    }    
  }


  /** Store the doc - use the first line, stemmed, as the key */

  def store(doc:String) = Action {            
    val stemmed_key = StringStemmer.stem( doc.split("\n")(0))   
    Async {
        CouchDB.store(stemmed_key, doc).map { response => 
            Ok(Json.toJson(Map("result" -> "ok")))
        }    
    }
  }
}


