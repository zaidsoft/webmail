function Protect(b) {
}



function httpURLify(s) {
    //check the string to see if it srarts with http:// if not ad it
    // if user wants to edit arb URL but has not given the url, Warn.
    if (s == "") {
        alert("Please enter a valid web address(url)");
        return false;
    }
    else {
        // it should start with http:// else ad this at the begining.
        if (s.indexOf("http://") != 0)
            s = "http://" + s;

        // now check if url is of the form http://a.b.somthing.tld if y add a '/'
        if (s.substring(7).indexOf("/") == -1)
            s = s + "/";
        // return this string now
        return s;
    }
}