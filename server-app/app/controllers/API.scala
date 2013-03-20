package controllers

import play.api._
import play.api.libs.json._
import play.api.mvc._
import play.api.Play.current
import stemming._
import play.api.libs.concurrent.Execution.Implicits._

object API extends Controller {
  

  /** Search for the stemmed query */
  def search(query:String) = Action {   
    println("searching for " + query) 
    Async {
        CouchDB.search(StringStemmer.stem(query)).map { response => 
            Ok(Json.toJson(Map("result" -> (response.json \ "content").as[String])))
        }
    }    
  }


  /** Store the doc - use the first line, stemmed, as the key */

  def store(doc:String) = Action {         
    println("storing " + doc)
    val stemmed_key = StringStemmer.stem( doc.split("\n")(0))
    println("Stemmed key is:" + stemmed_key)
    Async {
        CouchDB.store(stemmed_key, doc).map { response => 
            Ok(Json.toJson(Map("result" -> "ok")))
        }    
    }
  }
}


object CouchDB {

    import play.api.libs.ws._    
    import com.ning.http.client.Realm.AuthScheme
    def search(key: String) = {        
        val con = connection.getOrElse(null)                
        WS.url(con.url + "/" + con.db + "/" + key).withAuth(con.user, con.pass, AuthScheme.BASIC).get()        
    }

    def store(key: String, value: String) = {
        val con = connection.getOrElse(null)                
        WS.url(con.url + "/" + con.db + "/" + key)
        .withAuth(con.user, con.pass, AuthScheme.BASIC)
        .put(Json.toJson(Map("content" -> value)))        
    }

    val config = Play.application.configuration;    
    case class Conn(url: String, user:String, pass:String, db:String)
    val connection = for {
        url <- config.getString("couch.db.url")                 
        user <- config.getString("couch.db.user")
        pass <- config.getString("couch.db.password")
        db <- config.getString("couch.db.name")        
        } yield {
        Conn(url, user, pass, db)
    }





}