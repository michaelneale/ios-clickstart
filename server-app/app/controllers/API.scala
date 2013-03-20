package controllers

import play.api._
import play.api.libs.json._
import play.api.mvc._
import play.api.Play.current

object API extends Controller {
  
  def search(query:String) = Action {    
    println(Play.application.configuration.getString("couch.db.url"))
    Ok(Json.toJson(Map("result" -> ("data here " + System.currentTimeMillis) )))
  }

  def store(doc:String) = Action { 
        println("Storing " + doc)
        Ok(Json.toJson(Map("result" -> "ok")))
  }


}