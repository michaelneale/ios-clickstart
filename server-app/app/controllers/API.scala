package controllers

import play.api._
import play.api.libs.json._
import play.api.mvc._

object API extends Controller {
  
  def show_data = Action {
    Ok(Json.toJson(Map("result" -> "data here")))
  }

}