package sample.handler

import org.vertx.java.core.Handler
import org.vertx.java.core.http.HttpServerRequest

class RootHandler implements Handler
  def handle(req):void
    HttpServerRequest(req).response.setStatusCode(200).end("Hello, world")
  end
end
