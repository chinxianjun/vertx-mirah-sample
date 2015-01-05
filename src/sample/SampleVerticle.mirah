package sample

import org.vertx.java.core.Handler
import org.vertx.java.core.Vertx
import org.vertx.java.core.http.HttpServer
import org.vertx.java.core.http.HttpServerRequest
import org.vertx.java.core.http.RouteMatcher
import org.vertx.java.platform.Verticle

import sample.handler.RootHandler

class SampleVerticle < Verticle
  def start: void
    vertx = self.getVertx
    r = RouteMatcher.new
    r.all("/", RootHandler.new)
    server = vertx.createHttpServer
    server.requestHandler(r).listen(8080)
  end
end
