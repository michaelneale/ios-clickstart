import play.api._
import play.api.Play.current
import play.api.libs.json._
import play.api.libs.ws._    
import com.ning.http.client.Realm.AuthScheme
import play.api.libs.concurrent.Execution.Implicits._


package couch {
    object CouchDB {


        def search(key: String) = {        
            val con = connection.getOrElse(null)                
            println("Searching for:" + key)
            WS.url(con.url + "/" + con.db + "/" + key).withAuth(con.user, con.pass, AuthScheme.BASIC).get()        
        }

        def store(key: String, value: String) = {
            println("Storing key:"+key + " with value:" + value)
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

        /** is run on startup - check if DB exists, if not, create it*/
        def initialize() = {
            
            connection.map { con => 
                        WS.url(con.url + "/" + con.db + "/")
                        .withAuth(con.user, con.pass, AuthScheme.BASIC)
                        .get().map{ response => 
                            if (response.status != 200) {
                                create_db(con)
                            }
                        }
            }
        }

        def create_db(con: Conn) = {
            println("Creating database " + con.db)
            WS.url(con.url + "/" + con.db + "/")
                .withAuth(con.user, con.pass, AuthScheme.BASIC).put("").map { 
                    response => 
                        println("Created DB response: " + response.status)    
                }
        }
    }
}

object Global extends GlobalSettings {
  import couch._
  override def onStart(app: Application) {
    CouchDB.initialize();
  }      
}