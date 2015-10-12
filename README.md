Zaidsoft Webmail
==================

JSP based webmail application by Zaidsoft.

For more information please see [the website][1].

This is initial code drop. We are open sourcing an old project and code style (or latest JSP best practices may not apply). We intend to improve the code with latest practices on continueous basis. Pull requests are always welcome!

Download
--------

Following download/repo options are for future release 1.0.0-prealpha1. May not work for now.

Download [the latest JAR][2] or grab via Maven:
```xml
<dependency>
  <groupId>com.zaidsoft.webmail</groupId>
  <artifactId>webmail</artifactId>
  <version>1.0.0-prealpha1</version>
</dependency>
```
or Gradle:
```groovy
compile 'com.zaidsoft.webmail:webmail:1.0.0-prealpha1'
```

Snapshots of the development version are available in [Sonatype's `snapshots` repository][snap].

webmail requires at minimum Java 6 and Tomcat 6.x  or later.

Objective
---------------

Provide an easy to use web mail interface for checking and sending mails using nothing but web browser.

* Connects to any arbitrary IMAP server
* Single instalation of this webapp can be used by almost any mail user to check her mail
* Simplicity
* Usability
* Lightweight
* Cross Browser
* Extensible and embeddable


Resources / Links
----------
* http://maven.apache.org/
* http://en.wikipedia.org/wiki/Javamail
* http://en.wikipedia.org/wiki/Email
* http://tools.ietf.org/html/rfc822
* http://en.wikipedia.org/wiki/IMAP
* http://tools.ietf.org/html/rfc1730
* http://en.wikipedia.org/wiki/SMTP
* http://tools.ietf.org/html/rfc821




License
=======

    Copyright 2015 ZAIDSOFT.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


 [1]: http://zaidsoft.github.io/webmail/
 [2]: https://search.maven.org/remote_content?g=com.zaidsoft.webmail&a=webmail&v=LATEST
 [snap]: https://oss.sonatype.org/content/repositories/snapshots/
