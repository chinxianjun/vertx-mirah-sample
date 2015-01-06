package sample.handler

import org.vertx.java.core.http.HttpServerRequest

class RootHandler < RequestHandler
  def handle(req:HttpServerRequest):void
    req.response.setStatusCode(200).end("Hello, world")
  end
end
