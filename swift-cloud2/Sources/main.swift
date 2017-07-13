//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer



// Create HTTP server.
let server = HTTPServer()

// Register your own routes and handlers
var routes = Routes()
routes.add(method: .get, uri: "/index.html", handler: {
		request, response in
		response.setHeader(.contentType, value: "text/html")

        let handler = StaticFileHandler(documentRoot: request.documentRoot)
        handler.handleRequest(request: request, response: response)
    
		response.completed()
	}
)


server.addRoutes(routes)

server.serverPort = 8181

server.documentRoot = "./webroot"

configureServer(server)

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
