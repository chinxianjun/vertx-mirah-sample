package sample.handler;

import org.vertx.java.core.Handler;
import org.vertx.java.core.http.HttpServerRequest;

public abstract class RequestHandler implements Handler<HttpServerRequest> {
    public abstract void handle(HttpServerRequest req);
}
