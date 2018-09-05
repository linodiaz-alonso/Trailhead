({
    doInit: function(cmp) {
        console.log('hey!');
        //return;
		var action = cmp.get("c.getProfileName");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                cmp.set("v.ProfileName", response.getReturnValue());
                //window.location.href = "https://www.google.com";
                var profile = 'Standard';
                var currentProfile = response.getReturnValue();
                if(currentProfile.indexOf(profile) !== -1) {
                    console.log('Standard Profile');
                    window.location.href = "https://mpcanonicaldemo-developer-edition.eu6.force.com/C1";
                } else {
                    console.log('Non Standard Profile');
                    window.location.href = "https://mpcanonicaldemo-developer-edition.eu6.force.com/C2";
                }
                console.log(response.getReturnValue());
             }
          });
          $A.enqueueAction(action);
    }
})