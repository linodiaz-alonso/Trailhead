({
	getInput : function(cmp, event) {
      var fullName = cmp.find("salutation").get("v.value") + cmp.find("first").get("v.value") + cmp.find("last").get("v.value") + cmp.find("phone").get("v.value");
      var outName = cmp.find("nameOutput");
      outName.set("v.value", fullName);
    }
})